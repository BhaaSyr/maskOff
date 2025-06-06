import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileInputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final RxString errorObservable;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool isDark;

  const ProfileInputField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    required this.errorObservable,
    required this.keyboardType,
    required this.textInputAction,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final errorText = errorObservable.value;
      final hasError = errorText.isNotEmpty;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 5),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 16,
                  color: hasError
                      ? Colors.red
                      : isDark
                          ? Colors.white70
                          : const Color(0xFF6C63FF),
                ),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: hasError
                        ? Colors.red
                        : isDark
                            ? Colors.white70
                            : const Color(0xFF6C63FF),
                  ),
                ),
              ],
            ),
          ),

          // Input Field
          Container(
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: hasError
                    ? Colors.red
                    : isDark
                        ? Colors.white.withValues(alpha: 0.1)
                        : Colors.grey[300]!,
              ),
            ),
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              textInputAction: textInputAction,
              style: TextStyle(
                color: isDark ? Colors.white : const Color(0xFF333333),
                fontSize: 16,
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(
                  color: isDark ? Colors.white38 : Colors.grey[500],
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 0,
                ),
              ),
            ),
          ),

          // Error Text
          if (hasError)
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 4),
              child: Text(
                errorText,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                ),
              ),
            ),
        ],
      );
    });
  }
}
