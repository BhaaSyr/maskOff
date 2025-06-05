import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testvid/feature/controllers/auth/auth_controller.dart';
import 'package:testvid/generated/l10n.dart';
import 'package:testvid/feature/presentation/auth/widgets/custom_button.dart';
import 'package:testvid/feature/presentation/auth/widgets/custom_text_field.dart';
import 'package:testvid/feature/presentation/auth/widgets/social_button.dart';

class AuthForm extends StatelessWidget {
  final bool isDark;
  final bool isLogin;
  final VoidCallback onForgotPassword;

  const AuthForm({
    super.key,
    required this.isDark,
    required this.isLogin,
    required this.onForgotPassword,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

    return Column(
      children: [
        // Name field (only for register)
        if (!isLogin) ...[
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
        ],

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
              hintText: isLogin
                  ? S.of(context).passwordHint
                  : S.of(context).passwordHintRegister,
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

        // Forgot password (only for login)
        if (isLogin)
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: onForgotPassword,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
              child: Text(
                S.of(context).forgotPassword,
                style: const TextStyle(
                  color: Color(0xFF6C63FF),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

        // Confirm password field (only for register)
        if (!isLogin) ...[
          const SizedBox(height: 20),
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
                  onPressed: controller.toggleConfirmPasswordVisibility,
                ),
                errorText: controller.confirmPasswordError.value,
                isDark: isDark,
              )),
        ],

        const SizedBox(height: 30),

        // Submit button
        Obx(() => CustomButton(
              label: isLogin ? S.of(context).login : S.of(context).register,
              onPressed: isLogin ? controller.login : controller.register,
              isPrimary: true,
              isDark: isDark,
              isLoading: isLogin
                  ? controller.isEmailLoginLoading.value
                  : controller.isRegisterLoading.value,
            )),

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
          icon: "assets/google_icon.png",
          isDark: isDark,
          isLoading: controller.isGoogleLoginLoading.value,
        ),
      ],
    );
  }
}
