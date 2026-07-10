import 'package:flutter_ui_components/features/authentication/data/models/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> login({
    required String email,
    required String password,
  });
}
