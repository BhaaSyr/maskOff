import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testvid/views/home/widgets/black_area_painter.dart';
import 'package:testvid/views/home/widgets/button.dart';
import '../../controllers/result_controller.dart';
import 'widgets/result_card_widget.dart';

class ResultView extends GetView<ResultController> {
  const ResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analiz Sonuçları'),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Align(
              alignment: Alignment(0, -0.7),
              child: Obx(() => SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16),
                    // Sonuç Kartı
                    child: ResultCardWidget(
                      isDeepfake: controller.result.value.isDeepfake,
                      confidenceScore: controller.result.value.confidenceScore,
                      resultText: controller.getResultText(),
                      resultColor: controller.getResultColor(),
                    ),
                  )),
            ),
          ),
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
                  child: Center(
                    child: Button(
                      icon: Icons.arrow_back_ios,
                      iconSize: 19,
                      label: "Back to Homepage",
                      //onPressed: controller.runDeepfakeCheck,7
                      onPressed: () {
                        Get.offNamed("/home");
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
