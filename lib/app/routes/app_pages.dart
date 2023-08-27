import 'package:get/get.dart';
import 'package:tida_customer/app/modules/Home/bindings/home_binding.dart';
import 'package:tida_customer/app/modules/Home/views/home_view.dart';
import 'package:tida_customer/app/modules/login/bindings/login_bindings.dart';
import 'package:tida_customer/app/modules/login/views/login_view.dart';
import 'package:tida_customer/app/modules/register/bindings/register_binding.dart';
import 'package:tida_customer/app/modules/register/views/register_view.dart';
import 'package:tida_customer/app/modules/sports/bindings/sports_binding.dart';
import 'package:tida_customer/app/modules/sports/views/sports_view.dart';
part 'app_routes.dart';

class AppPages
{
   AppPages._();
  static const INITIAL = Routes.LOGIN;
  static const LOGIN = Routes.LOGIN;
  static const REGISTER = Routes.REGISTER;
  static const HOME = Routes.HOME;
  static const BOOKEXP = Routes.BOOKEXP;
  static const SPORTS = Routes.SPORTS;
   static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.BOOKEXP,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPORTS,
      page: () => const SportsView(),
      binding: SportsBinding(),
    ),
   ];
}