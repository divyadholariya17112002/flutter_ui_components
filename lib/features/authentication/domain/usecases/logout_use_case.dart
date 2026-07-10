import 'package:flutter_ui_components/core/utils/result.dart';
import 'package:flutter_ui_components/core/utils/use_case.dart';
import 'package:flutter_ui_components/features/authentication/domain/repositories/auth_repository.dart';

/// Clears the active session.
class LogoutUseCase implements UseCase<void, NoParams> {
  LogoutUseCase({required AuthRepository repository})
      : _repository = repository;

  final AuthRepository _repository;

  @override
  Future<Result<void>> call(NoParams params) => _repository.logout();
}
