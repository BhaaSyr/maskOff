import 'dart:io';

import 'package:get/get.dart';
import 'package:testvid/feature/controllers/home_controller.dart';
import 'package:testvid/feature/controllers/profile/profile_controller.dart';
import 'package:testvid/generated/l10n.dart';
import 'package:video_player/video_player.dart';
import '../domain/entities/deepfake_result_entity.dart';
import '../domain/usecases/analyze_video_usecase.dart';

class ResultController extends GetxController {
  final AnalyzeVideoUseCase analyzeVideoUseCase;

  Rx<DeepfakeResultEntity?> result = Rx<DeepfakeResultEntity?>(null);
  Rx<VideoPlayerController?> videoController = Rx<VideoPlayerController?>(null);
  RxBool isVideoLoading = true.obs;
  RxBool isVideoPlaying = false.obs;
  RxBool isAnalyzing = false.obs;

  ResultController({required this.analyzeVideoUseCase});

  @override
  void onInit() {
    super.onInit();
    print('ResultController: onInit called');
    if (Get.arguments != null) {
      print('ResultController: Arguments received: ${Get.arguments}');
      if (Get.arguments is DeepfakeResultEntity) {
        print('ResultController: Arguments is DeepfakeResultEntity');
        result.value = Get.arguments as DeepfakeResultEntity;
        print(
            'ResultController: Result set from arguments: ${result.value?.result}, confidence: ${result.value?.confidence}');
        _initializeVideoPlayerFromFile(File(Get.arguments.toString()));
      } else {
        print(
            'ResultController: Arguments is not DeepfakeResultEntity: ${Get.arguments.runtimeType}');
      }
    } else {
      print('ResultController: No arguments received');
    }
  }

  @override
  void onClose() {
    videoController.value?.dispose();
    super.onClose();
  }

  Future<void> analyzeVideo(File videoFile) async {
    try {
      print(
          'ResultController: Starting video analysis for file: ${videoFile.path}');
      isAnalyzing.value = true;

      print('ResultController: Calling analyzeVideoUseCase.execute');
      final resultEntity = await analyzeVideoUseCase.execute(videoFile);
      print(
          'ResultController: Analysis complete. Result: ${resultEntity.result}, Confidence: ${resultEntity.confidence}');

      result.value = resultEntity;
      print(
          'ResultController: Result updated in controller: ${result.value?.result}, confidence: ${result.value?.confidence}');

      await _initializeVideoPlayerFromFile(videoFile);
      print('ResultController: Video player initialized');

      await _saveAnalysisToHistory();
      print('ResultController: Analysis saved to history');
    } catch (e) {
      print('ResultController: Error during analysis: $e');
      Get.snackbar(
        'Error',
        'Failed to analyze video: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
        backgroundColor: Get.theme.colorScheme.error.withOpacity(0.8),
        colorText: Get.theme.colorScheme.onError,
      );
    } finally {
      isAnalyzing.value = false;
      print(
          'ResultController: Analysis process completed. isAnalyzing: ${isAnalyzing.value}');
    }
  }

  Future<void> _initializeVideoPlayerFromFile(File videoFile) async {
    try {
      print(
          'ResultController: Initializing video player for file: ${videoFile.path}');
      isVideoLoading.value = true;
      videoController.value?.dispose();

      videoController.value = VideoPlayerController.file(videoFile)
        ..initialize().then((_) {
          videoController.value!.setLooping(true);
          isVideoLoading.value = false;
          print('ResultController: Video player initialized successfully');
        });

      videoController.value!.addListener(() {
        isVideoPlaying.value = videoController.value!.value.isPlaying;
      });
    } catch (e) {
      isVideoLoading.value = false;
      print('ResultController: Failed to initialize video player: $e');
    }
  }

  void togglePlayPause() {
    if (videoController.value != null) {
      if (videoController.value!.value.isPlaying) {
        videoController.value!.pause();
      } else {
        videoController.value!.play();
      }
    }
  }

  String getResultText() {
    if (result.value == null) {
      print('ResultController: getResultText called but result is null');
      return '';
    }

    final score = result.value!.confidence.toStringAsFixed(1);
    print(
        'ResultController: getResultText - score: $score, isDeepfake: ${result.value!.isDeepfake}');

    if (result.value!.isDeepfake) {
      return "Bu video %$score olasılıkla deepfake içeriyor.";
    } else {
      return "Bu video %$score olasılıkla gerçek görünüyor.";
    }
  }

  String getResultColor() {
    if (result.value == null) {
      print('ResultController: getResultColor called but result is null');
      return 'low';
    }

    print(
        'ResultController: getResultColor - confidence: ${result.value!.confidence}, isDeepfake: ${result.value!.isDeepfake}');

    if (result.value!.isDeepfake) {
      if (result.value!.confidence > 70) {
        return 'high';
      } else {
        return 'medium';
      }
    } else {
      return 'low';
    }
  }

  Future<void> _saveAnalysisToHistory() async {
    try {
      final context = Get.context;
      if (context == null || result.value == null) {
        print(
            'ResultController: Cannot save to history - context or result is null');
        return;
      }

      print('ResultController: Saving analysis to history');
      ProfileController profileController;
      try {
        profileController = Get.find<ProfileController>();
      } catch (e) {
        print(
            'ResultController: ProfileController not found, creating new instance');
        profileController = Get.put(ProfileController());
      }

      final title = S.of(context).videoAnalysis('Analyzed Video');
      final description = result.value!.isDeepfake
          ? S.of(context).deepfakeDetectionCompleted
          : S.of(context).authenticVideoVerificationCompleted;
      final resultText = result.value!.isDeepfake
          ? S.of(context).deepfakeDetected
          : S.of(context).realVideo;

      print(
          'ResultController: Adding history record - title: $title, description: $description');
      await profileController.addHistoryRecord(
        title: title,
        description: description,
      );

      if (profileController.historyRecords.isNotEmpty) {
        final latestRecordId = profileController.historyRecords.first.id;
        print(
            'ResultController: Updating history record - id: $latestRecordId, result: $resultText, confidence: ${result.value!.confidence}');
        await profileController.updateHistoryRecord(
          recordId: latestRecordId,
          result: resultText,
          confidence: result.value!.confidence,
        );
      }
      print('ResultController: Analysis saved to history successfully');
    } catch (e) {
      print('ResultController: Failed to save analysis to history: $e');
    }
  }
}
