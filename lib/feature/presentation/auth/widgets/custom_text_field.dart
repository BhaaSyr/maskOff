import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final IconData prefixIcon;
  final Widget? suffixIcon;
  final String? errorText;
  final bool isDark;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    required this.prefixIcon,
    this.suffixIcon,
    this.errorText,
    required this.isDark,
    this.keyboardType,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
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
            color: isDark ? Colors.white.withValues(alpha: 0.06) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.05 : 0.03),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
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
              fillColor:
                  isDark ? Colors.white.withValues(alpha: 0.04) : Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
