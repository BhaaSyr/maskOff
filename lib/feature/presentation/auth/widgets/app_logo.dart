import 'package:flutter/material.dart';
import 'package:testvid/generated/l10n.dart';

class AppLogo extends StatelessWidget {
  final bool isDark;
  final bool isLogin;
  final double logoSize;
  final double titleSize;
  final String? subtitle;

  const AppLogo({
    super.key,
    required this.isDark,
    this.isLogin = true,
    this.logoSize = 100,
    this.titleSize = 32,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Logo
          Container(
            width: logoSize,
            height: logoSize,
            decoration: BoxDecoration(
              color: const Color(0xFF6C63FF).withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isLogin ? Icons.verified_user : Icons.app_registration,
              size: logoSize * 0.6,
              color: const Color(0xFF6C63FF),
            ),
          ),
          const SizedBox(height: 20),

          // App title
          Text(
            S.of(context).appTitle,
            style: TextStyle(
              fontSize: titleSize,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : const Color(0xFF333333),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),

          // Subtitle
          if (subtitle != null)
            Text(
              subtitle!,
              style: TextStyle(
                fontSize: 16,
                color: isDark ? Colors.white70 : const Color(0xFF666666),
              ),
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }
}
