import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testvid/controllers/auth/auth_controller.dart';
import 'package:testvid/controllers/theme_controller.dart';
import 'package:testvid/routes/app_pages.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late AuthController controller;
  late ThemeController themeController;

  @override
  void initState() {
    super.initState();
    controller = Get.find<AuthController>();
    themeController = Get.find<ThemeController>();

    // Mevcut ekranın Register ekranı olduğunu bildir
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.setCurrentScreen(Routes.REGISTER);
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

                    // App bar with back button and theme toggle
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
                                  ? Colors.white.withOpacity(0.1)
                                  : const Color(0xFF6C63FF).withOpacity(0.1),
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
                          "Kayıt Ol",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color:
                                isDark ? Colors.white : const Color(0xFF333333),
                          ),
                        ),

                        // Theme toggle
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

                    const SizedBox(height: 30),

                    // App icon
                    Center(
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: const Color(0xFF6C63FF).withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.app_registration,
                          size: 45,
                          color: const Color(0xFF6C63FF),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Register form heading
                    Center(
                      child: Text(
                        "Hesap Oluştur",
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
                        "Lütfen bilgilerinizi girin",
                        style: TextStyle(
                          fontSize: 16,
                          color:
                              isDark ? Colors.white70 : const Color(0xFF666666),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Name field
                    Obx(() => _buildTextField(
                          label: "Adınız Soyadınız",
                          hintText: "Adınızı ve soyadınızı girin",
                          controller: controller.nameController,
                          obscureText: false,
                          prefixIcon: Icons.person_outline,
                          errorText: controller.nameError.value,
                          isDark: isDark,
                        )),
                    const SizedBox(height: 20),

                    // Email field
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
                          hintText: "Şifrenizi girin (en az 6 karakter)",
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
                    Obx(() => _buildTextField(
                          label: "Şifre Tekrar",
                          hintText: "Şifrenizi tekrar girin",
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
                    _buildButton(
                      label: "Kayıt Ol",
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
                          "Zaten bir hesabınız var mı?",
                          style: TextStyle(
                            color: isDark
                                ? Colors.white70
                                : const Color(0xFF666666),
                          ),
                        ),
                        TextButton(
                          onPressed: () => Get.offNamed(Routes.LOGIN),
                          child: const Text(
                            "Giriş Yap",
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
              errorText: errorText == '' ? null : '     ${errorText ?? ''}',
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
}
