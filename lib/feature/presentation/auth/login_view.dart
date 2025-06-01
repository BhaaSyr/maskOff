import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testvid/feature/controllers/auth/auth_controller.dart';
import 'package:testvid/feature/controllers/language_controller.dart';
import 'package:testvid/feature/controllers/theme_controller.dart';
import 'package:testvid/generated/l10n.dart';
import 'package:testvid/routes/app_pages.dart';
import 'package:testvid/feature/presentation/auth/widgets/index.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late AuthController controller;
  late ThemeController themeController;
  late LanguageController languageController;

  @override
  void initState() {
    super.initState();
    controller = Get.find<AuthController>();
    themeController = Get.find<ThemeController>();
    languageController = Get.find<LanguageController>();

    // Mevcut ekranın Login ekranı olduğunu bildir
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.setCurrentScreen(Routes.LOGIN);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

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
                    // Top bar with theme toggle and language toggle
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Language switcher
                        GestureDetector(
                          onTap: () {
                            _showLanguagePickerDialog(isDark);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? Colors.white.withOpacity(0.1)
                                  : const Color(0xFF6C63FF).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.language,
                              color: isDark
                                  ? Colors.white70
                                  : const Color(0xFF6C63FF),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        // Theme toggle button
                        GestureDetector(
                          onTap: () {
                            themeController.toggleTheme();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? Colors.white.withOpacity(0.1)
                                  : const Color(0xFF6C63FF).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              isDark ? Icons.light_mode : Icons.dark_mode,
                              color: isDark
                                  ? Colors.white70
                                  : const Color(0xFF6C63FF),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Logo or app icon
                    Center(
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: const Color(0xFF6C63FF).withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.verified_user,
                          size: 60,
                          color: const Color(0xFF6C63FF),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // App name
                    Center(
                      child: Text(
                        S.of(context).appTitle,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color:
                              isDark ? Colors.white : const Color(0xFF333333),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Login title
                    Center(
                      child: Text(
                        S.of(context).login,
                        style: TextStyle(
                          fontSize: 16,
                          color:
                              isDark ? Colors.white70 : const Color(0xFF666666),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Email/Username field
                    Obx(() => CustomTextField(
                          label: S.of(context).email,
                          hintText: S.of(context).emailHint,
                          controller: controller.emailController,
                          obscureText: false,
                          prefixIcon: Icons.email_outlined,
                          errorText: controller.emailError.value,
                          isDark: isDark,
                        )),
                    const SizedBox(height: 20),

                    // Password field
                    Obx(() => CustomTextField(
                          label: S.of(context).password,
                          hintText: S.of(context).passwordHint,
                          controller: controller.passwordController,
                          obscureText: controller.obscurePassword.value,
                          prefixIcon: Icons.lock_outline,
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.obscurePassword.value
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: isDark ? Colors.white54 : Colors.grey,
                            ),
                            onPressed: controller.togglePasswordVisibility,
                          ),
                          errorText: controller.passwordError.value,
                          isDark: isDark,
                        )),

                    // Forgot password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // Show password reset dialog
                          _showForgotPasswordDialog(isDark);
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                        ),
                        child: Text(
                          S.of(context).forgotPassword,
                          style: TextStyle(
                            color: const Color(0xFF6C63FF),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Login button
                    CustomButton(
                      label: S.of(context).login,
                      onPressed: controller.login,
                      isPrimary: true,
                      isDark: isDark,
                      isLoading: controller.isEmailLoginLoading.value,
                    ),

                    // Auth error message
                    Obx(() => controller.authError.value.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Text(
                              controller.authError.value,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 13,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : const SizedBox.shrink()),

                    const SizedBox(height: 20),

                    // OR divider
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: isDark ? Colors.white24 : Colors.black12,
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            S.of(context).or,
                            style: TextStyle(
                              color: isDark ? Colors.white38 : Colors.black38,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: isDark ? Colors.white24 : Colors.black12,
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Google Sign-in button
                    SocialButton(
                      label: S.of(context).loginWithGoogle,
                      onPressed: controller.signInWithGoogle,
                      icon: "assets/images/google_icon.png",
                      isDark: isDark,
                      isLoading: controller.isGoogleLoginLoading.value,
                    ),

                    const SizedBox(height: 20),

                    // Register redirect
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          S.of(context).noAccount,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white70
                                : const Color(0xFF666666),
                          ),
                        ),
                        TextButton(
                          onPressed: () => Get.toNamed(Routes.REGISTER),
                          child: Text(
                            S.of(context).signup,
                            style: TextStyle(
                              color: Color(0xFF6C63FF),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
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

  void _showForgotPasswordDialog(bool isDark) {
    final TextEditingController emailController = TextEditingController();
    final RxString dialogError = ''.obs;

    Get.dialog(
      AlertDialog(
        backgroundColor: isDark ? const Color(0xFF2D2D44) : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          S.of(context).passwordReset,
          style: TextStyle(
            color: isDark ? Colors.white : const Color(0xFF333333),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              S.of(context).passwordResetInfo,
              style: TextStyle(
                color: isDark ? Colors.white70 : const Color(0xFF666666),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: isDark ? Colors.white.withOpacity(0.06) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isDark ? 0.05 : 0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: emailController,
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black87,
                ),
                decoration: InputDecoration(
                  hintText: S.of(context).emailHint,
                  hintStyle: TextStyle(
                    color: isDark ? Colors.white38 : Colors.black38,
                  ),
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: isDark ? Colors.white54 : Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  filled: true,
                  fillColor:
                      isDark ? Colors.white.withOpacity(0.04) : Colors.white,
                ),
              ),
            ),
            // Error message
            Obx(() => dialogError.value.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(
                      dialogError.value,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 13,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                : const SizedBox.shrink()),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              S.of(context).cancel,
              style: TextStyle(
                color: isDark ? Colors.white70 : const Color(0xFF666666),
              ),
            ),
          ),
          Obx(() => TextButton(
                onPressed: controller.isResettingPassword.value
                    ? null
                    : () async {
                        // Reset any previous error
                        dialogError.value = '';

                        // Call resetPassword and get potential error
                        final error = await controller
                            .resetPassword(emailController.text);

                        // If there was an error, display it
                        if (error != null) {
                          dialogError.value = error;
                        }
                      },
                child: controller.isResettingPassword.value
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Color(0xFF6C63FF)),
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        S.of(context).send,
                        style: TextStyle(
                          color: const Color(0xFF6C63FF),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              )),
        ],
      ),
    );
  }

  void _showLanguagePickerDialog(bool isDark) {
    Get.dialog(
      SimpleDialog(
        backgroundColor: isDark ? const Color(0xFF2D2D44) : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 8),
        children: [
          // English option
          InkWell(
            onTap: () {
              languageController.changeLanguage('en');
              Get.back();
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('🇬🇧', style: TextStyle(fontSize: 18)),
                  SizedBox(width: 12),
                  Text(
                    'English',
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark ? Colors.white : const Color(0xFF333333),
                      fontWeight: languageController.currentLanguage == 'en'
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                  Spacer(),
                  if (languageController.currentLanguage == 'en')
                    Icon(
                      Icons.check,
                      size: 16,
                      color: const Color(0xFF6C63FF),
                    ),
                ],
              ),
            ),
          ),
          Divider(
              height: 1,
              thickness: 1,
              color: isDark ? Colors.white12 : Colors.black12),
          // Turkish option
          InkWell(
            onTap: () {
              languageController.changeLanguage('tr');
              Get.back();
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('🇹🇷', style: TextStyle(fontSize: 18)),
                  SizedBox(width: 12),
                  Text(
                    'Türkçe',
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark ? Colors.white : const Color(0xFF333333),
                      fontWeight: languageController.currentLanguage == 'tr'
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                  Spacer(),
                  if (languageController.currentLanguage == 'tr')
                    Icon(
                      Icons.check,
                      size: 16,
                      color: const Color(0xFF6C63FF),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
      barrierColor: Colors.black54,
    );
  }
}
