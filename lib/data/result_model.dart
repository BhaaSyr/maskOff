class DeepfakeResult {
  final bool isDeepfake;
  final double confidenceScore;
  final Map<String, dynamic> detailAnalysis;
  final String processedVideoUrl;
  final DateTime analyzedAt;

  DeepfakeResult({
    required this.isDeepfake,
    required this.confidenceScore,
    required this.detailAnalysis,
    required this.processedVideoUrl,
    required this.analyzedAt,
  });

  factory DeepfakeResult.fromJson(Map<String, dynamic> json) {
    return DeepfakeResult(
      isDeepfake: json['is_deepfake'] ?? false,
      confidenceScore: (json['confidence_score'] ?? 0.0).toDouble(),
      detailAnalysis: json['detail_analysis'] ?? {},
      processedVideoUrl: json['processed_video_url'] ?? '',
      analyzedAt: DateTime.parse(
          json['analyzed_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'is_deepfake': isDeepfake,
      'confidence_score': confidenceScore,
      'detail_analysis': detailAnalysis,
      'processed_video_url': processedVideoUrl,
      'analyzed_at': analyzedAt.toIso8601String(),
    };
  }
}
