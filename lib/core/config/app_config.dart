/// Application-wide configuration values.
class AppConfig {
  const AppConfig({
    required this.appName,
    required this.baseUrl,
    required this.connectTimeout,
    required this.receiveTimeout,
    required this.sendTimeout,
    required this.enableNetworkLogging,
    required this.maxRetryAttempts,
    required this.retryDelay,
    this.apiKey,
    this.useFakeRemoteDataSources = true,
  });

  final String appName;
  final String baseUrl;
  final String? apiKey;
  final bool useFakeRemoteDataSources;
  final Duration connectTimeout;
  final Duration receiveTimeout;
  final Duration sendTimeout;
  final bool enableNetworkLogging;
  final int maxRetryAttempts;
  final Duration retryDelay;

  static const AppConfig development = AppConfig(
    appName: 'Flutter Clean Architecture',
    baseUrl: 'https://reqres.in/api',
    connectTimeout: Duration(seconds: 30),
    receiveTimeout: Duration(seconds: 30),
    sendTimeout: Duration(seconds: 30),
    enableNetworkLogging: true,
    maxRetryAttempts: 3,
    retryDelay: Duration(milliseconds: 500),
  );
}
