// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) =>
    _ProfileModel(
      id: (json['id'] as num).toInt(),
      email: json['email'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      avatar: json['avatar'] as String,
    );

Map<String, dynamic> _$ProfileModelToJson(_ProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'avatar': instance.avatar,
    };

_ProfileResponseModel _$ProfileResponseModelFromJson(
  Map<String, dynamic> json,
) => _ProfileResponseModel(
  data: ProfileModel.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ProfileResponseModelToJson(
  _ProfileResponseModel instance,
) => <String, dynamic>{'data': instance.data.toJson()};
