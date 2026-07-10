import 'package:flutter_ui_components/core/utils/entity.dart';

/// Authenticated user — pure domain object with no serialization logic.
final class UserEntity extends Entity {
  const UserEntity({
    required this.id,
    required this.email,
    required this.fullName,
    required this.accessToken,
    this.avatarUrl,
  });

  final String id;
  final String email;
  final String fullName;
  final String accessToken;
  final String? avatarUrl;

  @override
  List<Object?> get props => [id, email, fullName, accessToken, avatarUrl];
}
