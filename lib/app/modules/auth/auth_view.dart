import 'package:flutter/material.dart';
import 'package:fluxify/app/core/widgets/fluxify_next_button.dart';
import 'package:get/get.dart';
import '../../core/widgets/fluxify_input_field.dart';
import '../../routes/app_pages.dart';
import 'auth_controller.dart';
import '../../../core/constants/app_constants.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Restored Pure Black
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 140),

              // 1. Logo Section
              Image.asset(
                AppConstants.logoPath,
                width: Get.width * 0.6,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 80),

              // 2. Email/Phone Input
              FluxifyInputField(
                controller: controller.emailPhoneController,
                label: 'Email or Phone',
                borderRadius: 25.0, // Matching your Signup design
              ),

              const SizedBox(height: 25),

              // 3. Password Input
              // For the Password field with the visibility toggle
              Obx(() => FluxifyInputField(
                controller: controller.passwordController,
                label: 'Password',
                isPassword: true,
                isVisible: controller.isPasswordVisible.value,
                onToggleVisibility: () => controller.togglePasswordVisibility(),
                borderRadius: 25.0,
              )),

              const SizedBox(height: 20),

              // 4. Login Button
              Align(
                alignment: Alignment.centerRight,
                child: FluxifyNextButton(onTap: () => controller.login()),
              ),

              const SizedBox(height: 120),

              // 5. Footer Link
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }


 
  Widget _buildFooter() {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.SIGNUP),
      child: RichText(
        text: const TextSpan(
          text: 'New User? ',
          style: TextStyle(color: Colors.white70, fontSize: 14),
          children: [
            TextSpan(
              text: 'SIGN UP HERE',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}