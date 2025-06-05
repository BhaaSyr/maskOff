import 'package:flutter/material.dart';
import 'package:testvid/feature/controllers/home_controller.dart';
import 'package:testvid/feature/presentation/home/widgets/home_video_player_widget.dart';
import 'package:testvid/generated/l10n.dart';

class BuildVideoCard extends StatelessWidget {
  const BuildVideoCard({
    super.key,
    required this.controller,
    required this.isDark,
  });

  final VideoController controller;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withValues(alpha: 0.08) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.1),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6C63FF).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.videocam,
                    color: Color(0xFF6C63FF),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  S.current.yourVideo,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : const Color(0xFF333333),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    controller.clearVideo();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.1)
                          : const Color(0xFFEEEEF6),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.close,
                      color: isDark ? Colors.white70 : const Color(0xFF6C63FF),
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: VideoPlayerWidget(
              controller: controller.playerController.value!,
            ),
          ),
        ],
      ),
    );
  }
}
