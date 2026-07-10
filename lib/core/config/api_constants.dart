/// API endpoint paths and header keys.
abstract final class ApiConstants {
  static const String contentType = 'application/json';
  static const String accept = 'application/json';
  static const String authorization = 'Authorization';
  static const String bearerPrefix = 'Bearer';
  static const String apiKey = 'x-api-key';
  static const String multipartContentType = 'multipart/form-data';

  /// [Dio] `RequestOptions.extra` key for [ApiRequestConfig].
  static const String requestConfigKey = 'api_request_config';
}
