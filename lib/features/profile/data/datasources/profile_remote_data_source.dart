import 'package:flutter_ui_components/features/profile/data/models/profile_model.dart';

abstract interface class ProfileRemoteDataSource {
  Future<ProfileModel> getProfile(String userId);
}
