import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_pages.dart';

class SplashController extends GetxController with GetTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> fadeAnimation;
  late Animation<double> scaleAnimation;

  @override
  void onInit() {
    super.onInit();

    // Initialize animations
    animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: animationController, curve: Curves.easeInOutCubic),
    );

    scaleAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOutCubic,
      ),
    );

    // Start animation
    animationController.forward();

    // Navigate after animation completes
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _navigateToAuth();
      }
    });
  }

  void _navigateToAuth() {
    Future.delayed(const Duration(seconds: 2), () {
      if (Get.isRegistered<SplashController>()) {
        Get.offAllNamed(AppRoutes.auth);
      }
    });
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
