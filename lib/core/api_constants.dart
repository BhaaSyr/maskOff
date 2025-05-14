class ApiConstants {
  static const String baseUrl = 'https://your-api-endpoint.com/api';
  static const String deepfakeCheckEndpoint = '/check-deepfake';

  // API Headers
  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // API Timeout durations
  static const int connectionTimeout = 30000; // 30 saniye
  static const int receiveTimeout = 30000; // 30 saniye
}
