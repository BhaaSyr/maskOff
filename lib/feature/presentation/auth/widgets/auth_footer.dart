import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testvid/generated/l10n.dart';
import 'package:testvid/routes/app_pages.dart';

class AuthFooter extends StatelessWidget {
  final bool isDark;
  final bool isLogin;

  const AuthFooter({
    super.key,
    required this.isDark,
    required this.isLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isLogin ? S.of(context).noAccount : S.of(context).haveAccount,
          style: TextStyle(
            color: isDark ? Colors.white70 : const Color(0xFF666666),
          ),
        ),
        TextButton(
          onPressed: () => isLogin
              ? Get.toNamed(Routes.register)
              : Get.offNamed(Routes.login),
          child: Text(
            isLogin ? S.of(context).signup : S.of(context).login,
            style: const TextStyle(
              color: Color(0xFF6C63FF),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
