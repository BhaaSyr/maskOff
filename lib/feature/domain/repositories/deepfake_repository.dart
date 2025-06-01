import 'dart:io';
import '../entities/deepfake_result_entity.dart';

abstract class DeepfakeRepository {
  Future<DeepfakeResultEntity> analyzeVideo(File videoFile);
}
