import 'package:flutter_ui_components/core/utils/entity.dart';

/// User profile — domain representation independent of API shape.
final class ProfileEntity extends Entity {
  const ProfileEntity({
    required this.id,
    required this.email,
    required this.fullName,
    this.avatarUrl,
  });

  final String id;
  final String email;
  final String fullName;
  final String? avatarUrl;

  @override
  List<Object?> get props => [id, email, fullName, avatarUrl];
}
