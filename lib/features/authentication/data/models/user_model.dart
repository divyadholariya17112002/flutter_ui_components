import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_ui_components/features/authentication/domain/entities/user_entity.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// Data-layer user model — handles JSON serialization only.
@freezed
abstract class UserModel with _$UserModel {
  const UserModel._();

  const factory UserModel({
    required int id,
    required String email,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
    required String avatar,
    required String token,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  /// Maps this model to a domain [UserEntity].
  UserEntity toEntity() {
    return UserEntity(
      id: id.toString(),
      email: email,
      fullName: '$firstName $lastName'.trim(),
      accessToken: token,
      avatarUrl: avatar,
    );
  }
}

/// ReqRes wraps single-user responses in a `data` envelope.
@freezed
abstract class UserResponseModel with _$UserResponseModel {
  const factory UserResponseModel({
    required UserModel data,
  }) = _UserResponseModel;

  factory UserResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UserResponseModelFromJson(json);
}
