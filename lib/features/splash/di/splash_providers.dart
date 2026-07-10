import 'package:flutter/material.dart';
import 'package:flutter_ui_components/core/provider/base_provider.dart';
import 'package:flutter_ui_components/features/authentication/domain/repositories/auth_repository.dart';
import 'package:flutter_ui_components/features/authentication/domain/usecases/check_auth_session_use_case.dart';
import 'package:flutter_ui_components/features/splash/presentation/viewmodels/splash_view_model.dart';
import 'package:flutter_ui_components/features/splash/presentation/views/splash_page.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

abstract final class SplashProviders {
  static List<SingleChildWidget> providers({
    required AuthRepository authRepository,
    required GoRouter router,
  }) {
    return [
      BaseProvider.singleton<CheckAuthSessionUseCase>(
        (_) => CheckAuthSessionUseCase(repository: authRepository),
      ),
      BaseProvider.viewModel<SplashViewModel>(
        (context) => SplashViewModel(
          checkAuthSessionUseCase: context.read<CheckAuthSessionUseCase>(),
          router: router,
        ),
      ),
    ];
  }

  static Widget page() => const SplashPage();
}
