import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:testvid/bindings/auth_binding.dart';
import 'package:testvid/bindings/home_binding.dart';
import 'package:testvid/bindings/result_binding.dart';
import 'package:testvid/bindings/splash_binding.dart';
import 'package:testvid/views/auth/login_view.dart';
import 'package:testvid/views/auth/register_view.dart';
import 'package:testvid/views/home/home_view.dart';
import 'package:testvid/views/result/result_view.dart';
import 'package:testvid/views/settings_view.dart';
import 'package:testvid/views/splash/splash_screen.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH; // Başlangıç rotasını değiştirdik

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => const RegisterView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.RESULT,
      page: () => const ResultView(),
      binding: ResultBinding(),
    ),
    GetPage(
      name: Routes.SETTINGS,
      page: () => const SettingsView(),
    ),
  ];
}

// Routes sınıfını da güncelleyin
abstract class Routes {
  static const SPLASH = '/splash';
  static const LOGIN = '/login';
  static const REGISTER = '/register';
  static const HOME = '/home';
  static const RESULT = '/result';
  static const SETTINGS = '/settings';
}
