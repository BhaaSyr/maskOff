import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testvid/feature/controllers/auth/auth_controller.dart';
import 'package:testvid/feature/controllers/language_controller.dart';
import 'package:testvid/feature/controllers/theme_controller.dart';
import 'package:testvid/generated/l10n.dart';
import 'package:testvid/routes/app_pages.dart';
import 'package:testvid/feature/presentation/auth/widgets/index.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late AuthController controller;
  late ThemeController themeController;
  late LanguageController languageController;

  @override
  void initState() {
    super.initState();
    controller = Get.find<AuthController>();
    themeController = Get.find<ThemeController>();
    languageController = Get.find<LanguageController>();

    // Mevcut ekranın Register ekranı olduğunu bildir
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.setCurrentScreen(Routes.register);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDark = themeController.isDarkMode;

      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark
                  ? [
                      const Color(0xFF1E1E2E),
                      const Color(0xFF2D2D44),
                    ]
                  : [
                      const Color(0xFFF5F5FA),
                      const Color(0xFFE8E8F0),
                    ],
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),

                    // App header with back button
                    AppHeader(
                      isDark: isDark,
                      showBackButton: true,
                      title: S.of(context).register,
                    ),

                    const SizedBox(height: 30),

                    // App logo and title
                    AppLogo(
                      isDark: isDark,
                      isLogin: false,
                      logoSize: 90,
                      titleSize: 28,
                      subtitle: S.of(context).enterInfo,
                    ),

                    const SizedBox(height: 30),

                    // Register form
                    AuthForm(
                      isDark: isDark,
                      isLogin: false,
                      onForgotPassword: () {}, // Not used in register
                    ),

                    const SizedBox(height: 20),

                    // Footer with login link
                    AuthFooter(
                      isDark: isDark,
                      isLogin: false,
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
