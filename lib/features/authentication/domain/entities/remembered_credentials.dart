import 'package:flutter_ui_components/core/utils/entity.dart';

/// Locally stored "Remember Me" credentials (email only — never store passwords).
final class RememberedCredentials extends Entity {
  const RememberedCredentials({
    required this.rememberMe,
    required this.email,
  });

  final bool rememberMe;
  final String email;

  @override
  List<Object?> get props => [rememberMe, email];
}
