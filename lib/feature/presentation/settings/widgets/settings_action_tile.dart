import 'package:flutter/material.dart';

class SettingsActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color? textColor;
  final VoidCallback onTap;
  final bool isDark;

  const SettingsActionTile({
    super.key,
    required this.icon,
    required this.title,
    this.textColor,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withValues(alpha: 0.1)
              : const Color(0xFF6C63FF).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color:
              textColor ?? (isDark ? Colors.white70 : const Color(0xFF6C63FF)),
          size: 18,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: textColor ?? (isDark ? Colors.white : const Color(0xFF333333)),
        ),
      ),
      onTap: onTap,
    );
  }
}
