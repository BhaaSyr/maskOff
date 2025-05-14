import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:testvid/controllers/home_controller.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatelessWidget {
  final VideoPlayerController controller;

  const VideoPlayerWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

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

// Önce maksimum genişliği uygula
    if (width > maxWidth) {
      width = maxWidth;
      height = width / videoAspectRatio;
    }

    // Sonra maksimum yüksekliği uygula
    if (height > maxHeight) {
      height = maxHeight;
      width = height * videoAspectRatio;
    }
    return Size(width, height);
  }

  Widget _buildVideoBox(Size size) {
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 20,
            offset: const Offset(2, 4),
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
                  playedColor: Colors.blue,
                  bufferedColor: Colors.blue.shade200,
                  backgroundColor: Colors.grey.shade300,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(double width) {
    return Positioned(
      bottom: 0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: width,
          padding: const EdgeInsets.symmetric(vertical: 0),
          child: VideoProgressIndicator(
            controller,
            allowScrubbing: true,
            colors: VideoProgressColors(
              playedColor: Colors.blue,
              bufferedColor: Colors.blue.shade200,
              backgroundColor: Colors.grey.shade300,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDurationDisplay() {
    return GetBuilder<VideoController>(
      builder: (_) => Positioned(
        bottom: 5,
        right: 1,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            "${_formatDuration(controller.value.position)} / ${_formatDuration(controller.value.duration)}",
            style: const TextStyle(fontSize: 9, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildControls() {
    return GetBuilder<VideoController>(
      builder: (_) {
        final isPlaying = controller.value.isPlaying;

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.replay_5),
              onPressed: () {
                final current = controller.value.position;
                controller.seekTo(current - const Duration(seconds: 5));
              },
              color: Colors.grey[800],
            ),
            IconButton(
              icon: Icon(
                isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
                size: 36,
              ),
              onPressed: () {
                isPlaying ? controller.pause() : controller.play();
                _.update(); // Update UI
              },
              color: Colors.grey[800],
            ),
            IconButton(
              icon: const Icon(Icons.forward_5),
              onPressed: () {
                final current = controller.value.position;
                controller.seekTo(current + const Duration(seconds: 5));
              },
              color: Colors.grey[800],
            ),
            IconButton(
              icon: Icon(
                controller.value.volume > 0
                    ? Icons.volume_up
                    : Icons.volume_off,
              ),
              onPressed: () {
                controller.setVolume(controller.value.volume > 0 ? 0 : 1);
                _.update(); // Update UI
              },
              color: Colors.grey[800],
            ),
          ],
        );
      },
    );
  }
}
