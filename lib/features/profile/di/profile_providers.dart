import 'package:flutter_ui_components/core/config/app_config.dart';
import 'package:flutter_ui_components/core/network/api_client.dart';
import 'package:flutter_ui_components/core/network/network_info.dart';
import 'package:flutter_ui_components/core/provider/base_provider.dart';
import 'package:flutter_ui_components/core/services/local_storage.dart';
import 'package:flutter_ui_components/features/authentication/data/datasources/auth_local_data_source.dart';
import 'package:flutter_ui_components/features/authentication/domain/usecases/logout_use_case.dart';
import 'package:flutter_ui_components/features/profile/data/datasources/fake_profile_remote_data_source.dart';
import 'package:flutter_ui_components/features/profile/data/datasources/profile_local_data_source.dart';
import 'package:flutter_ui_components/features/profile/data/datasources/profile_local_data_source_impl.dart';
import 'package:flutter_ui_components/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:flutter_ui_components/features/profile/data/datasources/profile_remote_data_source_impl.dart';
import 'package:flutter_ui_components/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:flutter_ui_components/features/profile/domain/repositories/profile_repository.dart';
import 'package:flutter_ui_components/features/profile/domain/usecases/get_profile_use_case.dart';
import 'package:flutter_ui_components/features/profile/presentation/viewmodels/profile_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

abstract final class ProfileProviders {
  static List<SingleChildWidget> providers({
    required AppConfig config,
    required ApiClient apiClient,
    required LocalStorage localStorage,
    required NetworkInfo networkInfo,
    required AuthLocalDataSource authLocalDataSource,
    required LogoutUseCase logoutUseCase,
    required GoRouter router,
  }) {
    final ProfileRemoteDataSource remoteDataSource =
        config.useFakeRemoteDataSources
            ? FakeProfileRemoteDataSource(
                localDataSource: authLocalDataSource,
              )
            : ProfileRemoteDataSourceImpl(apiClient: apiClient);
    final localDataSource =
        ProfileLocalDataSourceImpl(localStorage: localStorage);
    final repository = ProfileRepositoryImpl(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource,
      localStorage: localStorage,
      networkInfo: networkInfo,
    );

    return [
      BaseProvider.value<ProfileRemoteDataSource>(remoteDataSource),
      BaseProvider.value<ProfileLocalDataSource>(localDataSource),
      BaseProvider.value<ProfileRepository>(repository),
      BaseProvider.singleton<GetProfileUseCase>(
        (_) => GetProfileUseCase(repository: repository),
      ),
      BaseProvider.viewModel<ProfileViewModel>(
        (context) => ProfileViewModel(
          getProfileUseCase: context.read<GetProfileUseCase>(),
          logoutUseCase: logoutUseCase,
          router: router,
        ),
      ),
    ];
  }
}
