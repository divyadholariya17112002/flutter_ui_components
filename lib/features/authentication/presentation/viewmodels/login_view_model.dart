import 'package:flutter/material.dart';
import 'package:flutter_ui_components/core/provider/view_model.dart';
import 'package:flutter_ui_components/core/services/route_paths.dart';
import 'package:flutter_ui_components/core/utils/result.dart';
import 'package:flutter_ui_components/core/utils/use_case.dart';
import 'package:flutter_ui_components/features/authentication/domain/usecases/load_remembered_credentials_use_case.dart';
import 'package:flutter_ui_components/features/authentication/domain/usecases/login_use_case.dart';
import 'package:flutter_ui_components/features/authentication/domain/validators/login_validator.dart';
import 'package:flutter_ui_components/features/authentication/presentation/state/login_state.dart';
import 'package:go_router/go_router.dart';

class LoginViewModel extends ViewModel {
  LoginViewModel({
    required LoginUseCase loginUseCase,
    required LoadRememberedCredentialsUseCase loadRememberedCredentialsUseCase,
    required GoRouter router,
  })  : _loginUseCase = loginUseCase,
        _loadRememberedCredentialsUseCase = loadRememberedCredentialsUseCase,
        _router = router;

  final LoginUseCase _loginUseCase;
  final LoadRememberedCredentialsUseCase _loadRememberedCredentialsUseCase;
  final GoRouter _router;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginState _state = const LoginState();
  LoginState get state => _state;

  Future<void> initialize() async {
    final result = await _loadRememberedCredentialsUseCase(const NoParams());

    if (result case Success(:final data) when data.rememberMe) {
      emailController.text = data.email;
      _state = _state.copyWith(
        email: data.email,
        rememberMe: true,
      );
      notifyListeners();
    }
  }

  void onEmailChanged(String value) {
    _state = _state.copyWith(
      email: value,
      emailError: null,
      generalError: null,
      status: LoginStatus.idle,
    );
    notifyListeners();
  }

  void onPasswordChanged(String value) {
    _state = _state.copyWith(
      password: value,
      passwordError: null,
      generalError: null,
      status: LoginStatus.idle,
    );
    notifyListeners();
  }

  void onRememberMeChanged(bool value) {
    _state = _state.copyWith(rememberMe: value);
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _state = _state.copyWith(obscurePassword: !_state.obscurePassword);
    notifyListeners();
  }

  Future<void> submit() async {
    if (!_state.canSubmit) return;

    final email = emailController.text;
    final password = passwordController.text;

    final emailError = LoginValidator.validateEmail(email);
    final passwordError = LoginValidator.validatePassword(password);

    if (emailError != null || passwordError != null) {
      _state = _state.copyWith(
        email: email,
        password: password,
        emailError: emailError,
        passwordError: passwordError,
        status: LoginStatus.error,
      );
      notifyListeners();
      return;
    }

    _state = _state.copyWith(
      email: email,
      password: password,
      status: LoginStatus.loading,
      generalError: null,
      emailError: null,
      passwordError: null,
    );
    notifyListeners();

    final result = await _loginUseCase(
      LoginParams(
        email: email,
        password: password,
        rememberMe: _state.rememberMe,
      ),
    );

    switch (result) {
      case Success(:final data):
        _state = _state.copyWith(
          status: LoginStatus.success,
          user: data,
        );
        notifyListeners();
        await Future<void>.delayed(const Duration(milliseconds: 900));
        _router.go(RoutePaths.home);
      case Error(:final failure):
        _state = _state.copyWith(
          status: LoginStatus.error,
          generalError: failure.message,
        );
        notifyListeners();
    }
  }

  @override
  void onDispose() {
    emailController.dispose();
    passwordController.dispose();
  }
}
