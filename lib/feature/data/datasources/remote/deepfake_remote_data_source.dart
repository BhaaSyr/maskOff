import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../../../domain/entities/deepfake_result_entity.dart';
import '../../models/deepfake_result_model.dart';

abstract class DeepfakeRemoteDataSource {
  Future<DeepfakeResultModel> analyzeVideo(File videoFile);
}

class DeepfakeRemoteDataSourceImpl implements DeepfakeRemoteDataSource {
  final String baseUrl = 'http://10.0.2.2:5000';

  @override
  Future<DeepfakeResultModel> analyzeVideo(File videoFile) async {
    try {
      // Create multipart request
      final uri = Uri.parse('$baseUrl/predict');
      print('Sending request to: $uri');

      var request = http.MultipartRequest('POST', uri);

      // Add file to request
      var stream = http.ByteStream(videoFile.openRead());
      var length = await videoFile.length();

      print('Uploading file: ${videoFile.path} (${length} bytes)');

      var multipartFile = http.MultipartFile(
        'video',
        stream,
        length,
        filename: videoFile.path.split('/').last,
      );
      request.files.add(multipartFile);

      // Send request and monitor progress
      print('Sending request to server...');
      var streamedResponse = await request.send();
      print('Response status code: ${streamedResponse.statusCode}');

      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        print('Response received successfully');
        print('Response body: ${response.body}');

        final Map<String, dynamic> data = json.decode(response.body);

        return DeepfakeResultModel.fromJson(data);
      } else {
        print('Server error: ${response.statusCode}');
        print('Error body: ${response.body}');
        throw Exception('Failed to analyze video: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during API call: $e');
      // Show error message to user
      Get.snackbar(
        'Error',
        'Failed to connect to server: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
        duration: const Duration(seconds: 5),
      );
      rethrow;
    }
  }
}
