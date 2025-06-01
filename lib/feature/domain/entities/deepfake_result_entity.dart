class DeepfakeResultEntity {
  final double confidence;
  final String result;
  final DateTime analyzedAt;

  DeepfakeResultEntity({
    required this.confidence,
    required this.result,
    required this.analyzedAt,
  });

  bool get isDeepfake => result.toLowerCase() == 'fake';

  static DeepfakeResultEntity get processing => DeepfakeResultEntity(
        confidence: 0.0,
        result: 'Processing',
        analyzedAt: DateTime.now(),
      );

  static DeepfakeResultEntity get unknown => DeepfakeResultEntity(
        confidence: 0.0,
        result: 'Unknown',
        analyzedAt: DateTime.now(),
      );
}
