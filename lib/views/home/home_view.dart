import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testvid/controllers/home_controller.dart';
import 'package:testvid/views/home/widgets/black_area_painter.dart';
import 'package:testvid/views/home/widgets/button.dart';
import 'package:testvid/views/home/widgets/video_player_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final VideoController controller = Get.put(VideoController());

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          // Light gray top area with video player
          Expanded(
            flex: 4,
            child: Center(
              child: Obx(() {
                if (controller.playerController.value != null &&
                    controller.isInitialized.value) {
                  return VideoPlayerWidget(
                    controller: controller.playerController.value!,
                  );
                } else {
                  return _buildEmptyState();
                }
              }),
            ),
          ),

          // Dark bottom area with CustomPaint
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                // Siyah arka plan özel tasarım
                CustomPaint(
                  size: Size(MediaQuery.of(context).size.width,
                      double.infinity as double),
                  painter: BlackAreaPainter(),
                ),

                // İçerik (butonlar)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 45, vertical: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Button(
                        icon: Icons.file_upload_outlined,
                        label: "Upload Video",
                        onPressed: controller.pickVideo,
                      ),
                      const SizedBox(height: 25),
                      Button(
                        icon: Icons.arrow_forward_ios,
                        iconSize: 19,
                        label: "Run Deepfake Check",
                        //onPressed: controller.runDeepfakeCheck,7
                        onPressed: () {
                          Get.toNamed("/result");
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Text(
        "Upload a video to begin",
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey,
        ),
      ),
    );
  }
}
