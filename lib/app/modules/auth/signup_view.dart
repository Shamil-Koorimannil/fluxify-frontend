import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'signup_controller.dart';
import '../../../core/constants/app_constants.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Pure Black
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
              _buildFluxifyInput(
                controller: controller.emailPhoneController,
                label: 'Email or Phone',
              ),

              const SizedBox(height: 25),

              // 3. Password Field
              _buildFluxifyInput(
                controller: controller.passwordController,
                label: 'Password',
                isPassword: true,
              ),

              const SizedBox(height: 25),

              // 4. Confirm Password (Now in its own row)
              _buildFluxifyInput(
                controller: controller.confirmPasswordController,
                label: 'Confirm Password',
                isPassword: true,
              ),

              const SizedBox(height: 20),

              // 5. Next Button (Aligned to the END/RIGHT as per image)
              Align(
                alignment: Alignment.centerRight,
                child: _buildNextButton(),
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

  // Optimized Input Widget (No Highlighting Color)
  Widget _buildFluxifyInput({
    required TextEditingController controller,
    required String label,
    bool isPassword = false,
  }) {
    return Theme(
      // We wrap in a Theme to override the primary color (the highlight color)
      data: Theme.of(Get.context!).copyWith(
        primaryColor: Colors.white,
        colorScheme: ColorScheme.fromSwatch().copyWith(primary: Colors.white),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        cursorColor: Colors.white,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label, // This is the magic part
          labelStyle: const TextStyle(color: Colors.white, fontSize: 14),
          floatingLabelBehavior: FloatingLabelBehavior.always, // Keeps it on the border

          // Pure Black background
          filled: true,
          fillColor: Colors.black,

          // Customizing the Border
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.white.withOpacity(0.8), width: 1.2),
          ),

          // REMOVING THE HIGHLIGHT: Set focusedBorder to be the same as enabledBorder
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.white, width: 1.2),
          ),

          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),

          suffixIcon: isPassword
              ? Icon(Icons.visibility_outlined, color: Colors.white.withOpacity(0.6), size: 20)
              : null,
        ),
      ),
    );
  }

  Widget _buildNextButton() {
    return GestureDetector(
      onTap: () => controller.signUp(),
      child: Container(
        height: 28,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
                "NEXT",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 11
                )
            ),
            SizedBox(width: 4),
            Icon(Icons.play_arrow, color: Colors.black, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Google
        _socialIcon(
          assetPath: AppConstants.googleLogoPath,
          onTap: () => controller.signInWithGoogle(),
        ),
        const SizedBox(width: 40), // Increased spacing for a cleaner look

        // Facebook
        _socialIcon(
          assetPath: AppConstants.facebookLogoPath,
          onTap: () => controller.signInWithGoogle(),
        ),
        const SizedBox(width: 40),

        // Apple (Mac)
        _socialIcon(
          assetPath: AppConstants.macLogoPath,
          onTap: () => controller.signInWithGoogle(),
        ),
      ],
    );
  }

  Widget _socialIcon({required String assetPath, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50, // Slightly larger for better tap target
        height: 50,
        padding: const EdgeInsets.all(10), // Ensures the SVG doesn't touch the borders
        decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
          // Adding a subtle border helps if the SVG has dark parts
          border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
        ),
        child: SvgPicture.asset(
          assetPath,
          fit: BoxFit.contain,
          // If the SVG is still not showing, uncomment the line below to force it to white
          // colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          placeholderBuilder: (BuildContext context) => const CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return GestureDetector(
      onTap: () => Get.back(),
      child: RichText(
        text: const TextSpan(
          text: 'Used before? ',
          style: TextStyle(color: Colors.white70, fontSize: 14),
          children: [
            TextSpan(
              text: 'Login Here',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
            ),
          ],
        ),
      ),
    );
  }
}