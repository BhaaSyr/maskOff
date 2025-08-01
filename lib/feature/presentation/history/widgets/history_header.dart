import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testvid/generated/l10n.dart';

class HistoryHeader extends StatelessWidget {
  final bool isDark;
  final VoidCallback onRefresh;

  const HistoryHeader({
    super.key,
    required this.isDark,
    required this.onRefresh,
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
                    ? Colors.white.withValues(alpha: 0.1)
                    : const Color(0xFF6C63FF).withValues(alpha: 0.1),
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
            S.of(context).analysisHistory,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : const Color(0xFF333333),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: onRefresh,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.1)
                    : const Color(0xFF6C63FF).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.refresh,
                color: isDark ? Colors.white70 : const Color(0xFF6C63FF),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
