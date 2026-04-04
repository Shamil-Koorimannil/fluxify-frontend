class AppConstants {
  // App Info
  static const String appName = 'FLUXIFY';
  static const String appVersion = '1.0.0';

  // API Constants
  static const String baseUrl = 'https://api.fluxify.com';
  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;

  // Storage Keys
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userIdKey = 'user_id';
  static const String userProfileKey = 'user_profile';
  static const String isFirstLaunchKey = 'is_first_launch';
  static const String themeKey = 'theme_mode';

  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // File Upload Limits
  static const int maxFileSizeBytes = 10 * 1024 * 1024; // 10MB
  static const List<String> supportedImageFormats = [
    'jpg',
    'jpeg',
    'png',
    'gif'
  ];
  static const List<String> supportedVideoFormats = ['mp4', 'mov', 'avi'];
}
