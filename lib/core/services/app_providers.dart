import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_ui_components/core/config/app_config.dart';
import 'package:flutter_ui_components/core/network/api_client.dart';
import 'package:flutter_ui_components/core/network/dio_client.dart';
import 'package:flutter_ui_components/core/network/network_info.dart';
import 'package:flutter_ui_components/core/provider/base_provider.dart';
import 'package:flutter_ui_components/core/services/app_router.dart';
import 'package:flutter_ui_components/core/services/local_storage.dart';
import 'package:flutter_ui_components/features/authentication/data/datasources/auth_local_data_source.dart';
import 'package:flutter_ui_components/features/authentication/data/datasources/auth_local_data_source_impl.dart';
import 'package:flutter_ui_components/features/authentication/data/datasources/fake_auth_remote_data_source.dart';
import 'package:flutter_ui_components/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:flutter_ui_components/features/authentication/di/auth_providers.dart';
import 'package:flutter_ui_components/features/authentication/domain/repositories/auth_repository.dart';
import 'package:flutter_ui_components/features/authentication/domain/usecases/logout_use_case.dart';
import 'package:flutter_ui_components/features/home/di/home_providers.dart';
import 'package:flutter_ui_components/features/profile/di/profile_providers.dart';
import 'package:flutter_ui_components/core/services/settings_providers.dart';
import 'package:flutter_ui_components/features/splash/di/splash_providers.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/single_child_widget.dart';

abstract final class AppProviders {
  static List<SingleChildWidget> providers(LocalStorage localStorage) {
    final config = AppConfig.development;
    final connectivity = Connectivity();
    final networkInfo = NetworkInfoImpl(connectivity);
    final dio = DioClient(
      config: config,
      localStorage: localStorage,
    ).create();
    final apiClient = ApiClient(dio: dio, networkInfo: networkInfo);
    final router = AppRouter.create();

    final authLocalDataSource =
        AuthLocalDataSourceImpl(localStorage: localStorage);
    final authRepository = AuthRepositoryImpl(
      remoteDataSource: FakeAuthRemoteDataSource(),
      localDataSource: authLocalDataSource,
    );

    return [
      BaseProvider.value<AppConfig>(config),
      BaseProvider.value<LocalStorage>(localStorage),
      BaseProvider.value<Connectivity>(connectivity),
      BaseProvider.value<NetworkInfo>(networkInfo),
      BaseProvider.value<Dio>(dio),
      BaseProvider.value<ApiClient>(apiClient),
      BaseProvider.value<GoRouter>(router),
      BaseProvider.value<AuthRepository>(authRepository),
      BaseProvider.value<AuthLocalDataSource>(authLocalDataSource),
      ...SettingsProviders.providers(localStorage: localStorage),
      ...SplashProviders.providers(
        authRepository: authRepository,
        router: router,
      ),
      ...AuthProviders.presentationProviders(
        repository: authRepository,
        router: router,
      ),
      ...HomeProviders.providers(
        config: config,
        apiClient: apiClient,
        localStorage: localStorage,
        networkInfo: networkInfo,
      ),
      ...ProfileProviders.providers(
        config: config,
        apiClient: apiClient,
        localStorage: localStorage,
        networkInfo: networkInfo,
        authLocalDataSource: authLocalDataSource,
        logoutUseCase: LogoutUseCase(repository: authRepository),
        router: router,
      ),
    ];
  }
}
