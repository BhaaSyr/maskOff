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

                    // App bar with back button, title and theme toggle
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Back button
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? Colors.white.withValues(alpha: 0.1)
                                  : const Color(0xFF6C63FF)
                                      .withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.arrow_back,
                              color: isDark
                                  ? Colors.white70
                                  : const Color(0xFF6C63FF),
                            ),
                          ),
                        ),

                        // Title
                        Text(
                          S.of(context).register,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color:
                                isDark ? Colors.white : const Color(0xFF333333),
                          ),
                        ),

                        // Controls row
                        Row(
                          children: [
                            // Language toggle
                            GestureDetector(
                              onTap: () {
                                _showLanguagePickerDialog(isDark);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? Colors.white.withValues(alpha: 0.1)
                                      : const Color(0xFF6C63FF)
                                          .withValues(alpha: 0.1),
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
                            const SizedBox(width: 8),
                            // Theme toggle
                            GestureDetector(
                              onTap: () {
                                themeController.toggleTheme();
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? Colors.white.withValues(alpha: 0.1)
                                      : const Color(0xFF6C63FF)
                                          .withValues(alpha: 0.1),
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
                      ],
                    ),

                    const SizedBox(height: 30),

                    // App icon
                    Center(
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: const Color(0xFF6C63FF).withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.app_registration,
                          size: 45,
                          color: Color(0xFF6C63FF),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Register form heading
                    Center(
                      child: Text(
                        S.of(context).createAccount,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color:
                              isDark ? Colors.white : const Color(0xFF333333),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Center(
                      child: Text(
                        S.of(context).enterInfo,
                        style: TextStyle(
                          fontSize: 16,
                          color:
                              isDark ? Colors.white70 : const Color(0xFF666666),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Name field
                    Obx(() => CustomTextField(
                          label: S.of(context).fullName,
                          hintText: S.of(context).fullNameHint,
                          controller: controller.nameController,
                          obscureText: false,
                          prefixIcon: Icons.person_outline,
                          errorText: controller.nameError.value,
                          isDark: isDark,
                        )),
                    const SizedBox(height: 20),

                    // Email field
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
                          hintText: S.of(context).passwordHintRegister,
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
                    const SizedBox(height: 20),

                    // Confirm password field
                    Obx(() => CustomTextField(
                          label: S.of(context).confirmPassword,
                          hintText: S.of(context).confirmPasswordHint,
                          controller: controller.confirmPasswordController,
                          obscureText: controller.obscureConfirmPassword.value,
                          prefixIcon: Icons.lock_outline,
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.obscureConfirmPassword.value
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: isDark ? Colors.white54 : Colors.grey,
                            ),
                            onPressed:
                                controller.toggleConfirmPasswordVisibility,
                          ),
                          errorText: controller.confirmPasswordError.value,
                          isDark: isDark,
                        )),

                    const SizedBox(height: 20),

                    // Terms and conditions checkbox
                    // Row(
                    //   children: [
                    //     SizedBox(
                    //       width: 24,
                    //       height: 24,
                    //       child: Checkbox(
                    //         value: controller.acceptedTerms.value,
                    //         onChanged: (value) {
                    //           controller.toggleTermsAcceptance();
                    //         },
                    //         activeColor: const Color(0xFF6C63FF),
                    //         checkColor: Colors.white,
                    //         shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(4),
                    //         ),
                    //       ),
                    //     ),
                    //     const SizedBox(width: 10),
                    //     Expanded(
                    //       child: GestureDetector(
                    //         onTap: controller.viewTermsAndConditions,
                    //         child: RichText(
                    //           text: TextSpan(
                    //             style: TextStyle(
                    //               color: isDark
                    //                   ? Colors.white70
                    //                   : const Color(0xFF666666),
                    //               fontSize: 13,
                    //             ),
                    //             children: const [
                    //               TextSpan(text: "Kayıt olarak "),
                    //               TextSpan(
                    //                 text: "Şartlar ve Koşullar",
                    //                 style: TextStyle(
                    //                   color: Color(0xFF6C63FF),
                    //                   fontWeight: FontWeight.bold,
                    //                 ),
                    //               ),
                    //               TextSpan(text: "'ı kabul etmiş olursunuz."),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),

                    // Terms error message
                    Obx(() => controller.termsError.value.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              controller.termsError.value,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                          )
                        : const SizedBox.shrink()),

                    const SizedBox(height: 25),

                    // Register button
                    CustomButton(
                      label: S.of(context).register,
                      onPressed: controller.register,
                      isPrimary: true,
                      isDark: isDark,
                      isLoading: controller.isRegisterLoading.value,
                    ),

                    const SizedBox(height: 20),

                    // Login link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          S.of(context).haveAccount,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white70
                                : const Color(0xFF666666),
                          ),
                        ),
                        TextButton(
                          onPressed: () => Get.offNamed(Routes.login),
                          child: Text(
                            S.of(context).login,
                            style: const TextStyle(
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

  void _showLanguagePickerDialog(bool isDark) {
    Get.dialog(
      SimpleDialog(
        backgroundColor: isDark ? const Color(0xFF2D2D44) : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          // English option
          InkWell(
            onTap: () {
              languageController.changeLanguage('en');
              Get.back();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('🇬🇧', style: TextStyle(fontSize: 18)),
                  const SizedBox(width: 12),
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
                  const Spacer(),
                  if (languageController.currentLanguage == 'en')
                    const Icon(
                      Icons.check,
                      size: 16,
                      color: Color(0xFF6C63FF),
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
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('🇹🇷', style: TextStyle(fontSize: 18)),
                  const SizedBox(width: 12),
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
                  const Spacer(),
                  if (languageController.currentLanguage == 'tr')
                    const Icon(
                      Icons.check,
                      size: 16,
                      color: Color(0xFF6C63FF),
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
