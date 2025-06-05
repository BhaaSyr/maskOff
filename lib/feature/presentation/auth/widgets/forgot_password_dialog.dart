import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testvid/feature/controllers/auth/auth_controller.dart';
import 'package:testvid/generated/l10n.dart';

class ForgotPasswordDialog extends StatelessWidget {
  final bool isDark;

  const ForgotPasswordDialog({
    super.key,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    final TextEditingController emailController = TextEditingController();
    final RxString dialogError = ''.obs;

    return AlertDialog(
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
                      final error =
                          await controller.resetPassword(emailController.text);

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
                      style: const TextStyle(
                        color: Color(0xFF6C63FF),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            )),
      ],
    );
  }
}
