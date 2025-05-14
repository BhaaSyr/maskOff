import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:testvid/bindings/home_binding.dart';
import 'package:testvid/bindings/result_binding.dart';
import 'package:testvid/bindings/splash_binding.dart';
import 'package:testvid/views/home/home_view.dart';
import 'package:testvid/views/result/result_view.dart';
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
      name: Routes.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.RESULT,
      page: () => const ResultView(),
      binding: ResultBinding(),
    ),
  ];
}

// Routes sınıfını da güncelleyin
abstract class Routes {
  static const SPLASH = '/splash';
  static const HOME = '/home';
  static const RESULT = '/result';
}
