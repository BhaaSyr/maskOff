import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class VideoController extends GetxController {
  Rx<File?> videoFile = Rx<File?>(null);
  Rx<VideoPlayerController?> playerController =
      Rx<VideoPlayerController?>(null);
  RxBool isInitialized = false.obs;

  @override
  void onClose() {
    playerController.value?.dispose();
    super.onClose();
  }

  Future<void> pickVideo() async {
    final picker = ImagePicker();
    final pickedVideo = await picker.pickVideo(source: ImageSource.gallery);

    if (pickedVideo != null) {
      videoFile.value = File(pickedVideo.path);
      initializeController(videoFile.value!);
    }
  }

  void initializeController(File file) async {
    if (playerController.value != null) {
      await playerController.value!.pause(); // Önce durdur
      await playerController.value!.dispose(); // Sonra dispose et
      playerController.value = null; // Mutlaka null'a çek
    }

    final controller = VideoPlayerController.file(file);
    await controller.initialize();
    controller.setLooping(true);
    await controller.play();

    playerController.value = controller;
    isInitialized.value = true;

    update(); // Ekranı yenile
  }

  void showTrimmer() async {
    if (videoFile.value != null) {
      final result = await Get.toNamed(
        '/video-trim',
        arguments: videoFile.value,
      );
      if (result != null && result is File) {
        updateVideo(result);
      }
    }
  }

  void runDeepfakeCheck() {
    // Placeholder for API call to check deepfake
    Get.snackbar(
      'Processing',
      'Deepfake check would run here with an API',
      backgroundColor: Colors.blueGrey,
      colorText: Colors.white,
    );
  }

  void clearVideo() async {
    if (playerController.value != null) {
      await playerController.value!.pause();
      await playerController.value!.dispose();
      playerController.value = null;
    }

    videoFile.value = null;
    isInitialized.value = false;
    update();
  }

  void updateVideo(File newVideo) {
    videoFile.value = newVideo;
    initializeController(newVideo);
    update();
  }
}
