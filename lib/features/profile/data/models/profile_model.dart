import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_ui_components/features/profile/domain/entities/profile_entity.dart';

part 'profile_model.freezed.dart';
part 'profile_model.g.dart';

@freezed
abstract class ProfileModel with _$ProfileModel {
  const ProfileModel._();

  const factory ProfileModel({
    required int id,
    required String email,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
    required String avatar,
  }) = _ProfileModel;

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  ProfileEntity toEntity() {
    return ProfileEntity(
      id: id.toString(),
      email: email,
      fullName: '$firstName $lastName'.trim(),
      avatarUrl: avatar,
    );
  }
}

@freezed
abstract class ProfileResponseModel with _$ProfileResponseModel {
  const factory ProfileResponseModel({
    required ProfileModel data,
  }) = _ProfileResponseModel;

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseModelFromJson(json);
}
