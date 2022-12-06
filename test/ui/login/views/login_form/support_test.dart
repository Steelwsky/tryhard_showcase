import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:given_when_then/given_when_then.dart';
import 'package:tryhard_showcase/data/api/auth/models/auth_exception.dart';
import 'package:tryhard_showcase/ui/login/controllers/login_form_controller.dart';
import 'package:tryhard_showcase/ui/login/controllers/login_screen_controller.dart';
import 'package:tryhard_showcase/ui/login/models/login_form.dart';
import 'package:tryhard_showcase/ui/login/models/user_input.dart';
import 'package:tryhard_showcase/ui/login/views/login_form.dart';

import '../../../../data/repositories/fake_auth_repository.dart';
import '../../../../data/repositories/fake_user_repository.dart';

const _loginFormKey = ValueKey('LoginFormWidget');
final _headerLogin = ValueKey('_HeaderTitle${LoginFormType.login}');
final _headerRegister = ValueKey('_HeaderTitle${LoginFormType.register}');
final _bodyLogin = ValueKey('_FormBody${LoginFormType.login}');
final _bodyRegister = ValueKey('_FormBody${LoginFormType.register}');

const _visibilityIcon = ValueKey('visibilityIcon');

const _emailField = ValueKey('emailField');
const _passwordField = ValueKey('passwordField');

const _registerButton = ValueKey('RegisterButtonKey');
const _loginButton = ValueKey('LoginButtonKey');

const _googleButton = ValueKey('googleSignInButton');

const _authErrorMessage = ValueKey('authErrorMessage');

Future<void> Function(WidgetTester) harness(
    WidgetTestHarnessCallback<LoginFormWidgetTestHarness> callback) {
  return (tester) => givenWhenThenWidgetTest(LoginFormWidgetTestHarness(tester), callback);
}

class LoginFormWidgetTestHarness extends WidgetTestHarness {
  LoginFormWidgetTestHarness(WidgetTester tester) : super(tester);

  final authRepository = FakeAuthRepository();
  final userRepository = FakeUserRepository();

  late final UserLoginController userLoginController = RealUserLoginController(
    auth: authRepository,
    userRepository: userRepository,
  );

  late final LoginFormController loginFormController = RealLoginFormController(
    userLoginController: userLoginController,
  );
}

extension ExampleGiven on WidgetTestGiven<LoginFormWidgetTestHarness> {
  Future<void> loginFormIsPumped() async {
    await tester.pumpWidget(
      LoginFormTest(
        loginFormController: this.harness.loginFormController,
      ),
    );
  }
}

extension ExampleWhen on WidgetTestWhen<LoginFormWidgetTestHarness> {
  Future<void> tapOnRegisterHeader() async {
    await tester.tap(find.byKey(_headerRegister));
    await tester.pump();
  }

  Future<void> tapOnLoginHeader() async {
    await tester.tap(find.byKey(_headerLogin));
  }

  Future<void> tapOnPasswordVisibilityIcon() async {
    await tester.tap(find.byKey(_visibilityIcon));
    await tester.pump();
  }

  Future<void> emailFilledWith(String value) async {
    await tester.enterText(find.byKey(_emailField), value);
  }

  Future<void> passwordFilledWith(String value) async {
    await tester.enterText(find.byKey(_passwordField), value);
  }

  Future<void> tapOnLoginButton() async {
    await tester.pump();
    await tester.tap(find.byKey(_loginButton));
  }

  Future<void> tapOnRegisterButton() async {
    await tester.pump();
    await tester.tap(find.byKey(_registerButton));
  }

  Future<void> loginApiCompletesWithExceptionFor(UserInput userInput) async {
    this
        .harness
        .authRepository
        .authLoginCompleters[UserInput(
          email: userInput.email,
          password: userInput.password,
        )]!
        .single
        .completeError(
          AuthException(code: 'code', message: 'message'),
        );
  }

  Future<void> registerApiCompletesWithException(UserInput userInput) async {
    this
        .harness
        .authRepository
        .authRegisterCompleters[UserInput(
          email: userInput.email,
          password: userInput.password,
        )]!
        .single
        .completeError(
          AuthException(
            code: 'code',
            message: 'message',
          ),
        );
  }
}

extension ExampleThen on WidgetTestThen<LoginFormWidgetTestHarness> {
  Future<void> findLoginForm() async {
    await tester.pump();
    expect(find.byKey(_loginFormKey), findsOneWidget);
  }

  Future<void> findRegisterFormType() async {
    await tester.pump();
    expect(find.byKey(_bodyLogin), findsNothing);
    expect(find.byKey(_bodyRegister), findsOneWidget);
  }

  Future<void> findLoginFormType() async {
    await tester.pump();
    expect(find.byKey(_bodyLogin), findsOneWidget);
    expect(find.byKey(_bodyRegister), findsNothing);
  }

  Future<void> findPasswordIconVisibilityIsOff() async {
    await tester.pump();
    expect(find.byIcon(Icons.visibility_off), findsOneWidget);
  }

  Future<void> findPasswordIconVisibilityIsOn() async {
    await tester.pump();
    expect(find.byIcon(Icons.visibility), findsOneWidget);
  }

  Future<void> loginButtonClickableStateIs(bool value) async {
    await tester.pump();
    expect(tester.widget<MaterialButton>(find.byKey(_loginButton)).enabled, value);
  }

  Future<void> registerButtonClickableStateIs(bool value) async {
    await tester.pump();
    expect(tester.widget<MaterialButton>(find.byKey(_registerButton)).enabled, value);
  }

  Future<void> loadingIndicatorShows(bool value) async {
    await tester.pump();
    expect(
      find.byType(CircularProgressIndicator),
      value ? findsOneWidget : findsNothing,
    );
  }

  Future<void> googleSignInButtonVisibilityIs(bool value) async {
    await tester.pump();
    expect(
      find.byKey(_googleButton),
      value ? findsOneWidget : findsNothing,
    );
  }

  Future<void> errorMessageIsShown(bool value) async {
    await tester.pump();
    expect(
      find.byKey(_authErrorMessage),
      value ? findsOneWidget : findsNothing,
    );
  }
}

class LoginFormTest extends StatelessWidget {
  const LoginFormTest({
    Key? key,
    required this.loginFormController,
  }) : super(key: key);
  final LoginFormController loginFormController;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: LoginForm(
          loginFormController: loginFormController,
        ),
      ),
    );
  }
}
