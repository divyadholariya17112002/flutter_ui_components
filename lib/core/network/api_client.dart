import 'package:dio/dio.dart';
import 'package:flutter_ui_components/core/config/api_constants.dart';
import 'package:flutter_ui_components/core/network/error/api_error_handler.dart';
import 'package:flutter_ui_components/core/network/models/api_request_config.dart';
import 'package:flutter_ui_components/core/network/models/api_response.dart';
import 'package:flutter_ui_components/core/network/network_info.dart';
import 'package:flutter_ui_components/core/utils/exceptions.dart';

/// Reusable HTTP client wrapping [Dio] with connectivity checks, retries,
/// interceptors, and a standardized [ApiResponse] wrapper.
class ApiClient {
  ApiClient({
    required Dio dio,
    required NetworkInfo networkInfo,
  })  : _dio = dio,
        _networkInfo = networkInfo;

  final Dio _dio;
  final NetworkInfo _networkInfo;

  // ── GET ──────────────────────────────────────────────────────────────────

  Future<ApiResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ApiRequestConfig config = ApiRequestConfig.defaults,
  }) {
    return _execute<T>(
      () => _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: _mergeOptions(options, config),
        cancelToken: cancelToken,
      ),
      config: config,
    );
  }

  // ── POST ─────────────────────────────────────────────────────────────────

  Future<ApiResponse<T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ApiRequestConfig config = ApiRequestConfig.defaults,
    ProgressCallback? onSendProgress,
  }) {
    return _execute<T>(
      () => _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: _mergeOptions(options, config),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
      ),
      config: config,
    );
  }

  // ── PUT ──────────────────────────────────────────────────────────────────

  Future<ApiResponse<T>> put<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ApiRequestConfig config = ApiRequestConfig.defaults,
  }) {
    return _execute<T>(
      () => _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: _mergeOptions(options, config),
        cancelToken: cancelToken,
      ),
      config: config,
    );
  }

  // ── DELETE ───────────────────────────────────────────────────────────────

  Future<ApiResponse<T>> delete<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ApiRequestConfig config = ApiRequestConfig.defaults,
  }) {
    return _execute<T>(
      () => _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: _mergeOptions(options, config),
        cancelToken: cancelToken,
      ),
      config: config,
    );
  }

  // ── PATCH ────────────────────────────────────────────────────────────────

  Future<ApiResponse<T>> patch<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ApiRequestConfig config = ApiRequestConfig.defaults,
  }) {
    return _execute<T>(
      () => _dio.patch<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: _mergeOptions(options, config),
        cancelToken: cancelToken,
      ),
      config: config,
    );
  }

  // ── MULTIPART ────────────────────────────────────────────────────────────

  /// Uploads a single file with optional additional form fields.
  Future<ApiResponse<T>> upload<T>(
    String path, {
    required String filePath,
    String fieldName = 'file',
    Map<String, dynamic>? fields,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    ApiRequestConfig config = ApiRequestConfig.defaults,
    ProgressCallback? onSendProgress,
  }) async {
    final formData = FormData.fromMap({
      if (fields != null) ...fields,
      fieldName: await MultipartFile.fromFile(filePath),
    });

    return post<T>(
      path,
      data: formData,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      config: config,
      options: Options(contentType: ApiConstants.multipartContentType),
      onSendProgress: onSendProgress,
    );
  }

  /// Uploads multiple files with optional form fields.
  Future<ApiResponse<T>> uploadMultiple<T>(
    String path, {
    required Map<String, String> files,
    Map<String, dynamic>? fields,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    ApiRequestConfig config = ApiRequestConfig.defaults,
    ProgressCallback? onSendProgress,
  }) async {
    final entries = <String, dynamic>{if (fields != null) ...fields};

    for (final entry in files.entries) {
      entries[entry.key] = await MultipartFile.fromFile(entry.value);
    }

    final formData = FormData.fromMap(entries);

    return post<T>(
      path,
      data: formData,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      config: config,
      options: Options(contentType: ApiConstants.multipartContentType),
      onSendProgress: onSendProgress,
    );
  }

  /// Uploads raw bytes as a multipart file.
  Future<ApiResponse<T>> uploadBytes<T>(
    String path, {
    required List<int> bytes,
    required String fileName,
    String fieldName = 'file',
    Map<String, dynamic>? fields,
    CancelToken? cancelToken,
    ApiRequestConfig config = ApiRequestConfig.defaults,
  }) async {
    final formData = FormData.fromMap({
      if (fields != null) ...fields,
      fieldName: MultipartFile.fromBytes(bytes, filename: fileName),
    });

    return post<T>(
      path,
      data: formData,
      cancelToken: cancelToken,
      config: config,
      options: Options(contentType: ApiConstants.multipartContentType),
    );
  }

  // ── Internal ─────────────────────────────────────────────────────────────

  Future<ApiResponse<T>> _execute<T>(
    Future<Response<T>> Function() request, {
    required ApiRequestConfig config,
  }) async {
    if (!config.skipConnectivityCheck && !await _networkInfo.isConnected) {
      throw const NetworkException();
    }

    try {
      final response = await request();

      if (!_isSuccessStatus(response.statusCode)) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          message: ApiResponse<T>.fromDio(response).message,
        );
      }

      return ApiResponse<T>.fromDio(response);
    } on DioException catch (error) {
      throw ApiErrorHandler.fromDioException(error);
    } on AppException {
      rethrow;
    } catch (error) {
      throw ApiErrorHandler.fromUnknown(error);
    }
  }

  Options _mergeOptions(Options? options, ApiRequestConfig config) {
    final base = options ?? Options();

    return base.copyWith(
      connectTimeout: config.connectTimeout ?? base.connectTimeout,
      receiveTimeout: config.receiveTimeout ?? base.receiveTimeout,
      sendTimeout: config.sendTimeout ?? base.sendTimeout,
      extra: {
        ...?base.extra,
        ApiConstants.requestConfigKey: config,
      },
    );
  }

  bool _isSuccessStatus(int? statusCode) {
    return statusCode != null && statusCode >= 200 && statusCode < 300;
  }
}
