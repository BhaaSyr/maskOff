import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:testvid/controllers/language_controller.dart';
import 'package:testvid/controllers/theme_controller.dart';
import 'package:testvid/generated/l10n.dart';
import 'package:testvid/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Tema kontrolcüsünü bağla - SharedPreferences içeride başlatılacak
  final themeController = Get.put(ThemeController(), permanent: true);

  // Initialize language controller
  final languageController = Get.put(LanguageController(), permanent: true);

  // Yalnızca dikey mod
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends GetView<ThemeController> {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final languageController = Get.find<LanguageController>();

    return Obx(() => GetMaterialApp(
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          locale: Locale(languageController.currentLanguage),
          fallbackLocale: const Locale('en'),
          title: 'Mask Off',
          debugShowCheckedModeBanner: false,
          theme: controller.lightTheme,
          darkTheme: controller.darkTheme,
          themeMode: controller.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
        ));
  }
}
