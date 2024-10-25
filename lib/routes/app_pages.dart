import 'package:code_lab3apps/views/LoginPage.dart';
import 'package:code_lab3apps/views/RegisterPage.dart';
import 'package:code_lab3apps/views/home_screen.dart';
import 'package:code_lab3apps/views/splah.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => RegisterPage(),
    ),
    GetPage(name: Routes.LOGIN, page: () => LoginPage()),
    GetPage(name: Routes.SPLASH, page: () => SplashPage()),
  ];
}
