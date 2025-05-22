import 'dart:io';

import 'package:get/get.dart';
import 'package:testvid/controllers/home_controller.dart';
import 'package:testvid/data/result_model.dart';
import 'package:video_player/video_player.dart';

class ResultController extends GetxController {
  late Rx<DeepfakeResult> result;
  Rx<VideoPlayerController?> videoController = Rx<VideoPlayerController?>(null);
  RxBool isVideoLoading = true.obs;
  RxBool isVideoPlaying = false.obs;

  final VideoController videoCtrl =
      Get.find<VideoController>(); // VideoController'ı bul

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments is DeepfakeResult) {
      result = (Get.arguments as DeepfakeResult).obs;

      if (result.value.processedVideoUrl.isNotEmpty) {
        _initializeVideoPlayer(result.value.processedVideoUrl);
      }
    } else if (videoCtrl.videoFile.value != null) {
      // Kullanıcı bir video seçtiyse
      double score =
          0.95; // Buraya istersen random verebilirsin veya sabit bir oran

      result = DeepfakeResult(
        isDeepfake: score > 0.5, // <<< oran 0.5'ten büyükse deepfake
        confidenceScore: score,
        detailAnalysis: {
          'face_swap': 0.9,
          'lip_sync': 0.8,
          'expression_mismatch': 0.75,
        },
        processedVideoUrl: '', // URL yok çünkü dosya üzerinden
        analyzedAt: DateTime.now(),
      ).obs;

      _initializeVideoPlayerFromFile(videoCtrl.videoFile.value!);
    } else {
      // Hiç video yoksa
      result = DeepfakeResult(
        isDeepfake: false,
        confidenceScore: 0.0,
        detailAnalysis: {},
        processedVideoUrl: '',
        analyzedAt: DateTime.now(),
      ).obs;
    }
  }

  @override
  void onClose() {
    videoController.value?.dispose();
    super.onClose();
  }

  void _initializeVideoPlayer(String videoUrl) {
    try {
      isVideoLoading.value = true;
      videoController.value?.dispose();
      videoController.value = VideoPlayerController.network(videoUrl)
        ..initialize().then((_) {
          videoController.value!.setLooping(true);
          isVideoLoading.value = false;
        });
      videoController.value!.addListener(() {
        isVideoPlaying.value = videoController.value!.value.isPlaying;
      });
    } catch (e) {
      isVideoLoading.value = false;
      print('An error occurred while starting the video player: $e');
    }
  }

  void _initializeVideoPlayerFromFile(File file) {
    try {
      isVideoLoading.value = true;
      videoController.value?.dispose();
      videoController.value = VideoPlayerController.file(file)
        ..initialize().then((_) {
          videoController.value!.setLooping(true);
          isVideoLoading.value = false;
        });
      videoController.value!.addListener(() {
        isVideoPlaying.value = videoController.value!.value.isPlaying;
      });
    } catch (e) {
      isVideoLoading.value = false;
      print('An error occurred while starting the video player: $e');
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
    final score = result.value.isDeepfake
        ? (result.value.confidenceScore * 100).toStringAsFixed(1)
        : ((1 - result.value.confidenceScore) * 100).toStringAsFixed(1);

    if (result.value.isDeepfake) {
      return "Bu video %$score olasılıkla deepfake içeriyor.";
    } else {
      return "Bu video %$score olasılıkla gerçek görünüyor.";
    }
  }

  String getResultColor() {
    if (result.value.isDeepfake) {
      if (result.value.confidenceScore > 0.7) {
        return 'high';
      } else {
        return 'medium';
      }
    } else {
      return 'low';
    }
  }
}

// class ResultController extends GetxController {
//   late Rx<DeepfakeResult> result;
//   Rx<VideoPlayerController?> videoController = Rx<VideoPlayerController?>(null);
//   RxBool isVideoLoading = true.obs;
//   RxBool isVideoPlaying = false.obs;

//   @override
//   void onInit() {
//     super.onInit();

//     // Get.arguments kullanarak önceki sayfadan gelen veriyi al
//     if (Get.arguments is DeepfakeResult) {
//       result = (Get.arguments as DeepfakeResult).obs;

//       // API'den dönen işlenmiş video URL'sini kullanarak video oynatıcıyı başlat
//       if (result.value.processedVideoUrl.isNotEmpty) {
//         _initializeVideoPlayer(result.value.processedVideoUrl);
//       }
//     } else {
//       // Argüman yoksa veya yanlış tipte ise yeni bir boş sonuç oluştur
//       result = DeepfakeResult(
//         isDeepfake: false,
//         confidenceScore: 0.0,
//         detailAnalysis: {},
//         processedVideoUrl: '',
//         analyzedAt: DateTime.now(),
//       ).obs;
//     }
//   }

//   @override
//   void onClose() {
//     videoController.value?.dispose();
//     super.onClose();
//   }

//   void _initializeVideoPlayer(String videoUrl) {
//     try {
//       isVideoLoading.value = true;

//       // Önceki controller varsa temizle
//       videoController.value?.dispose();

//       // Yeni controller oluştur
//       videoController.value = VideoPlayerController.network(videoUrl)
//         ..initialize().then((_) {
//           videoController.value!.setLooping(true);
//           isVideoLoading.value = false;
//         });

//       videoController.value!.addListener(() {
//         isVideoPlaying.value = videoController.value!.value.isPlaying;
//       });
//     } catch (e) {
//       isVideoLoading.value = false;
//       print('Video oynatıcı başlatılırken bir hata oluştu: $e');
//     }
//   }

//   void togglePlayPause() {
//     if (videoController.value != null) {
//       if (videoController.value!.value.isPlaying) {
//         videoController.value!.pause();
//       } else {
//         videoController.value!.play();
//       }
//     }
//   }

//   String getResultText() {
//     if (result.value.isDeepfake) {
//       final score = (result.value.confidenceScore * 100).toStringAsFixed(1);
//       return 'Bu video %$score olasılıkla deepfake içeriyor.';
//     } else {
//       final score =
//           ((1 - result.value.confidenceScore) * 100).toStringAsFixed(1);
//       return 'Bu video %$score olasılıkla gerçek görünüyor.';
//     }
//   }

//   String getResultColor() {
//     if (result.value.isDeepfake) {
//       if (result.value.confidenceScore > 0.7) {
//         return 'high'; // Yüksek riskli - kırmızı
//       } else {
//         return 'medium'; // Orta riskli - turuncu
//       }
//     } else {
//       return 'low'; // Düşük riskli - yeşil
//     }
//   }
// }
