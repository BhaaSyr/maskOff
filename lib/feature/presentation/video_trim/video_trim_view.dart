import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_trimmer/video_trimmer.dart';
import 'package:get/get.dart';
import 'package:testvid/feature/controllers/theme_controller.dart';
import 'package:testvid/core/services/app_logger.dart';
import 'package:testvid/generated/l10n.dart';

class VideoTrimView extends StatefulWidget {
  final File videoFile;

  const VideoTrimView({
    super.key,
    required this.videoFile,
  });

  @override
  _VideoTrimViewState createState() => _VideoTrimViewState();
}

class _VideoTrimViewState extends State<VideoTrimView> {
  final Trimmer _trimmer = Trimmer();
  double _startValue = 0.0;
  double _endValue = 0.0;
  bool _isPlaying = false;
  bool _progressVisibility = false;
  final ThemeController themeController = Get.find<ThemeController>();

  @override
  void initState() {
    super.initState();
    _loadVideo();
  }

  void _loadVideo() async {
    await _trimmer.loadVideo(videoFile: widget.videoFile);
  }

  @override
  void dispose() {
    _trimmer.dispose();
    super.dispose();
  }

  Size _calculateVideoSize() {
    const double maxWidth = 315;
    const double maxHeight = 315;
    final videoPlayerController = _trimmer.videoPlayerController;
    if (videoPlayerController == null) {
      return const Size(maxWidth, maxWidth / (16 / 9));
    }

    final Size videoSize = videoPlayerController.value.size;
    final double videoAspectRatio = videoPlayerController.value.aspectRatio;
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

  Widget _buildVideoBox() {
    final isDark = themeController.isDarkMode;
    final size = _calculateVideoSize();

    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.grey.shade200,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
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
        child: VideoViewer(trimmer: _trimmer),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = themeController.isDarkMode;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF1E1E2E) : const Color(0xFFF5F5FA),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
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
                        color:
                            isDark ? Colors.white70 : const Color(0xFF6C63FF),
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 15),
                      // Video Preview Card
                      Container(
                        decoration: BoxDecoration(
                          color: isDark
                              ? Colors.white.withValues(alpha: 0.08)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black
                                  .withValues(alpha: isDark ? 0.20 : 0.1),
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
                                      color: const Color(0xFF6C63FF)
                                          .withValues(alpha: 0.1),
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
                                      color: isDark
                                          ? Colors.white
                                          : const Color(0xFF333333),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            _buildVideoBox(),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Trim Controls Card
                      Container(
                        decoration: BoxDecoration(
                          color: isDark
                              ? Colors.white.withValues(alpha: 0.08)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black
                                  .withValues(alpha: isDark ? 0.2 : 0.1),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            // Enhanced Trim Viewer
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(3),
                                    child: TrimViewer(
                                      trimmer: _trimmer,
                                      viewerHeight: 60,
                                      viewerWidth:
                                          MediaQuery.of(context).size.width -
                                              80,
                                      maxVideoLength:
                                          const Duration(minutes: 10),
                                      onChangeStart: (value) =>
                                          _startValue = value,
                                      onChangeEnd: (value) => _endValue = value,
                                      onChangePlaybackState: (value) =>
                                          setState(() => _isPlaying = value),
                                      showDuration: true,
                                      durationTextStyle: TextStyle(
                                        color: isDark
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  // Play/Pause Controls
                                  Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                      color: isDark
                                          ? Colors.white.withValues(alpha: 0.1)
                                          : Colors.grey.shade200,
                                      shape: BoxShape.circle,
                                    ),
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      icon: Icon(
                                        _isPlaying
                                            ? Icons.pause_rounded
                                            : Icons.play_arrow_rounded,
                                        color: isDark
                                            ? Colors.white
                                            : Colors.black87,
                                        size: 28,
                                      ),
                                      onPressed: () async {
                                        bool playbackState =
                                            await _trimmer.videoPlaybackControl(
                                          startValue: _startValue,
                                          endValue: _endValue,
                                        );
                                        setState(
                                            () => _isPlaying = playbackState);
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              ),
                            ),

                            //const SizedBox(height: 1),
                            Divider(
                              color: isDark
                                  ? Colors.white.withValues(alpha: 0.2)
                                  : Colors.grey.shade300,
                              height: 10,
                              thickness: 1,
                              indent: 10,
                              endIndent: 10,
                            ),
                            const SizedBox(height: 10),
                            // Enhanced Control Buttons
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: _progressVisibility
                                        ? null
                                        : () async {
                                            setState(() =>
                                                _progressVisibility = true);
                                            await _trimmer.saveTrimmedVideo(
                                              startValue: _startValue,
                                              endValue: _endValue,
                                              onSave: (String? path) {
                                                setState(() =>
                                                    _progressVisibility =
                                                        false);
                                                if (path != null) {
                                                  Get.back(result: File(path));
                                                }
                                              },
                                            );
                                          },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF6C63FF),
                                      foregroundColor: Colors.white,
                                      elevation: 0,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 14),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    icon: _progressVisibility
                                        ? null
                                        : const Icon(Icons.save_rounded),
                                    label: Text(
                                      _progressVisibility
                                          ? S.of(context).saving
                                          : S.of(context).save,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            if (_progressVisibility)
              Container(
                margin: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      height: 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                        ),
                      ),
                      child: const LinearProgressIndicator(
                        backgroundColor: Colors.transparent,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      S.of(context).processingVideo,
                      style: TextStyle(
                        color: isDark ? Colors.white70 : Colors.grey.shade600,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
