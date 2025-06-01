import 'dart:io';
import '../../domain/entities/deepfake_result_entity.dart';
import '../../domain/repositories/deepfake_repository.dart';
import '../datasources/remote/deepfake_remote_data_source.dart';

class DeepfakeRepositoryImpl implements DeepfakeRepository {
  final DeepfakeRemoteDataSource remoteDataSource;

  DeepfakeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<DeepfakeResultEntity> analyzeVideo(File videoFile) async {
    try {
      return await remoteDataSource.analyzeVideo(videoFile);
    } catch (e) {
      throw Exception('Repository error: $e');
    }
  }
}
