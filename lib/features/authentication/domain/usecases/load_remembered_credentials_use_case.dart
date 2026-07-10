import 'package:flutter_ui_components/core/utils/result.dart';
import 'package:flutter_ui_components/core/utils/use_case.dart';
import 'package:flutter_ui_components/features/authentication/domain/entities/remembered_credentials.dart';
import 'package:flutter_ui_components/features/authentication/domain/repositories/auth_repository.dart';

class LoadRememberedCredentialsUseCase
    implements UseCase<RememberedCredentials, NoParams> {
  LoadRememberedCredentialsUseCase({required AuthRepository repository})
      : _repository = repository;

  final AuthRepository _repository;

  @override
  Future<Result<RememberedCredentials>> call(NoParams params) =>
      _repository.getRememberedCredentials();
}
