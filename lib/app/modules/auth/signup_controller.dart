import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUpController extends GetxController {
  // Form controllers
  final emailPhoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Form focus nodes
  final emailPhoneFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final confirmPasswordFocusNode = FocusNode();

  // Reactive variables
  var isLoading = false.obs;
  var isEmailPhoneValid = false.obs;
  var isPasswordValid = false.obs;
  var isConfirmPasswordValid = false.obs;
  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;
  var isFormValid = false.obs;

  // Google Sign-In
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  var googleSignInUser = Rx<GoogleSignInAccount?>(null);

  @override
  void onInit() {
    super.onInit();
    _setupListeners();
  }

  @override
  void onClose() {
    emailPhoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    emailPhoneFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    super.onClose();
  }

  void _setupListeners() {
    // Email/Phone validation
    emailPhoneController.addListener(() {
      final value = emailPhoneController.text.trim();
      isEmailPhoneValid.value = _validateEmailPhone(value);
      _validateForm();
    });

    // Password validation
    passwordController.addListener(() {
      final value = passwordController.text;
      isPasswordValid.value = _validatePassword(value);
      _validateForm();
    });

    // Confirm password validation
    confirmPasswordController.addListener(() {
      final value = confirmPasswordController.text;
      isConfirmPasswordValid.value = _validateConfirmPassword(value);
      _validateForm();
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

  bool _validatePassword(String value) {
    return value.length >= 6;
  }

  bool _validateConfirmPassword(String value) {
    return value == passwordController.text && value.isNotEmpty;
  }

  void _validateForm() {
    isFormValid.value = isEmailPhoneValid.value && 
                       isPasswordValid.value && 
                       isConfirmPasswordValid.value;
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void signUp() async {
    if (!isFormValid.value) return;

    isLoading.value = true;

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      Get.snackbar(
        'Success',
        'Account created successfully!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // TODO: Navigate to home screen
      // Get.offAllNamed('/home');
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to create account. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser != null) {
        googleSignInUser.value = googleUser;
        
        Get.snackbar(
          'Success',
          'Signed in with Google successfully!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // TODO: Navigate to home screen
        // Get.offAllNamed('/home');
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Google sign-in failed. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void goToLogin() {
    // TODO: Navigate to login screen
    // Get.toNamed('/login');
  }

  void clearForm() {
    emailPhoneController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    isEmailPhoneValid.value = false;
    isPasswordValid.value = false;
    isConfirmPasswordValid.value = false;
    isFormValid.value = false;
    isPasswordVisible.value = false;
    isConfirmPasswordVisible.value = false;
  }
}
