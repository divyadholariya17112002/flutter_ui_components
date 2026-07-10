// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HomeItemModel _$HomeItemModelFromJson(Map<String, dynamic> json) =>
    _HomeItemModel(
      id: (json['id'] as num).toInt(),
      email: json['email'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      avatar: json['avatar'] as String,
    );

Map<String, dynamic> _$HomeItemModelToJson(_HomeItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'avatar': instance.avatar,
    };

_HomeUsersResponseModel _$HomeUsersResponseModelFromJson(
  Map<String, dynamic> json,
) => _HomeUsersResponseModel(
  data: (json['data'] as List<dynamic>)
      .map((e) => HomeItemModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$HomeUsersResponseModelToJson(
  _HomeUsersResponseModel instance,
) => <String, dynamic>{'data': instance.data.map((e) => e.toJson()).toList()};
