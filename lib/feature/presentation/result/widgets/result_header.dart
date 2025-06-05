import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testvid/generated/l10n.dart';

class ResultHeader extends StatelessWidget {
  final bool isDark;

  const ResultHeader({
    super.key,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withOpacity(0.1)
                    : const Color(0xFF6C63FF).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.arrow_back,
                color: isDark ? Colors.white70 : const Color(0xFF6C63FF),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Text(
            S.of(context).analysisResults,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : const Color(0xFF333333),
            ),
          ),
        ],
      ),
    );
  }
}
