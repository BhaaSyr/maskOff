import 'package:flutter/material.dart';

class ResultErrorWidget extends StatelessWidget {
  final bool isDark;

  const ResultErrorWidget({
    super.key,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error_outline,
          size: 48,
          color: isDark ? Colors.white70 : const Color(0xFF666666),
        ),
        const SizedBox(height: 16),
        Text(
          'No analysis results available',
          style: TextStyle(
            fontSize: 16,
            color: isDark ? Colors.white70 : const Color(0xFF666666),
          ),
        ),
      ],
    );
  }
}
