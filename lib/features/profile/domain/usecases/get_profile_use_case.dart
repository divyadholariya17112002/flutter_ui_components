import 'package:flutter_ui_components/core/utils/result.dart';
import 'package:flutter_ui_components/core/utils/use_case.dart';
import 'package:flutter_ui_components/features/profile/domain/entities/profile_entity.dart';
import 'package:flutter_ui_components/features/profile/domain/repositories/profile_repository.dart';

class GetProfileUseCase implements UseCase<ProfileEntity, NoParams> {
  GetProfileUseCase({required ProfileRepository repository})
      : _repository = repository;

  final ProfileRepository _repository;

  @override
  Future<Result<ProfileEntity>> call(NoParams params) =>
      _repository.getProfile();
}
