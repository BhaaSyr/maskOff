import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testvid/feature/controllers/home_controller.dart';
import 'package:testvid/feature/controllers/theme_controller.dart';
import 'package:video_player/video_player.dart';
import 'package:testvid/core/services/app_logger.dart';

class VideoPlayerWidget extends StatelessWidget {
  final VideoPlayerController controller;

  const VideoPlayerWidget({
    super.key,
    required this.controller,
  });

  // Format utility integrated directly into this widget
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    // final videoBox = _buildVideoBox();
    // final double videoWidth = (videoBox as Container).constraints?.maxWidth ?? 300;

    final Size scaledSize = _calculateVideoSize();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            _buildVideoBox(scaledSize),
            _buildDurationDisplay(),
          ],
        ),
        _buildControls(),
      ],
    );
  }

  Size _calculateVideoSize() {
    const double maxWidth = 330;
    const double maxHeight = 330;
    final Size videoSize = controller.value.size;
    final double videoAspectRatio = controller.value.aspectRatio;
    double width = videoSize.width;
    double height = videoSize.height;

    if (width > maxWidth) {
      width = maxWidth;
      height = width / videoAspectRatio;
    }

    if (height > maxHeight) {
      height = maxHeight;
      width = height * videoAspectRatio;
    }

    // Debug logs for video dimensions
    AppLogger().debug('Video aspect ratio: $videoAspectRatio');
    AppLogger().debug('Width: $width');
    AppLogger().debug('Height: $height');

    return Size(width, height);
  }

  Widget _buildVideoBox(Size size) {
    final ThemeController themeController = Get.find<ThemeController>();
    final isDark = themeController.isDarkMode;

    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(
            color: isDark
                ? Colors.white.withValues(alpha: 0.1)
                : Colors.grey.shade200,
            width: 1),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.3)
                : Colors.black.withValues(alpha: 0.2),
            spreadRadius: 1,
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            VideoPlayer(controller),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: VideoProgressIndicator(
                controller,
                allowScrubbing: true,
                colors: VideoProgressColors(
                  playedColor: const Color(0xFF6C63FF),
                  bufferedColor: const Color(0xFF6C63FF).withValues(alpha: 0.4),
                  backgroundColor: isDark
                      ? Colors.white.withValues(alpha: 0.2)
                      : Colors.grey.shade200,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDurationDisplay() {
    final ThemeController themeController = Get.find<ThemeController>();
    final isDark = themeController.isDarkMode;

    return GetBuilder<VideoController>(
      builder: (_) => Positioned(
        bottom: 5,
        right: 5,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
          decoration: BoxDecoration(
            color: isDark
                ? Colors.black.withValues(alpha: 0.6)
                : Colors.black.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            "${_formatDuration(controller.value.position)} / ${_formatDuration(controller.value.duration)}",
            style: TextStyle(
              fontSize: 10,
              color: Colors.white.withValues(alpha: 0.9),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildControls() {
    return GetBuilder<VideoController>(
      builder: (videoController) {
        final isPlaying = controller.value.isPlaying;
        final ThemeController themeController = Get.find<ThemeController>();
        final isDark = themeController.isDarkMode;

        final Color iconColor = isDark
            ? Colors.white.withValues(alpha: 0.8)
            : const Color.fromARGB(255, 82, 81, 92);

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.replay_5),
              onPressed: () {
                final current = controller.value.position;
                controller.seekTo(current - const Duration(seconds: 5));
              },
              color: iconColor,
            ),
            IconButton(
              icon: Icon(
                isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
                size: 36,
              ),
              onPressed: () {
                isPlaying ? controller.pause() : controller.play();
                videoController.update(); // Update UI
              },
              color: iconColor,
            ),
            IconButton(
              icon: const Icon(Icons.forward_5),
              onPressed: () {
                final current = controller.value.position;
                controller.seekTo(current + const Duration(seconds: 5));
              },
              color: iconColor,
            ),
            IconButton(
              icon: Icon(
                controller.value.volume > 0
                    ? Icons.volume_up
                    : Icons.volume_off,
              ),
              onPressed: () {
                controller.setVolume(controller.value.volume > 0 ? 0 : 1);
                videoController.update(); // Update UI
              },
              color: iconColor,
            ),
          ],
        );
      },
    );
  }
}
