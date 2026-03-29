import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_constants.dart';
import '../../routes/app_pages.dart';

// Note: Ensure your controller is linked in the Binding to handle the 5sec timer

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500), // Entry animation speed
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: Curves.bounceInOut), // Slight bounce/smooth scale
    );

    _controller.forward();

    // Navigate to signup after 5 seconds
    _navigateToSignup();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToSignup() {
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        Get.offAllNamed(Routes.SIGNUP);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Matches your Fluxify black background
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Image.asset(
              AppConstants.logoPath,
              width:
                  Get.width * 0.5, // Responsive width using your GetX strategy
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
