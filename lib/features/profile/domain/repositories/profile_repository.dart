import 'package:flutter_ui_components/core/utils/result.dart';
import 'package:flutter_ui_components/features/profile/domain/entities/profile_entity.dart';

abstract interface class ProfileRepository {
  Future<Result<ProfileEntity>> getProfile({bool forceRefresh = false});
}
