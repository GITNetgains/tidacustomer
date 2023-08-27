part of 'app_pages.dart';
abstract class Routes {
   Routes._();
  static const LOGIN = _Paths.LOGIN;
  static const REGISTER = _Paths.REGISTER;
  static const HOME = _Paths.HOME;
  static const BOOKEXP = _Paths.BOOKEXP;
  static const SPORTS = _Paths.SPORTS;
  
}
abstract class _Paths {
    _Paths._();
  static const LOGIN = '/login';
  static const REGISTER = "/register";
  static const HOME = "/home";
  static const BOOKEXP = "/bookexp";
  static const SPORTS = "/sports";
}