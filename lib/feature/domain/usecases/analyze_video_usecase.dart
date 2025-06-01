import 'dart:io';
import '../entities/deepfake_result_entity.dart';
import '../repositories/deepfake_repository.dart';

class AnalyzeVideoUseCase {
  final DeepfakeRepository repository;

  AnalyzeVideoUseCase({required this.repository});

  Future<DeepfakeResultEntity> execute(File videoFile) async {
    try {
      return await repository.analyzeVideo(videoFile);
    } catch (e) {
      throw Exception('UseCase error: $e');
    }
  }
}
