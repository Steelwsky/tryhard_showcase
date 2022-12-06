import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:given_when_then/given_when_then.dart';
import 'package:tryhard_showcase/data/api/auth/models/auth_user.dart';
import 'package:tryhard_showcase/ui/login/controllers/login_screen_controller.dart';
import 'package:tryhard_showcase/ui/login/models/user_input.dart';

import '../../../../data/repositories/fake_auth_repository.dart';
import '../../../../data/repositories/fake_user_repository.dart';


Future<void> Function() harness(
    UnitTestHarnessCallback<MyUserLoginControllerTestHarness> callback) {
  return () => givenWhenThenUnitTest(MyUserLoginControllerTestHarness(), callback);
}

class MyUserLoginControllerTestHarness {
  MyUserLoginControllerTestHarness() : super();
  final auth = FakeAuthRepository();
  final userRepository = FakeUserRepository();

  late final controller = RealUserLoginController(
    auth: auth,
    userRepository: userRepository,
  );
}

extension ExampleGiven on UnitTestGiven<MyUserLoginControllerTestHarness> {}

extension ExampleWhen on UnitTestWhen<MyUserLoginControllerTestHarness> {
  void userLoggedInStateIs(bool value) {
    this.harness.auth.fakeIsLogged.value = value;
  }

  void setAuthFakeUser(AuthUser? user) {
    this.harness.auth.setFakeUser(user);
  }

  ///login
  Future<void> userLoggingIn({required UserInput userInput}) {
    return this.harness.controller.logIn(
      email: userInput.email!,
      password: userInput.password!,
    );
  }

  void logInApiCompletesSuccessfully({
    required UserInput userInput,
  }) {
    this.harness.auth.authLoginCompleters[userInput]!.single.complete();
  }

  void logInApiCompletesWithException({
    required UserInput userInput,
    required Exception exception,
  }) {
    this.harness.auth.authLoginCompleters[userInput]!.single.completeError(exception);
  }

  ///register
  Future<void> userRegister({required UserInput userInput}) {
    return this.harness.controller.register(
      email: userInput.email!,
      password: userInput.password!,
    );
  }

  void registerAuthApiCompletesSuccessfully({
    required UserInput userInput,
  }) {
    this.harness.auth.authRegisterCompleters[userInput]!.single.complete();
  }

  void registerAuthApiCompletesWithAuthException({
    required UserInput userInput,
    required Exception exception,
  }) {
    this.harness.auth.authRegisterCompleters[userInput]!.single.completeError(exception);
  }

  void registerDbApiCompletesSuccessfully({
    required UserInput userInput,
  }) {
    final user = this.harness.userRepository.createUserCompleters.keys.single;
    this.harness.userRepository.createUserCompleters[user]!.single.complete();
  }

  void registerUserApiCompletesWithApiException({
    required UserInput userInput,
    required Exception exception,
  }) {
    final user = this.harness.userRepository.createUserCompleters.keys.single;
    this.harness.userRepository.createUserCompleters[user]!.single.completeError(exception);
  }

  ///google
  Future<void> googleSignIn() {
    return this.harness.controller.onGoogleSignIn();
  }

  void googleSignInAuthApiCompletesSuccessfully() {
    this.harness.auth.authGoogleCompleters.single.complete();
  }

  void googleSignInAuthApiCompletesWithAuthException({required Exception exception}) {
    this.harness.auth.authGoogleCompleters.single.completeError(exception);
  }
}

extension ExampleThen on UnitTestThen<MyUserLoginControllerTestHarness> {
  void logInExpects({required UserInput userInput, required Matcher matcher}) async {
    await Future.microtask(() {});
    expect(
      this.harness.auth.authLoginCompleters[userInput],
      matcher,
    );
  }

  void logInExpectsExceptionFor(dynamic result) async {
    expect(
      result,
      throwsException,
    );
  }

  //TODO DO NOT do like this
  void registerExpectsExceptionFor(dynamic result) async {
    expect(
      result,
      throwsException,
    );
  }

  void registerExpects({required UserInput userInput, required Matcher matcher}) async {
    await Future.microtask(() {});
    expect(
      this.harness.auth.authRegisterCompleters[userInput],
      matcher,
    );
  }

  void googleSignInExpectsExceptionFor(dynamic result) async {
    expect(
      result,
      // throwsException,
      throwsException,
    );
  }

  void googleSignInExpects(Matcher matcher) async {
    expect(
      this.harness.auth.authGoogleCompleters,
      matcher,
    );
  }
}
