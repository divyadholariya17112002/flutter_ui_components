import 'package:flutter_ui_components/core/utils/result.dart';
import 'package:flutter_ui_components/core/utils/use_case.dart';
import 'package:flutter_ui_components/features/authentication/domain/entities/user_entity.dart';
import 'package:flutter_ui_components/features/authentication/domain/repositories/auth_repository.dart';

/// Returns the locally cached user, if any.
class GetCachedUserUseCase implements UseCase<UserEntity?, NoParams> {
  GetCachedUserUseCase({required AuthRepository repository})
      : _repository = repository;

  final AuthRepository _repository;

  @override
  Future<Result<UserEntity?>> call(NoParams params) =>
      _repository.getCachedUser();
}
