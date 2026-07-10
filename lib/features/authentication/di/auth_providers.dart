import 'package:flutter_ui_components/core/provider/base_provider.dart';
import 'package:flutter_ui_components/core/services/local_storage.dart';
import 'package:flutter_ui_components/features/authentication/data/datasources/auth_local_data_source.dart';
import 'package:flutter_ui_components/features/authentication/data/datasources/auth_local_data_source_impl.dart';
import 'package:flutter_ui_components/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_ui_components/features/authentication/data/datasources/fake_auth_remote_data_source.dart';
import 'package:flutter_ui_components/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:flutter_ui_components/features/authentication/domain/repositories/auth_repository.dart';
import 'package:flutter_ui_components/features/authentication/domain/usecases/get_cached_user_use_case.dart';
import 'package:flutter_ui_components/features/authentication/domain/usecases/load_remembered_credentials_use_case.dart';
import 'package:flutter_ui_components/features/authentication/domain/usecases/login_use_case.dart';
import 'package:flutter_ui_components/features/authentication/domain/usecases/logout_use_case.dart';
import 'package:flutter_ui_components/features/authentication/presentation/viewmodels/forgot_password_view_model.dart';
import 'package:flutter_ui_components/features/authentication/presentation/viewmodels/login_view_model.dart';
import 'package:flutter_ui_components/features/authentication/presentation/viewmodels/register_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

abstract final class AuthProviders {
  static List<SingleChildWidget> providers({
    required LocalStorage localStorage,
    required GoRouter router,
  }) {
    final remoteDataSource = FakeAuthRemoteDataSource();
    final localDataSource = AuthLocalDataSourceImpl(localStorage: localStorage);
    final repository = AuthRepositoryImpl(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource,
    );

    return [
      BaseProvider.value<AuthRemoteDataSource>(remoteDataSource),
      BaseProvider.value<AuthLocalDataSource>(localDataSource),
      BaseProvider.value<AuthRepository>(repository),
      ...presentationProviders(repository: repository, router: router),
    ];
  }

  static List<SingleChildWidget> presentationProviders({
    required AuthRepository repository,
    required GoRouter router,
  }) {
    return [
      BaseProvider.singleton<LoginUseCase>(
        (_) => LoginUseCase(repository: repository),
      ),
      BaseProvider.singleton<LogoutUseCase>(
        (_) => LogoutUseCase(repository: repository),
      ),
      BaseProvider.singleton<GetCachedUserUseCase>(
        (_) => GetCachedUserUseCase(repository: repository),
      ),
      BaseProvider.singleton<LoadRememberedCredentialsUseCase>(
        (_) => LoadRememberedCredentialsUseCase(repository: repository),
      ),
      BaseProvider.viewModel<LoginViewModel>(
        (context) => LoginViewModel(
          loginUseCase: context.read<LoginUseCase>(),
          loadRememberedCredentialsUseCase:
              context.read<LoadRememberedCredentialsUseCase>(),
          router: router,
        ),
      ),
      BaseProvider.viewModel<RegisterViewModel>(
        (context) => RegisterViewModel(router: router),
      ),
      BaseProvider.viewModel<ForgotPasswordViewModel>(
        (context) => ForgotPasswordViewModel(router: router),
      ),
    ];
  }
}
