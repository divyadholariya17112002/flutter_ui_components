import 'package:flutter_ui_components/core/config/app_config.dart';
import 'package:flutter_ui_components/core/network/api_client.dart';
import 'package:flutter_ui_components/core/network/network_info.dart';
import 'package:flutter_ui_components/core/provider/base_provider.dart';
import 'package:flutter_ui_components/core/services/local_storage.dart';
import 'package:flutter_ui_components/features/home/data/datasources/fake_home_remote_data_source.dart';
import 'package:flutter_ui_components/features/home/data/datasources/home_local_data_source.dart';
import 'package:flutter_ui_components/features/home/data/datasources/home_local_data_source_impl.dart';
import 'package:flutter_ui_components/features/home/data/datasources/home_remote_data_source.dart';
import 'package:flutter_ui_components/features/home/data/datasources/home_remote_data_source_impl.dart';
import 'package:flutter_ui_components/features/home/data/repositories/home_repository_impl.dart';
import 'package:flutter_ui_components/features/home/domain/repositories/home_repository.dart';
import 'package:flutter_ui_components/features/home/domain/usecases/load_home_use_case.dart';
import 'package:flutter_ui_components/features/home/presentation/viewmodels/home_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

abstract final class HomeProviders {
  static List<SingleChildWidget> providers({
    required AppConfig config,
    required ApiClient apiClient,
    required LocalStorage localStorage,
    required NetworkInfo networkInfo,
  }) {
    final HomeRemoteDataSource remoteDataSource = config.useFakeRemoteDataSources
        ? FakeHomeRemoteDataSource()
        : HomeRemoteDataSourceImpl(apiClient: apiClient);
    final localDataSource = HomeLocalDataSourceImpl(localStorage: localStorage);
    final repository = HomeRepositoryImpl(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource,
      networkInfo: networkInfo,
    );

    return [
      BaseProvider.value<HomeRemoteDataSource>(remoteDataSource),
      BaseProvider.value<HomeLocalDataSource>(localDataSource),
      BaseProvider.value<HomeRepository>(repository),
      BaseProvider.singleton<LoadHomeUseCase>(
        (_) => LoadHomeUseCase(repository: repository),
      ),
      BaseProvider.viewModel<HomeViewModel>(
        (context) => HomeViewModel(
          loadHomeUseCase: context.read<LoadHomeUseCase>(),
        ),
      ),
    ];
  }
}
