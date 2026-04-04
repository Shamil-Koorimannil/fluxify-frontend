import 'package:flutter/material.dart';

class ScreenServices {
  static final ScreenServices _instance = ScreenServices._internal();
  factory ScreenServices() => _instance;
  ScreenServices._internal();

  late MediaQueryData _mediaQuery;

  void init(BuildContext context) {
    _mediaQuery = MediaQuery.of(context);
  }

  // Screen dimensions
  double get screenWidth => _mediaQuery.size.width;
  double get screenHeight => _mediaQuery.size.height;

  // Device type detection
  bool get isMobile => screenWidth < 600;
  bool get isTablet => screenWidth >= 600 && screenWidth < 1200;
  bool get isDesktop => screenWidth >= 1200;

  // Responsive width - works across mobile, tablet, desktop
  double w(double percent) {
    final baseWidth = screenWidth * (percent / 100);

    // Responsive scaling for different devices
    if (isDesktop) {
      return baseWidth * 0.8; // Slightly smaller on desktop
    } else if (isTablet) {
      return baseWidth * 0.9; // Slightly smaller on tablet
    }
    return baseWidth; // Full size on mobile
  }

  // Responsive height - works across mobile, tablet, desktop
  double h(double percent) {
    final baseHeight = screenHeight * (percent / 100);

    // Responsive scaling for different devices
    if (isDesktop) {
      return baseHeight * 0.8; // Slightly smaller on desktop
    } else if (isTablet) {
      return baseHeight * 0.9; // Slightly smaller on tablet
    }
    return baseHeight; // Full size on mobile
  }
}

// Extension for easy access
extension ScreenServicesExtension on BuildContext {
  ScreenServices get screen => ScreenServices()..init(this);
}
