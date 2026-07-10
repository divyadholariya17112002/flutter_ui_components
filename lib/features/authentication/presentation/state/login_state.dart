import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_ui_components/features/authentication/domain/entities/user_entity.dart';

part 'login_state.freezed.dart';

enum LoginStatus { idle, loading, success, error }

@freezed
abstract class LoginState with _$LoginState {
  const factory LoginState({
    @Default('') String email,
    @Default('') String password,
    @Default(false) bool rememberMe,
    @Default(true) bool obscurePassword,
    String? emailError,
    String? passwordError,
    String? generalError,
    @Default(LoginStatus.idle) LoginStatus status,
    UserEntity? user,
  }) = _LoginState;

  const LoginState._();

  bool get isLoading => status == LoginStatus.loading;

  bool get isSuccess => status == LoginStatus.success;

  bool get canSubmit => !isLoading && !isSuccess;
}
