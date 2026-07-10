import 'package:dio/dio.dart';

/// Attaches the ReqRes `x-api-key` header when an API key is configured.
class ApiKeyInterceptor extends Interceptor {
  ApiKeyInterceptor({this.apiKey});

  static const String headerKey = 'x-api-key';

  final String? apiKey;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final key = apiKey;
    if (key != null && key.isNotEmpty) {
      options.headers[headerKey] = key;
    }

    handler.next(options);
  }
}
