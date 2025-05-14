import 'dart:io';
import 'package:dio/dio.dart';
import 'package:testvid/data/api_provider.dart';
import 'package:testvid/data/result_model.dart';

class DeepfakeRepository {
  final ApiProvider _apiProvider = ApiProvider();

  Future<DeepfakeResult> checkDeepfake(File videoFile) async {
    try {
      final Response response = await _apiProvider.checkDeepfake(videoFile);

      if (response.statusCode == 200) {
        return DeepfakeResult.fromJson(response.data);
      } else {
        throw Exception('API error: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        if (e.type == DioExceptionType.connectionTimeout) {
          throw Exception(
              'Bağlantı zaman aşımı. Lütfen internet bağlantınızı kontrol edin.');
        } else if (e.type == DioExceptionType.receiveTimeout) {
          throw Exception(
              'Sunucu yanıt vermiyor. Lütfen daha sonra tekrar deneyin.');
        } else {
          throw Exception('API hatası: ${e.message}');
        }
      } else {
        throw Exception('Beklenmeyen bir hata oluştu: $e');
      }
    }
  }
}
