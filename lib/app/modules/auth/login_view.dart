import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluxify/app/routes/app_pages.dart';
import 'package:fluxify/core/services/screen_services.dart';
import 'package:fluxify/core/theme/app_text_styles.dart';
import 'package:fluxify/core/widgets/fluxify_next_button.dart';
import 'package:get/get.dart';
import '../../../core/widgets/fluxify_input.dart';
import 'auth_controller.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/constants/app_colors.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              SizedBox(height: context.screen.h(15),),
              // Logo Section
              Image.asset(
                AppImages.logo,
                width: Get.width * 0.5,
                fit: BoxFit.contain,
              ),

              SizedBox(height: context.screen.h(20),),

              // Title
              Padding(
                padding:  EdgeInsets.symmetric(horizontal:  context.screen.w(10),),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome',
                      style: AppTextStyles.heading,
                    ),

                    // Subtitle
                    Text(
                        'Enter Your Email or Phone To Continue',
                        style: AppTextStyles.body
                    ),

                    SizedBox(height: context.screen.h(3.5),),

                    // Email/Phone Input
                    FluxifyInput(
                      controller: controller.emailController,
                      labelText: 'Email or Phone',
                      style: FluxifyInputStyle.dark,
                      borderRadius: 12.0,
                    ),

                    SizedBox(height: context.screen.h(3.5),),

                    // Login Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Obx(() => FluxifyNextButton(
                          onTap: () =>
                              Get.toNamed(AppRoutes.otpView, arguments: {'fromSignup': false}),
                          isLoading: controller.isLoading.value,
                        )),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: context.screen.h(20),),

              // Navigate to Signup
              GestureDetector(
                onTap: () => Get.toNamed('/signup'),
                child: Text(
                  "Don't have an account? Sign Up",
                  style: AppTextStyles.body,
                ),
              ),
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
