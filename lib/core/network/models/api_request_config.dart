/// Per-request configuration passed through [Options.extra].
class ApiRequestConfig {
  const ApiRequestConfig({
    this.connectTimeout,
    this.receiveTimeout,
    this.sendTimeout,
    this.enableRetry = true,
    this.maxRetries,
    this.skipAuth = false,
    this.skipConnectivityCheck = false,
  });

  final Duration? connectTimeout;
  final Duration? receiveTimeout;
  final Duration? sendTimeout;
  final bool enableRetry;
  final int? maxRetries;
  final bool skipAuth;
  final bool skipConnectivityCheck;

  static const ApiRequestConfig defaults = ApiRequestConfig();

  ApiRequestConfig copyWith({
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    bool? enableRetry,
    int? maxRetries,
    bool? skipAuth,
    bool? skipConnectivityCheck,
  }) {
    return ApiRequestConfig(
      connectTimeout: connectTimeout ?? this.connectTimeout,
      receiveTimeout: receiveTimeout ?? this.receiveTimeout,
      sendTimeout: sendTimeout ?? this.sendTimeout,
      enableRetry: enableRetry ?? this.enableRetry,
      maxRetries: maxRetries ?? this.maxRetries,
      skipAuth: skipAuth ?? this.skipAuth,
      skipConnectivityCheck:
          skipConnectivityCheck ?? this.skipConnectivityCheck,
    );
  }
}
