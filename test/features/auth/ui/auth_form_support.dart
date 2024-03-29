import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:given_when_then/given_when_then.dart';
import 'package:tryhard_showcase/app/constants/keys.dart';
import 'package:tryhard_showcase/features/auth/ui/auth_form.dart';

Future<void> Function(WidgetTester) harness(
    WidgetTestHarnessCallback<LoginFormWidgetTestHarness> callback) {
  return (tester) =>
      givenWhenThenWidgetTest(LoginFormWidgetTestHarness(tester), callback);
}

class LoginFormWidgetTestHarness extends WidgetTestHarness {
  LoginFormWidgetTestHarness(WidgetTester tester) : super(tester);

}

extension ExampleGiven on WidgetTestGiven<LoginFormWidgetTestHarness> {
  Future<void> loginFormIsPumped() async {
    await tester.pumpWidget(
      const LoginFormTest(),
    );
  }
}

extension ExampleWhen on WidgetTestWhen<LoginFormWidgetTestHarness> {
  Future<void> tapOnRegisterHeader() async {
    await tester.tap(find.byKey(kHeaderTitleRegister));
    await tester.pump();
  }

  Future<void> tapOnLoginHeader() async {
    await tester.tap(find.byKey(kHeaderTitleLogin));
  }

  Future<void> tapOnPasswordVisibilityIcon() async {
    await tester.tap(find.byKey(kVisibilityIcon));
    await tester.pump();
  }

  Future<void> emailFilledWith(String value) async {
    await tester.enterText(find.byKey(kEmailField), value);
  }

  Future<void> passwordFilledWith(String value) async {
    await tester.enterText(find.byKey(kPasswordField), value);
  }

  Future<void> tapOnLoginButton() async {
    await tester.pump();
    await tester.tap(find.byKey(kLoginButton));
  }

  Future<void> tapOnRegisterButton() async {
    await tester.pump();
    await tester.tap(find.byKey(kRegisterButton));
  }
}

extension ExampleThen on WidgetTestThen<LoginFormWidgetTestHarness> {
  Future<void> findLoginForm() async {
    await tester.pump();
    expect(find.byKey(kAuthFormWidget), findsOneWidget);
  }

  Future<void> findRegisterFormType() async {
    await tester.pump();
    expect(find.byKey(kFormBodyLogin), findsNothing);
    expect(find.byKey(kFormBodyRegister), findsOneWidget);
  }

  Future<void> findLoginFormType() async {
    await tester.pump();
    expect(find.byKey(kFormBodyLogin), findsOneWidget);
    expect(find.byKey(kFormBodyRegister), findsNothing);
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
    expect(
        tester.widget<MaterialButton>(find.byKey(kLoginButton)).enabled, value);
  }

  Future<void> registerButtonClickableStateIs(bool value) async {
    await tester.pump();
    expect(tester.widget<MaterialButton>(find.byKey(kRegisterButton)).enabled,
        value);
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
      find.byKey(kGoogleSignInButton),
      value ? findsOneWidget : findsNothing,
    );
  }

  Future<void> errorMessageIsShown(bool value) async {
    await tester.pump();
    expect(
      find.byKey(kAuthErrorMessage),
      value ? findsOneWidget : findsNothing,
    );
  }
}

class LoginFormTest extends StatelessWidget {
  const LoginFormTest({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: AuthForm(),
      ),
    );
  }
}
