import 'dart:io';

import 'package:get/get.dart';
import 'package:testvid/feature/controllers/home_controller.dart';
import 'package:testvid/feature/controllers/profile/profile_controller.dart';
import 'package:testvid/generated/l10n.dart';
import 'package:video_player/video_player.dart';
import '../domain/entities/deepfake_result_entity.dart';
import '../domain/usecases/analyze_video_usecase.dart';
import 'package:testvid/core/services/app_logger.dart';

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
    AppLogger().info('ResultController: onInit called');
    if (Get.arguments != null) {
      AppLogger()
          .info('ResultController: Arguments received: ${Get.arguments}');
      if (Get.arguments is DeepfakeResultEntity) {
        AppLogger().info('ResultController: Arguments is DeepfakeResultEntity');
        result.value = Get.arguments as DeepfakeResultEntity;
        AppLogger().info(
            'ResultController: Result set from arguments: ${result.value?.result}, confidence: ${result.value?.confidence}');
        _initializeVideoPlayerFromFile(File(Get.arguments.toString()));
      } else {
        AppLogger().warning(
            'ResultController: Arguments is not DeepfakeResultEntity: ${Get.arguments.runtimeType}');
      }
    } else {
      AppLogger().warning('ResultController: No arguments received');
    }
  }

  @override
  void onClose() {
    videoController.value?.dispose();
    super.onClose();
  }

  Future<void> analyzeVideo(File videoFile) async {
    try {
      AppLogger().info(
          'ResultController: Starting video analysis for file: ${videoFile.path}');
      isAnalyzing.value = true;

      AppLogger().info('ResultController: Calling analyzeVideoUseCase.execute');
      final resultEntity = await analyzeVideoUseCase.execute(videoFile);
      AppLogger().info(
          'ResultController: Analysis complete. Result: ${resultEntity.result}, Confidence: ${resultEntity.confidence}');

      result.value = resultEntity;
      AppLogger().info(
          'ResultController: Result updated in controller: ${result.value?.result}, confidence: ${result.value?.confidence}');

      await _initializeVideoPlayerFromFile(videoFile);
      AppLogger().info('ResultController: Video player initialized');

      await _saveAnalysisToHistory();
      AppLogger().info('ResultController: Analysis saved to history');
    } catch (e) {
      AppLogger().error('ResultController: Error during analysis: $e');
      Get.snackbar(
        'Error',
        'Failed to analyze video: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
        backgroundColor: Get.theme.colorScheme.error.withValues(alpha: 0.8),
        colorText: Get.theme.colorScheme.onError,
      );
    } finally {
      isAnalyzing.value = false;
      AppLogger().info(
          'ResultController: Analysis process completed. isAnalyzing: ${isAnalyzing.value}');
    }
  }

  Future<void> _initializeVideoPlayerFromFile(File videoFile) async {
    try {
      AppLogger().info(
          'ResultController: Initializing video player for file: ${videoFile.path}');
      isVideoLoading.value = true;
      videoController.value?.dispose();

      videoController.value = VideoPlayerController.file(videoFile)
        ..initialize().then((_) {
          videoController.value!.setLooping(true);
          isVideoLoading.value = false;
          AppLogger()
              .info('ResultController: Video player initialized successfully');
        });

      videoController.value!.addListener(() {
        isVideoPlaying.value = videoController.value!.value.isPlaying;
      });
    } catch (e) {
      isVideoLoading.value = false;
      AppLogger()
          .error('ResultController: Failed to initialize video player: $e');
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
      AppLogger()
          .warning('ResultController: getResultText called but result is null');
      return '';
    }

    final score = result.value!.confidence.toStringAsFixed(1);
    AppLogger().info(
        'ResultController: getResultText - score: $score, isDeepfake: ${result.value!.isDeepfake}');

    if (result.value!.isDeepfake) {
      return "Bu video %$score olasılıkla deepfake içeriyor.";
    } else {
      return "Bu video %$score olasılıkla gerçek görünüyor.";
    }
  }

  String getResultColor() {
    if (result.value == null) {
      AppLogger().warning(
          'ResultController: getResultColor called but result is null');
      return 'low';
    }

    AppLogger().info(
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
      AppLogger().info('ResultController: Saving analysis to history');

      final context = Get.context;
      if (context == null || result.value == null) {
        AppLogger().warning(
            'ResultController: Cannot save to history - context or result is null');
        return;
      }

      AppLogger().info('ResultController: Saving analysis to history');
      ProfileController profileController;
      try {
        profileController = Get.find<ProfileController>();
      } catch (e) {
        AppLogger().info(
            'ResultController: ProfileController not found, creating new instance');
        profileController = Get.put(ProfileController());
      }

      final videoController = Get.find<VideoController>();
      final videoName = videoController.videoFile.value?.path.split('/').last ??
          'Unknown Video';
      final title = S.of(context).videoAnalysis(videoName);
      final description = result.value!.isDeepfake
          ? S.of(context).deepfakeDetectionCompleted
          : S.of(context).authenticVideoVerificationCompleted;
      final resultText = result.value!.isDeepfake
          ? S.of(context).deepfakeDetected
          : S.of(context).realVideo;

      AppLogger().info(
          'ResultController: Adding history record - title: $title, description: $description');
      await profileController.addHistoryRecord(
        title: title,
        description: description,
      );

      if (profileController.historyRecords.isNotEmpty) {
        final latestRecordId = profileController.historyRecords.first.id;
        AppLogger().info(
            'ResultController: Updating history record - id: $latestRecordId, result: $resultText, confidence: ${result.value!.confidence}');
        await profileController.updateHistoryRecord(
          recordId: latestRecordId,
          result: resultText,
          confidence: result.value!.confidence,
        );
      }
      AppLogger()
          .info('ResultController: Analysis saved to history successfully');
    } catch (e) {
      AppLogger()
          .error('ResultController: Failed to save analysis to history: $e');
    }
  }
}
