import 'dart:io';
import 'package:dio/dio.dart';
// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart';
import 'package:testvid/core/api_constants.dart';

class ApiProvider {
  final Dio _dio = Dio();

  ApiProvider() {
    _dio.options.baseUrl = ApiConstants.baseUrl;
    _dio.options.connectTimeout =
        const Duration(milliseconds: ApiConstants.connectionTimeout);
    _dio.options.receiveTimeout =
        const Duration(milliseconds: ApiConstants.receiveTimeout);
    _dio.options.headers = ApiConstants.headers;
  }

  Future<Response> checkDeepfake(File videoFile) async {
    try {
      String fileName = videoFile.path.split('/').last;
      FormData formData = FormData.fromMap({
        'video': await MultipartFile.fromFile(
          videoFile.path,
          filename: fileName,
          contentType: MediaType(
              'video', 'mp4'), // Videoyu video/mp4 olarak gönderiyoruz
        ),
      });

      final response = await _dio.post(
        ApiConstants.deepfakeCheckEndpoint,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
