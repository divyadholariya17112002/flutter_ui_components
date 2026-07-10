import 'package:flutter_ui_components/core/provider/base_view_model.dart';
import 'package:flutter_ui_components/core/services/route_paths.dart';
import 'package:flutter_ui_components/core/utils/result.dart';
import 'package:flutter_ui_components/core/utils/use_case.dart';
import 'package:flutter_ui_components/features/authentication/domain/usecases/logout_use_case.dart';
import 'package:flutter_ui_components/features/profile/domain/entities/profile_entity.dart';
import 'package:flutter_ui_components/features/profile/domain/usecases/get_profile_use_case.dart';
import 'package:go_router/go_router.dart';

class ProfileViewModel extends BaseViewModel<ProfileEntity> {
  ProfileViewModel({
    required GetProfileUseCase getProfileUseCase,
    required LogoutUseCase logoutUseCase,
    required GoRouter router,
  })  : _getProfileUseCase = getProfileUseCase,
        _logoutUseCase = logoutUseCase,
        _router = router;

  final GetProfileUseCase _getProfileUseCase;
  final LogoutUseCase _logoutUseCase;
  final GoRouter _router;

  Future<void> loadProfile({bool forceRefresh = false}) => execute(
        () => _getProfileUseCase(const NoParams()),
      );

  Future<void> logout() async {
    setLoading();

    final logoutResult = await _logoutUseCase(const NoParams());

    switch (logoutResult) {
      case Success():
        _router.go(RoutePaths.login);
      case Error(:final failure):
        setError(failure.message);
    }
  }
}
