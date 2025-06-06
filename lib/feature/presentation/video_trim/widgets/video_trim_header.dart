import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testvid/generated/l10n.dart';

class VideoTrimHeader extends StatelessWidget {
  final bool isDark;

  const VideoTrimHeader({
    super.key,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF6C63FF).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.content_cut_rounded,
              color: Color(0xFF6C63FF),
              size: 22,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            S.of(context).editVideo,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : const Color(0xFF333333),
              letterSpacing: -0.5,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.1)
                    : const Color(0xFFEEEEF6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.close,
                color: isDark ? Colors.white70 : const Color(0xFF6C63FF),
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
