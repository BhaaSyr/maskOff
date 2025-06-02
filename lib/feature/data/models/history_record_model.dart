class HistoryRecordModel {
  final String id;
  final String userId;
  final String title;
  final String description;
  final String? result;
  final double? confidence;
  final DateTime createdAt;

  HistoryRecordModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    this.result,
    this.confidence,
    required this.createdAt,
  });

  // Convert HistoryRecordModel to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'description': description,
      'result': result,
      'confidence': confidence,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  // Create HistoryRecordModel from Firestore Map
  factory HistoryRecordModel.fromMap(Map<String, dynamic> map) {
    return HistoryRecordModel(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      result: map['result'],
      confidence: map['confidence']?.toDouble(),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] ?? 0),
    );
  }

  // Copy with method for updates
  HistoryRecordModel copyWith({
    String? id,
    String? userId,
    String? title,
    String? description,
    String? result,
    double? confidence,
    DateTime? createdAt,
  }) {
    return HistoryRecordModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      result: result ?? this.result,
      confidence: confidence ?? this.confidence,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  // Format date for display
  String get formattedDate {
    return '${createdAt.day}/${createdAt.month}/${createdAt.year}';
  }

  // Format time for display
  String get formattedTime {
    return '${createdAt.hour.toString().padLeft(2, '0')}:${createdAt.minute.toString().padLeft(2, '0')}';
  }

  // Get formatted confidence percentage
  String get formattedConfidence {
    if (confidence == null) return 'N/A';
    return '${confidence!.toStringAsFixed(1)}%';
  }

  // Get result color based on result type
  String get resultColor {
    if (result == null) return 'unknown';
    if (result!.toLowerCase().contains('real') ||
        result!.toLowerCase().contains('gerçek')) {
      return 'real';
    }
    if (result!.toLowerCase().contains('fake') ||
        result!.toLowerCase().contains('deepfake')) {
      return 'fake';
    }
    return 'unknown';
  }

  @override
  String toString() {
    return 'HistoryRecordModel(id: $id, title: $title, createdAt: $createdAt)';
  }
}
