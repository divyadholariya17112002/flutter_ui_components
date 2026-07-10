import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_ui_components/features/home/domain/entities/home_item_entity.dart';

part 'home_item_model.freezed.dart';
part 'home_item_model.g.dart';

@freezed
abstract class HomeItemModel with _$HomeItemModel {
  const HomeItemModel._();

  const factory HomeItemModel({
    required int id,
    required String email,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
    required String avatar,
  }) = _HomeItemModel;

  factory HomeItemModel.fromJson(Map<String, dynamic> json) =>
      _$HomeItemModelFromJson(json);

  HomeItemEntity toEntity() {
    return HomeItemEntity(
      id: id.toString(),
      title: '$firstName $lastName'.trim(),
      subtitle: email,
      imageUrl: avatar,
      description:
          '$firstName $lastName is a member of the team. Reach out at $email for collaboration.',
    );
  }
}

@freezed
abstract class HomeUsersResponseModel with _$HomeUsersResponseModel {
  const factory HomeUsersResponseModel({
    required List<HomeItemModel> data,
  }) = _HomeUsersResponseModel;

  factory HomeUsersResponseModel.fromJson(Map<String, dynamic> json) =>
      _$HomeUsersResponseModelFromJson(json);
}
