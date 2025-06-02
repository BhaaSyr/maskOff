import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:testvid/feature/presentation/auth/login_view.dart';
import 'package:testvid/feature/presentation/auth/register_view.dart';
import 'package:testvid/feature/presentation/bindings/auth_binding.dart';
import 'package:testvid/feature/presentation/bindings/home_binding.dart';
import 'package:testvid/feature/presentation/bindings/profile_binding.dart';
import 'package:testvid/feature/presentation/bindings/result_binding.dart';
import 'package:testvid/feature/presentation/bindings/splash_binding.dart';
import 'package:testvid/feature/presentation/home/home_view.dart';
import 'package:testvid/feature/presentation/profile/profile_view.dart';
import 'package:testvid/feature/presentation/result/result_view.dart';
import 'package:testvid/feature/presentation/settings_view.dart';
import 'package:testvid/feature/presentation/splash/splash_screen.dart';
import 'package:testvid/feature/presentation/history/history_view.dart';

class AppPages {
  // ignore: constant_identifier_names
  static const INITIAL = Routes.splash; // Başlangıç rotasını değiştirdik

  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.register,
      page: () => const RegisterView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.result,
      page: () => const ResultView(),
      binding: ResultBinding(),
    ),
    GetPage(
      name: Routes.settings,
      page: () => const SettingsView(),
    ),
    GetPage(
      name: Routes.profile,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: Routes.history,
      page: () => const HistoryView(),
      binding: ProfileBinding(),
    ),
  ];
}

// Routes sınıfını da güncelleyin
abstract class Routes {
  static const splash = '/splash';
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';
  static const result = '/result';
  static const settings = '/settings';
  static const profile = '/profile';
  static const history = '/history';
}
