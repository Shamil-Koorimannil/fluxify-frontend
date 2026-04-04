import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../routes/app_pages.dart';

class AuthController extends GetxController {
  // 1. Updated Form Controllers
  final emailPhoneController = TextEditingController();
  final passwordController = TextEditingController(); // Added this!

  // 2. Reactive variables
  var isLoading = false.obs;
  var isPasswordVisible = false.obs; // For the eye icon toggle

  // Google Sign-In
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  var googleSignInUser = Rx<GoogleSignInAccount?>(null);

  @override
  void onClose() {
    emailPhoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  // 3. Toggle Password Visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // 4. Updated Login Logic
  void login() async {
    final email = emailPhoneController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter both email and password',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    try {
      // TODO: Connect to Shamil's Backend API here
      await Future.delayed(const Duration(seconds: 2)); // Simulating network

      Get.snackbar(
        'Success',
        'Welcome back to Fluxify!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.8),
        colorText: Colors.white,
      );

      // Navigate to Home after successful login
      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      Get.snackbar('Error', 'Login failed. Check your credentials.');
    } finally {
      isLoading.value = false;
    }
  }

  // 5. Google Sign-In Method
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

        // Navigate to home screen
        Get.offAllNamed(Routes.HOME);
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

  void goToSignup() {
    Get.toNamed(Routes.SIGNUP);
  }
}
