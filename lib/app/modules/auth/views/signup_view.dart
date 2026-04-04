import 'package:flutter/material.dart';
import 'package:fluxify/core/widgets/fluxify_next_button.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/widgets/fluxify_input_field.dart';
import '../../routes/app_pages.dart';
import 'signup_controller.dart';
import '../../../core/constants/app_constants.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({Key? key}) : super(key: key);

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
              const SizedBox(height: 120),

              // 1. Logo
              Image.asset(
                AppConstants.logoPath,
                width: Get.width * 0.6,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 60),

              // 2. Email/Phone Field
              FluxifyInputField(
                controller: controller.emailPhoneController,
                label: 'Email or Phone',
                borderRadius: 15.0, // Matching your Signup design
              ),

              const SizedBox(height: 25),

              // 3. Password Field
              FluxifyInputField(
                controller: controller.passwordController,
                label: 'Email or Phone',
                borderRadius: 15.0, // Matching your Signup design
              ),

              const SizedBox(height: 25),

              // 4. Confirm Password
              FluxifyInputField(
                controller: controller.confirmPasswordController,
                label: 'Email or Phone',
                borderRadius: 15.0, // Matching your Signup design
              ),

              const SizedBox(height: 20),

              // 5. Next Button (Aligned Right)
              Align(
                alignment: Alignment.centerRight,
                child: FluxifyNextButton(onTap: () => controller.signUp()),
              ),

              const SizedBox(height: 40),

              // 6. "or" Separator
              const Text(
                'or',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                ),
              ),

              const SizedBox(height: 40),

              // 7. Social Login Row
              _buildSocialRow(),

              const SizedBox(height: 80),

              // 8. Footer Link
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  // Restored original Input Style with Floating Label on Border

  Widget _buildSocialRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _socialIcon(assetPath: AppConstants.googleLogoPath, onTap: () {}),
        const SizedBox(width: 40),
        _socialIcon(assetPath: AppConstants.facebookLogoPath, onTap: () {}),
        const SizedBox(width: 40),
        _socialIcon(assetPath: AppConstants.macLogoPath, onTap: () {}),
      ],
    );
  }

  Widget _socialIcon({required String assetPath, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
        ),
        child: SvgPicture.asset(assetPath, fit: BoxFit.contain),
      ),
    );
  }

  Widget _buildFooter() {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.AUTH),
      child: RichText(
        text: const TextSpan(
          text: 'Used before? ',
          style: TextStyle(color: Colors.white70, fontSize: 14),
          children: [
            TextSpan(
              text: 'Login Here',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline
              ),
            ),
          ],
        ),
      ),
    );
  }
}