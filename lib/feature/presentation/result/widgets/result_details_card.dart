import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testvid/feature/controllers/result_controller.dart';
import 'package:testvid/generated/l10n.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'dart:io';

class ResultDetailsCard extends StatelessWidget {
  final bool isDark;
  final ResultController controller;

  const ResultDetailsCard({
    super.key,
    required this.isDark,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.05) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Video Thumbnail
          FutureBuilder<String?>(
            future: _generateThumbnail(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasError || !snapshot.hasData) {
                return Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.white.withOpacity(0.1)
                        : Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.video_library,
                    size: 48,
                    color: isDark ? Colors.white70 : Colors.grey[600],
                  ),
                );
              }

              return Container(
                height: 200,
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: FileImage(File(snapshot.data!)),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),

          Text(
            S.of(context).analysisDetails,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : const Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 10),
          _buildDetailRow(
            S.of(context).confidenceScore,
            '${(controller.result.value!.confidence).toStringAsFixed(1)}%',
            isDark,
          ),
          const SizedBox(height: 7),
          _buildDetailRow(
            S.of(context).resultType,
            controller.result.value!.isDeepfake
                ? S.of(context).deepfakeVideo
                : S.of(context).realVideo,
            isDark,
          ),
          const SizedBox(height: 7),
          _buildDetailRow(
            S.of(context).analysisDate,
            DateTime.now().toString().split('.')[0],
            isDark,
          ),
        ],
      ),
    );
  }

  Future<String?> _generateThumbnail() async {
    if (controller.videoFile.value == null) return null;

    final thumbnail = await VideoThumbnail.thumbnailFile(
      video: controller.videoFile.value!.path,
      thumbnailPath: (await Directory.systemTemp.createTemp()).path,
      imageFormat: ImageFormat.JPEG,
      maxHeight: 200,
      quality: 100,
    );

    return thumbnail;
  }

  Widget _buildDetailRow(String label, String value, bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: isDark ? Colors.white70 : const Color(0xFF666666),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : const Color(0xFF333333),
          ),
        ),
      ],
    );
  }
}
