import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:tryhard_showcase/data/api/auth/models/auth_exception.dart';
import 'package:tryhard_showcase/data/api/datasource/models/exception.dart';
import 'package:tryhard_showcase/ui/login/models/login_form.dart';
import 'package:tryhard_showcase/ui/login/models/user_input.dart';

import 'login_screen_controller.dart';

abstract class LoginFormController {
  ValueListenable<LoginFormViewModel> get viewModel;

  Future<void> onLogin();

  Future<void> onRegister();

  Future<void> onGoogleSignIn();

  void onEmailChanged(String value);

  void onPasswordChanged(String value);

  void onFormTypeChanged(LoginFormType type);

  void onNameChanged(String value);

  void onIsTrainerChanged();

  void onHidePasswordChanged();

  void dispose();
}

class RealLoginFormController implements LoginFormController {
  RealLoginFormController({
    required UserLoginController userLoginController,
  }) {
    _userLoginController = userLoginController;
    _userInput.addListener(_validateInputAndShowError);
  }

  late final UserLoginController _userLoginController;

  final ValueNotifier<UserInput> _userInput = ValueNotifier(
    const UserInput(
      isTrainer: false,
    ),
  );

  final ValueNotifier<LoginFormViewModel> _viewModel = ValueNotifier(
    const LoginFormViewModel.initial(),
  );

  @override
  ValueListenable<LoginFormViewModel> get viewModel => _viewModel;

  void _validateInputAndShowError() {
    final bool buttonState =
        !(EmailValidator.validate(_userInput.value.email ?? '')) ||
            (_userInput.value.password?.isEmpty ?? true);
    _viewModel.value = _viewModel.value.copyWith(
      loginButtonState:
          buttonState ? LoginButtonState.disabled : LoginButtonState.enabled,
    );
  }

  @override
  Future<void> onLogin() async {
    if (_checkRequiredInputsEmpty()) {
      _setViewModelError(
        errorMessage: 'Email and password fields must be filled',
        buttonState: LoginButtonState.disabled,
      );
      return;
    }
    try {
      _setViewModelLoading();
      await _userLoginController.logIn(
        email: _userInput.value.email!,
        password: _userInput.value.password!,
      );
    } on AuthException catch (e) {
      _setViewModelError(
        errorMessage: e.message,
        buttonState: LoginButtonState.enabled,
      );
    }
  }

  @override
  Future<void> onRegister() async {
    if (_checkRequiredInputsEmpty()) {
      _setViewModelError(
        errorMessage: 'Email and password fields must be filled',
        buttonState: LoginButtonState.disabled,
      );
      return;
    }
    try {
      _setViewModelLoading();
      await _userLoginController.register(
        email: _userInput.value.email!,
        password: _userInput.value.password!,
        name: _userInput.value.name,
        isTrainer: _userInput.value.isTrainer,
      );
    } on AuthException catch (e) {
      _setViewModelError(
        errorMessage: e.message,
        buttonState: LoginButtonState.enabled,
      );
    } on ApiException catch (e) {
      _setViewModelError(
        errorMessage: e.description,
        buttonState: LoginButtonState.enabled,
      );
    }
  }

  @override
  Future<void> onGoogleSignIn() async {
    try {
      _setViewModelLoading();
      await _userLoginController.onGoogleSignIn();
    } on AuthException catch (e) {
      _setViewModelError(
        errorMessage: e.message,
        buttonState: _checkRequiredInputsEmpty()
            ? LoginButtonState.disabled
            : LoginButtonState.enabled,
      );
    }
  }

  @override
  void onEmailChanged(String value) {
    _userInput.value = _userInput.value.copyWith(
      email: value,
    );
  }

  @override
  void onPasswordChanged(String value) {
    _userInput.value = _userInput.value.copyWith(
      password: value,
    );
  }

  @override
  void onFormTypeChanged(LoginFormType type) {
    _viewModel.value = _viewModel.value.copyWith(
      selectedFormType: type,
    );
  }

  @override
  void onHidePasswordChanged() {
    _viewModel.value = _viewModel.value.copyWith(
      isPasswordHidden: !_viewModel.value.isPasswordHidden,
    );
  }

  @override
  void onIsTrainerChanged() {
    _viewModel.value = _viewModel.value.copyWith(
      isTrainer: !_viewModel.value.isTrainer,
    );
    _userInput.value = _userInput.value.copyWith(
      isTrainer: !_userInput.value.isTrainer,
    );
  }

  @override
  void onNameChanged(String value) {
    _userInput.value = _userInput.value.copyWith(
      name: value,
    );
  }

  void _setViewModelLoading() {
    if (_viewModel.value.loginButtonState != LoginButtonState.loading) {
      _viewModel.value = LoginFormViewModel.loading(
        selectedFormType: _viewModel.value.selectedFormType,
        isTrainer: _viewModel.value.isTrainer,
        isPasswordHidden: _viewModel.value.isPasswordHidden,
      );
    }
  }

  void _setViewModelError({
    required String errorMessage,
    required LoginButtonState buttonState,
  }) {
    _viewModel.value = LoginFormViewModel.error(
      errorMessage: errorMessage,
      loginButtonState: buttonState,
      selectedFormType: _viewModel.value.selectedFormType,
      isPasswordHidden: _viewModel.value.isPasswordHidden,
      isTrainer: _viewModel.value.isTrainer,
    );
  }

  bool _checkRequiredInputsEmpty() {
    return (_userInput.value.email?.isEmpty ?? true) ||
        (_userInput.value.password?.isEmpty ?? true);
  }

  void _resetViewModel() {
    _viewModel.value = const LoginFormViewModel.initial();
  }

  @override
  void dispose() {
    _userInput.removeListener(_validateInputAndShowError);
    _resetViewModel();
  }
}
