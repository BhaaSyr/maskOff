import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testvid/controllers/auth/auth_controller.dart';
import 'package:testvid/controllers/theme_controller.dart';
import 'package:testvid/routes/app_pages.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late AuthController controller;
  late ThemeController themeController;

  @override
  void initState() {
    super.initState();
    controller = Get.find<AuthController>();
    themeController = Get.find<ThemeController>();

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
                    // Top bar with theme toggle
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
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

                    const SizedBox(height: 40),

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

                    const SizedBox(height: 24),

                    // App name
                    Center(
                      child: Text(
                        "Mask Off",
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
                        "Giriş Yap",
                        style: TextStyle(
                          fontSize: 18,
                          color:
                              isDark ? Colors.white70 : const Color(0xFF666666),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),

                    // Email/Username field
                    Obx(() => _buildTextField(
                          label: "E-posta",
                          hintText: "E-posta adresinizi girin",
                          controller: controller.emailController,
                          obscureText: false,
                          prefixIcon: Icons.email_outlined,
                          errorText: controller.emailError.value,
                          isDark: isDark,
                        )),
                    const SizedBox(height: 20),

                    // Password field
                    Obx(() => _buildTextField(
                          label: "Şifre",
                          hintText: "Şifrenizi girin",
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
                          // TODO: Redirect to forgot password page
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                        ),
                        child: Text(
                          "Şifremi Unuttum",
                          style: TextStyle(
                            color: const Color(0xFF6C63FF),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Login button
                    _buildButton(
                      label: "Giriş Yap",
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
                            "VEYA",
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
                    _buildSocialButton(
                      label: "Google ile Giriş Yap",
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
                          "Hesabınız yok mu?",
                          style: TextStyle(
                            color: isDark
                                ? Colors.white70
                                : const Color(0xFF666666),
                          ),
                        ),
                        TextButton(
                          onPressed: () => Get.toNamed(Routes.REGISTER),
                          child: const Text(
                            "Kayıt Ol",
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

  Widget _buildTextField({
    required String label,
    required String hintText,
    required TextEditingController controller,
    required bool obscureText,
    required IconData prefixIcon,
    Widget? suffixIcon,
    String? errorText,
    required bool isDark,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.white70 : const Color(0xFF666666),
          ),
        ),
        const SizedBox(height: 8),
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
            controller: controller,
            obscureText: obscureText,
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black87,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: isDark ? Colors.white38 : Colors.black38,
              ),
              prefixIcon: Icon(
                prefixIcon,
                color: isDark ? Colors.white54 : Colors.grey,
              ),
              suffixIcon: suffixIcon,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
              errorText: errorText == '' ? null : errorText,
              errorStyle: const TextStyle(color: Colors.red),
              filled: true,
              fillColor: isDark ? Colors.white.withOpacity(0.04) : Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButton({
    required String label,
    required VoidCallback onPressed,
    required bool isPrimary,
    required bool isDark,
    bool isLoading = false,
  }) {
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isPrimary
                ? const Color(0xFF6C63FF).withOpacity(0.3)
                : Colors.black.withOpacity(isDark ? 0.1 : 0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: isPrimary ? Colors.white : const Color(0xFF6C63FF),
          backgroundColor: isPrimary
              ? const Color(0xFF6C63FF)
              : (isDark ? Colors.white.withOpacity(0.08) : Colors.white),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: isPrimary
                ? BorderSide.none
                : BorderSide(
                    color: isDark
                        ? Colors.white.withOpacity(0.1)
                        : const Color(0xFFEEEEF6),
                    width: 1,
                  ),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeWidth: 2,
                ),
              )
            : Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
      ),
    );
  }

  Widget _buildSocialButton({
    required String label,
    required VoidCallback onPressed,
    required String icon,
    required bool isDark,
    bool isLoading = false,
  }) {
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.1 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: isDark ? Colors.white : Colors.black87,
          backgroundColor:
              isDark ? Colors.white.withOpacity(0.08) : Colors.white,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: isDark
                  ? Colors.white.withOpacity(0.1)
                  : const Color(0xFFEEEEF6),
              width: 1,
            ),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeWidth: 2,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    icon,
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
