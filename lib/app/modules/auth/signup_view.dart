import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/fluxify_next_button.dart';
import '../../../core/widgets/fluxify_input.dart';
import '../../../core/services/screen_services.dart';
import 'auth_controller.dart';

class SignupView extends GetView<AuthController> {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    final screen = context.screen;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: screen.w(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: screen.h(20)),

              // Logo Section
              Image.asset(
                AppImages.logo,
                width: screen.w(50),
                fit: BoxFit.contain,
              ),

              SizedBox(height: screen.h(10)),

              // Title
              Text(
                'Create Account',
                style: AppTextStyles.heading,
              ),

              SizedBox(height: screen.h(2)),

              // Subtitle
              Text(
                'Sign up to get started',
                style: TextStyle(
                  color: AppColors.white70,
                  fontSize: 16,
                ),
              ),

              SizedBox(height: screen.h(10)),

              // Name Input
              FluxifyInput(
                controller: controller.nameController,
                labelText: 'Full Name',
                style: FluxifyInputStyle.dark,
                borderRadius: 12.0,
              ),

              SizedBox(height: screen.h(5)),

              // Email/Phone Input
              FluxifyInput(
                controller: controller.emailController,
                labelText: 'Email or Phone',
                style: FluxifyInputStyle.dark,
                borderRadius: 12.0,
              ),

              const SizedBox(height: 20),

              // Password Input
              Obx(() => FluxifyInput(
                    controller: controller.passwordController,
                    labelText: 'Password',
                    obscureText: !controller.isPasswordVisible.value,
                    style: FluxifyInputStyle.dark,
                    borderRadius: 12.0,
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isPasswordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AppColors.white70,
                      ),
                      onPressed: controller.togglePasswordVisibility,
                    ),
                  )),

              const SizedBox(height: 20),

              // Confirm Password Input
              Obx(() => FluxifyInput(
                    controller: controller.confirmPasswordController,
                    labelText: 'Confirm Password',
                    obscureText: !controller.isConfirmPasswordVisible.value,
                    style: FluxifyInputStyle.dark,
                    borderRadius: 12.0,
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isConfirmPasswordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AppColors.white70,
                      ),
                      onPressed: controller.toggleConfirmPasswordVisibility,
                    ),
                  )),

              const SizedBox(height: 30),

              // Signup Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: Obx(() => FluxifyNextButton(
                      onTap: controller.signup,
                      isLoading: controller.isLoading.value,
                    )),
              ),

              const SizedBox(height: 30),

              // Toggle to Login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: TextStyle(
                      color: AppColors.white70,
                      fontSize: 14,
                    ),
                  ),
                  GestureDetector(
                    onTap: () =>
                        Get.toNamed('/otp', arguments: {'fromSignup': true}),
                    child: Text(
                      'Login',
                      style: AppTextStyles.subheading,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Social Login
              _buildSocialLogin(),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialLogin() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                height: 1,
                color: AppColors.white24,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'OR',
                style: TextStyle(
                  color: AppColors.white70,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 1,
                color: AppColors.white24,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _socialButton(
              assetPath: AppImages.googleLogo,
              onTap: controller.signInWithGoogle,
            ),
            _socialButton(
              assetPath: AppImages.facebookLogo,
              onTap: () {},
            ),
            _socialButton(
              assetPath: AppImages.appleLogo,
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _socialButton(
      {required String assetPath, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.white24,
            width: 1,
          ),
        ),
        child: Center(
          child: SvgPicture.asset(
            assetPath,
            width: 24,
            height: 24,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
