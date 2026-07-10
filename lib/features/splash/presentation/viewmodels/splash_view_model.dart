import 'package:flutter_ui_components/core/config/app_constants.dart';
import 'package:flutter_ui_components/core/provider/view_model.dart';
import 'package:flutter_ui_components/core/services/route_paths.dart';
import 'package:flutter_ui_components/core/utils/result.dart';
import 'package:flutter_ui_components/core/utils/use_case.dart';
import 'package:flutter_ui_components/features/authentication/domain/usecases/check_auth_session_use_case.dart';
import 'package:go_router/go_router.dart';

enum SplashStatus { animating, navigating }

/// Orchestrates splash timing, session check, and initial navigation.
class SplashViewModel extends ViewModel {
  SplashViewModel({
    required CheckAuthSessionUseCase checkAuthSessionUseCase,
    required GoRouter router,
    Duration minDisplayDuration = AppConstants.splashMinDuration,
  })  : _checkAuthSessionUseCase = checkAuthSessionUseCase,
        _router = router,
        _minDisplayDuration = minDisplayDuration;

  final CheckAuthSessionUseCase _checkAuthSessionUseCase;
  final GoRouter _router;
  final Duration _minDisplayDuration;

  SplashStatus _status = SplashStatus.animating;
  SplashStatus get status => _status;

  bool _hasStarted = false;

  Future<void> initialize() async {
    if (_hasStarted) return;
    _hasStarted = true;

    final results = await Future.wait<dynamic>([
      _checkAuthSessionUseCase(const NoParams()),
      Future<void>.delayed(_minDisplayDuration),
    ]);

    final authResult = results.first as Result<bool>;
    final isAuthenticated = switch (authResult) {
      Success(:final data) => data,
      Error() => false,
    };

    _status = SplashStatus.navigating;
    notifyListeners();

    if (isAuthenticated) {
      _router.go(RoutePaths.home);
    } else {
      _router.go(RoutePaths.login);
    }
  }
}
