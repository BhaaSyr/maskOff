import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isPrimary;
  final bool isDark;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.isPrimary,
    required this.isDark,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isPrimary
                ? const Color(0xFF6C63FF).withValues(alpha: 0.3)
                : Colors.black.withValues(alpha: isDark ? 0.1 : 0.05),
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
              : (isDark ? Colors.white.withValues(alpha: 0.08) : Colors.white),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: isPrimary
                ? BorderSide.none
                : BorderSide(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.1)
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
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
      ),
    );
  }
}
