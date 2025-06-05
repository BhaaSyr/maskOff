import 'package:flutter/material.dart';
import 'package:video_trimmer/video_trimmer.dart';
import 'package:testvid/generated/l10n.dart';

class VideoTrimControls extends StatelessWidget {
  final Trimmer trimmer;
  final bool isDark;
  final bool isPlaying;
  final double startValue;
  final double endValue;
  final Function(double) onChangeStart;
  final Function(double) onChangeEnd;
  final Function(bool) onChangePlaybackState;
  final VoidCallback onPlayPause;
  final VoidCallback onSave;
  final bool isSaving;

  const VideoTrimControls({
    super.key,
    required this.trimmer,
    required this.isDark,
    required this.isPlaying,
    required this.startValue,
    required this.endValue,
    required this.onChangeStart,
    required this.onChangeEnd,
    required this.onChangePlaybackState,
    required this.onPlayPause,
    required this.onSave,
    required this.isSaving,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.08) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: TrimViewer(
                    trimmer: trimmer,
                    viewerHeight: 60,
                    viewerWidth: MediaQuery.of(context).size.width - 80,
                    maxVideoLength: const Duration(minutes: 10),
                    onChangeStart: onChangeStart,
                    onChangeEnd: onChangeEnd,
                    onChangePlaybackState: onChangePlaybackState,
                    showDuration: true,
                    durationTextStyle: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.white.withOpacity(0.1)
                        : Colors.grey.shade200,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      isPlaying
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded,
                      color: isDark ? Colors.white : Colors.black87,
                      size: 28,
                    ),
                    onPressed: onPlayPause,
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          Divider(
            color:
                isDark ? Colors.white.withOpacity(0.2) : Colors.grey.shade300,
            height: 10,
            thickness: 1,
            indent: 10,
            endIndent: 10,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: isSaving ? null : onSave,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C63FF),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: isSaving ? null : const Icon(Icons.save_rounded),
                  label: Text(
                    isSaving ? S.of(context).saving : S.of(context).save,
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
    );
  }
}
