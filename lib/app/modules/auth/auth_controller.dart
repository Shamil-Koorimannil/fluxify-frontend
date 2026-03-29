import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

class AuthController extends GetxController {
  // Form controllers
  final emailPhoneController = TextEditingController();
  final otpController = TextEditingController();

  // Form focus nodes
  final emailPhoneFocusNode = FocusNode();
  final otpFocusNode = FocusNode();

  // Reactive variables
  var isLoading = false.obs;
  var isEmailPhoneValid = false.obs;
  var isOtpValid = false.obs;
  var isOtpSent = false.obs;
  var authMode = AuthMode.emailPhone.obs;

  // Timer for OTP
  var otpTimer = 60.obs;
  late Timer _timer;

  @override
  void onInit() {
    super.onInit();
    _setupListeners();
  }

  @override
  void onClose() {
    emailPhoneController.dispose();
    otpController.dispose();
    emailPhoneFocusNode.dispose();
    otpFocusNode.dispose();
    if (_timer.isActive) _timer.cancel();
    super.onClose();
  }

  void _setupListeners() {
    // Email/Phone validation
    emailPhoneController.addListener(() {
      final value = emailPhoneController.text.trim();
      isEmailPhoneValid.value = _validateEmailPhone(value);
    });

    // OTP validation
    otpController.addListener(() {
      final value = otpController.text.trim();
      isOtpValid.value =
          value.length == 6 && RegExp(r'^[0-9]{6}$').hasMatch(value);
    });
  }

  bool _validateEmailPhone(String value) {
    if (value.isEmpty) return false;

    // Email validation
    if (RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return true;
    }

    // Phone validation (10 digits for Indian numbers)
    if (RegExp(r'^[6-9]\d{9}$').hasMatch(value)) {
      return true;
    }

    return false;
  }

  void sendOtp() async {
    if (!isEmailPhoneValid.value) return;

    isLoading.value = true;

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Success
      isOtpSent.value = true;
      authMode.value = AuthMode.otp;
      _startOtpTimer();

      Get.snackbar(
        'OTP Sent',
        'Verification code sent to ${emailPhoneController.text}',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to send OTP. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void verifyOtp() async {
    if (!isOtpValid.value) return;

    isLoading.value = true;

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Success - Navigate to home
      Get.snackbar(
        'Success',
        'Login successful!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // TODO: Navigate to home screen
      // Get.offAllNamed('/home');
    } catch (e) {
      Get.snackbar(
        'Error',
        'Invalid OTP. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void resendOtp() async {
    otpTimer.value = 60;
    _startOtpTimer();
    sendOtp();
  }

  void _startOtpTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (otpTimer.value > 0) {
        otpTimer.value--;
      } else {
        timer.cancel();
      }
    });
  }

  void changeAuthMode(AuthMode mode) {
    authMode.value = mode;
    if (mode == AuthMode.emailPhone) {
      // Clear OTP field when switching back
      otpController.clear();
      isOtpValid.value = false;
    }
  }

  void clearForm() {
    emailPhoneController.clear();
    otpController.clear();
    isEmailPhoneValid.value = false;
    isOtpValid.value = false;
    isOtpSent.value = false;
    authMode.value = AuthMode.emailPhone;
    if (_timer.isActive) _timer.cancel();
    otpTimer.value = 60;
  }
}

enum AuthMode { emailPhone, otp }
