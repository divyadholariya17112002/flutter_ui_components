import 'package:flutter_ui_components/core/utils/result.dart';
import 'package:flutter_ui_components/core/utils/use_case.dart';
import 'package:flutter_ui_components/features/authentication/domain/repositories/auth_repository.dart';

/// Determines whether a valid session exists in local storage.
class CheckAuthSessionUseCase implements UseCase<bool, NoParams> {
  CheckAuthSessionUseCase({required AuthRepository repository})
      : _repository = repository;

  final AuthRepository _repository;

  @override
  Future<Result<bool>> call(NoParams params) => _repository.isAuthenticated();
}
