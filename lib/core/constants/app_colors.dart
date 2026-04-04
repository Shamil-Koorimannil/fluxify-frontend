import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AppColors {
  // Brand Colors - These are now centralized from AppTheme
  static const Color primary = AppTheme.primaryColor;
  static const Color secondary = AppTheme.secondaryColor;
  static const Color accent = AppTheme.accentColor;

  // Light Theme Colors
  static const Color lightBackground = AppTheme.lightBackground;
  static const Color lightSurface = AppTheme.lightSurface;
  static const Color lightError = AppTheme.lightError;
  static const Color lightSuccess = AppTheme.lightSuccess;

  // Dark Theme Colors
  static const Color darkBackground = AppTheme.darkBackground;
  static const Color darkSurface = AppTheme.darkSurface;
  static const Color darkError = AppTheme.darkError;
  static const Color darkSuccess = AppTheme.darkSuccess;

  // Text Colors
  static const Color textPrimary = AppTheme.textPrimary;
  static const Color textSecondary = AppTheme.textSecondary;
  static const Color textTertiary = AppTheme.textTertiary;
  static const Color darkTextPrimary = AppTheme.darkTextPrimary;
  static const Color darkTextSecondary = AppTheme.darkTextSecondary;
  static const Color darkTextTertiary = AppTheme.darkTextTertiary;

  // Social Media Colors
  static const Color googleBlue = Color(0xFF4285F4);
  static const Color facebookBlue = Color(0xFF1877F2);
  static const Color appleBlack = Color(0xFF000000);

  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Background Colors
  static const Color backgroundColor = Color(0xFF121212);
  static const Color white = Color(0xFFFFFFFF);
  static const Color white54 = Color(0x8AFFFFFF);
  static const Color white70 = Color(0xB3FFFFFF);
  static const Color white24 = Color(0x3DFFFFFF);
}
