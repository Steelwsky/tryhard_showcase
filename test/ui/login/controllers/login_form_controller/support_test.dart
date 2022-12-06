import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:given_when_then/given_when_then.dart';
import 'package:tryhard_showcase/data/api/auth/models/auth_exception.dart';
import 'package:tryhard_showcase/ui/login/controllers/login_form_controller.dart';
import 'package:tryhard_showcase/ui/login/controllers/login_screen_controller.dart';
import 'package:tryhard_showcase/ui/login/models/login_form.dart';
import 'package:tryhard_showcase/ui/login/models/user_input.dart';

Future<void> Function() harness(UnitTestHarnessCallback<LoginFormTestHarness> callback) {
  return () => givenWhenThenUnitTest(LoginFormTestHarness(), callback);
}

class LoginFormTestHarness {
  LoginFormTestHarness() : super();
  final loginController = _TestUserLoginController();
  late final controller = RealLoginFormController(userLoginController: loginController);
}

extension ExampleGiven on UnitTestGiven<LoginFormTestHarness> {
  void userInputsAre({required UserInput userInput}) {
    this.harness.controller.onEmailChanged(userInput.email!);
    this.harness.controller.onPasswordChanged(userInput.password!);
  }
}

extension ExampleWhen on UnitTestWhen<LoginFormTestHarness> {
  void selectFormType(LoginFormType type) {
    this.harness.controller.onFormTypeChanged(type);
  }

  void changePasswordVisibility() {
    this.harness.controller.onHidePasswordChanged();
  }

  void changeIsTrainerOption() {
    this.harness.controller.onIsTrainerChanged();
  }

  Future<void> callToLoginApi() {
    return this.harness.controller.onLogin();
  }

  void loginApiCompletesSuccessfully({
    required UserInput userInput,
  }) {
    this.harness.loginController.authLoginCompleters[userInput]?.single.complete();
  }

  void loginApiCompletesWithException({
    required UserInput userInput,
    required Exception exception,
  }) {
    this.harness.loginController.authLoginCompleters[userInput]?.single.completeError(exception);
  }

  Future<void> callToRegisterApi() {
    return this.harness.controller.onRegister();
  }

  void registerApiCompletesSuccessfully({
    required UserInput userInput,
  }) {
    this.harness.loginController.authRegisterCompleters[userInput]?.single.complete();
  }

  void registerApiCompletesWithException({
    required UserInput userInput,
    required Exception exception,
  }) {
    this.harness.loginController.authRegisterCompleters[userInput]?.single.completeError(exception);
  }

  Future<void> callToGoogleSignInApi() {
    return this.harness.controller.onGoogleSignIn();
  }

  void googleSignInApiCompletesSuccessfully() {
    this.harness.loginController.googleSignInCompleter.complete();
  }

  void googleSignInCompletesWithException({
    required Exception exception,
  }) {
    this.harness.loginController.googleSignInCompleter.completeError(exception);
  }
}

extension ExampleThen on UnitTestThen<LoginFormTestHarness> {
  void returnEmptyInputsException() {
    expect(
      this.harness.controller.viewModel.value,
      equals(
        LoginFormViewModel.error(
          errorMessage: 'Email and password fields must be filled',
          loginButtonState: LoginButtonState.disabled,
          selectedFormType: this.harness.controller.viewModel.value.selectedFormType,
          isPasswordHidden: this.harness.controller.viewModel.value.isPasswordHidden,
          isTrainer: this.harness.controller.viewModel.value.isTrainer,
        ),
      ),
    );
  }

  void viewModelIs(LoginFormViewModel viewModel) async {
    await Future.microtask(() {});
    expect(
      this.harness.controller.viewModel.value,
      equals(viewModel),
    );
  }

  void viewModelIsLoading() async {
    await Future.microtask(() {});
    expect(
      this.harness.controller.viewModel.value,
      equals(
        LoginFormViewModel.loading(
          selectedFormType: this.harness.controller.viewModel.value.selectedFormType,
          isTrainer: this.harness.controller.viewModel.value.isTrainer,
          isPasswordHidden: this.harness.controller.viewModel.value.isPasswordHidden,
        ),
      ),
    );
  }

  void viewModelErrorMessageIs(String error) async {
    await Future.microtask(() {});
    expect(
      this.harness.controller.viewModel.value,
      equals(
        LoginFormViewModel.error(
          errorMessage: error,
          loginButtonState: this.harness.controller.viewModel.value.loginButtonState,
          selectedFormType: this.harness.controller.viewModel.value.selectedFormType,
          isPasswordHidden: this.harness.controller.viewModel.value.isPasswordHidden,
          isTrainer: this.harness.controller.viewModel.value.isTrainer,
        ),
      ),
    );
  }

  void viewModelButtonEnabled() async {
    await Future.microtask(() {});
    expect(
      this.harness.controller.viewModel.value,
      equals(
        LoginFormViewModel.data(
          loginButtonState: LoginButtonState.enabled,
          selectedFormType: this.harness.controller.viewModel.value.selectedFormType,
          isTrainer: this.harness.controller.viewModel.value.isTrainer,
          isPasswordHidden: this.harness.controller.viewModel.value.isPasswordHidden,
          errorMessage: this.harness.controller.viewModel.value.errorMessage,
        ),
      ),
    );
  }

  void viewModelButtonDisabled() async {
    await Future.microtask(() {});
    expect(
      this.harness.controller.viewModel.value,
      equals(
        LoginFormViewModel.data(
          loginButtonState: LoginButtonState.disabled,
          selectedFormType: this.harness.controller.viewModel.value.selectedFormType,
          isTrainer: this.harness.controller.viewModel.value.isTrainer,
          isPasswordHidden: this.harness.controller.viewModel.value.isPasswordHidden,
          errorMessage: this.harness.controller.viewModel.value.errorMessage,
        ),
      ),
    );
  }
}

class _TestUserLoginController implements UserLoginController {
  Map<UserInput, List<Completer<AuthException?>>> authLoginCompleters = {};
  Map<UserInput, List<Completer<AuthException?>>> authRegisterCompleters = {};
  Completer<AuthException?> googleSignInCompleter = Completer();

  @override
  Future<void> logIn({required String email, required String password}) {
    final Completer<AuthException?> completer = Completer();
    authLoginCompleters[UserInput(
      email: email,
      password: password,
    )] = [
      ...?authLoginCompleters[UserInput(
        email: email,
        password: password,
      )],
      completer,
    ];
    return completer.future;
  }

  @override
  Future<void> onGoogleSignIn() {
    final Completer<AuthException?> completer = Completer();
    googleSignInCompleter = completer;
    return googleSignInCompleter.future;
  }

  @override
  Future<void> register({
    required String email,
    required String password,
    String? name,
    bool? isTrainer,
  }) {
    final Completer<AuthException?> completer = Completer();
    authRegisterCompleters[UserInput(
      email: email,
      password: password,
    )] = [
      ...?authRegisterCompleters[UserInput(
        email: email,
        password: password,
      )],
      completer,
    ];
    return completer.future;
  }
}
