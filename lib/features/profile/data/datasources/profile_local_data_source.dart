import 'package:flutter_ui_components/features/profile/data/models/profile_model.dart';

abstract interface class ProfileLocalDataSource {
  Future<void> cacheProfile(ProfileModel profile);

  Future<ProfileModel?> getCachedProfile();
}
