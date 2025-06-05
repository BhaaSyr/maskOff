import 'package:flutter/material.dart';
import 'package:video_trimmer/video_trimmer.dart';
import 'package:testvid/generated/l10n.dart';

class VideoPreviewCard extends StatelessWidget {
  final Trimmer trimmer;
  final bool isDark;
  final Size videoSize;

  const VideoPreviewCard({
    super.key,
    required this.trimmer,
    required this.isDark,
    required this.videoSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.08) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.20 : 0.1),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6C63FF).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.cut,
                    color: Color(0xFF6C63FF),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  S.of(context).videoTrimming,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : const Color(0xFF333333),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: videoSize.width,
            height: videoSize.height,
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(
                color: isDark
                    ? Colors.white.withOpacity(0.1)
                    : Colors.grey.shade200,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: isDark
                      ? Colors.black.withOpacity(0.3)
                      : Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 15,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: VideoViewer(trimmer: trimmer),
            ),
          ),
        ],
      ),
    );
  }
}
