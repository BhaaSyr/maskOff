import '../../domain/entities/deepfake_result_entity.dart';

class DeepfakeResultModel extends DeepfakeResultEntity {
  DeepfakeResultModel({
    required double confidence,
    required String result,
    required DateTime analyzedAt,
  }) : super(
          confidence: confidence,
          result: result,
          analyzedAt: analyzedAt,
        );

  factory DeepfakeResultModel.fromJson(Map<String, dynamic> json) {
    return DeepfakeResultModel(
      confidence: (json['confidence'] as num).toDouble(),
      result: json['result'] as String,
      analyzedAt: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'confidence': confidence,
      'result': result,
      'analyzedAt': analyzedAt.toIso8601String(),
    };
  }

  DeepfakeResultEntity toEntity() {
    return DeepfakeResultEntity(
      confidence: confidence,
      result: result,
      analyzedAt: analyzedAt,
    );
  }
}
