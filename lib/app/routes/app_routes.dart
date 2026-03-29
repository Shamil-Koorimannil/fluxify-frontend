part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const AUTH = _Paths.AUTH;
  static const SIGNUP = _Paths.SIGNUP;
  static const SPLASH = _Paths.SPLASH;
}

abstract class _Paths {
  _Paths._();
  static const AUTH = '/auth';
  static const SIGNUP = '/signup';
  static const SPLASH = '/splash';
}
