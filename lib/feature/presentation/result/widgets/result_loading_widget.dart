import 'package:flutter/material.dart';
import 'package:testvid/generated/l10n.dart';

class ResultLoadingWidget extends StatelessWidget {
  final bool isDark;

  const ResultLoadingWidget({
    super.key,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            isDark ? Colors.white : const Color(0xFF6C63FF),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          S.of(context).analyzingVideo,
          style: TextStyle(
            fontSize: 16,
            color: isDark ? Colors.white70 : const Color(0xFF666666),
          ),
        ),
      ],
    );
  }
}
