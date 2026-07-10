import 'package:flutter_ui_components/core/utils/failures.dart';
import 'package:flutter_ui_components/core/utils/result.dart';
import 'package:flutter_ui_components/core/utils/use_case.dart';
import 'package:flutter_ui_components/features/authentication/domain/entities/user_entity.dart';
import 'package:flutter_ui_components/features/authentication/domain/repositories/auth_repository.dart';
import 'package:flutter_ui_components/features/authentication/domain/validators/login_validator.dart';

class LoginParams {
  const LoginParams({
    required this.email,
    required this.password,
    required this.rememberMe,
  });

  final String email;
  final String password;
  final bool rememberMe;
}

class LoginUseCase implements UseCase<UserEntity, LoginParams> {
  LoginUseCase({required AuthRepository repository}) : _repository = repository;

  final AuthRepository _repository;

  @override
  Future<Result<UserEntity>> call(LoginParams params) {
    final emailError = LoginValidator.validateEmail(params.email);
    final passwordError = LoginValidator.validatePassword(params.password);

    if (emailError != null || passwordError != null) {
      return Future.value(
        Result.failure(
          ValidationFailure(
            message: emailError ?? passwordError ?? 'Invalid input',
          ),
        ),
      );
    }

    return _repository.login(
      email: params.email.trim(),
      password: params.password,
      rememberMe: params.rememberMe,
    );
  }
}
