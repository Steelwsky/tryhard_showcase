import 'package:flutter_test/flutter_test.dart';
import 'package:tryhard_showcase/ui/login/models/user_input.dart';

import 'support_test.dart';

void main() {
  group('testing login form', () {
    testWidgets(
      'login form is successfully pumped',
      harness((given, when, then) async {
        await given.loginFormIsPumped();
        await then.findLoginForm();
      }),
    );

    group('form changes by headers tapping', () {
      testWidgets(
        'The form changes on taping header texts',
        harness((given, when, then) async {
          await given.loginFormIsPumped();
          await when.tapOnRegisterHeader();
          await then.findRegisterFormType();
        }),
      );

      testWidgets(
        'The form return back to login',
        harness((given, when, then) async {
          await given.loginFormIsPumped();
          await when.tapOnRegisterHeader();
          await when.tapOnLoginHeader();
          await then.findLoginFormType();
        }),
      );
    });

    group('password icon changes on tapping', () {
      testWidgets(
        'password icon is hidden by default',
        harness((given, when, then) async {
          await given.loginFormIsPumped();
          await then.findPasswordIconVisibilityIsOff();
        }),
      );

      testWidgets(
        'password is hidden by default',
        harness((given, when, then) async {
          await given.loginFormIsPumped();
          await when.tapOnPasswordVisibilityIcon();
          await then.findPasswordIconVisibilityIsOn();
        }),
      );
    });

    group('checking login/register button availability', () {
      testWidgets(
        'Login button does not work when email and password fields are empty',
        harness((given, when, then) async {
          await given.loginFormIsPumped();

          await when.emailFilledWith('');
          await when.passwordFilledWith('');

          await then.loginButtonClickableStateIs(false);
        }),
      );

      testWidgets(
        'Login button works when email and password fields are filled',
        harness((given, when, then) async {
          await given.loginFormIsPumped();

          await when.emailFilledWith('abc@test.com');
          await when.passwordFilledWith('1234');

          await then.loginButtonClickableStateIs(true);
        }),
      );

      testWidgets(
        'Register button does not work when email and password fields are empty',
        harness((given, when, then) async {
          await given.loginFormIsPumped();

          await when.tapOnRegisterHeader();
          await when.emailFilledWith('');
          await when.passwordFilledWith('');

          await then.registerButtonClickableStateIs(false);
        }),
      );

      testWidgets(
        'Register button works when email and password fields are filled',
        harness((given, when, then) async {
          await given.loginFormIsPumped();

          await when.tapOnRegisterHeader();
          await when.emailFilledWith('abc@test.com');
          await when.passwordFilledWith('12345');

          await then.registerButtonClickableStateIs(true);
        }),
      );
    });

    group('loading states', () {
      testWidgets(
        'loading indicator is not shown by default',
        harness((given, when, then) async {
          await given.loginFormIsPumped();

          await when.emailFilledWith('abc@test.com');
          await when.passwordFilledWith('12345');

          then.loadingIndicatorShows(false);
        }),
      );

      testWidgets(
        'loading indicator is shown after login button is tapped',
        harness((given, when, then) async {
          await given.loginFormIsPumped();

          await when.emailFilledWith('abc@test.com');
          await when.passwordFilledWith('12345');

          await when.tapOnLoginButton();

          then.loadingIndicatorShows(true);
        }),
      );

      testWidgets(
        'loading indicator shows after register button is tapped',
        harness((given, when, then) async {
          await given.loginFormIsPumped();

          await when.tapOnRegisterHeader();
          await when.emailFilledWith('abc@test.com');
          await when.passwordFilledWith('12345');

          await when.tapOnRegisterButton();

          then.loadingIndicatorShows(true);
        }),
      );

      testWidgets(
        'google button is shown if there is no loading',
        harness((given, when, then) async {
          await given.loginFormIsPumped();

          await when.emailFilledWith('abc@test.com');
          await when.passwordFilledWith('12345');

          then.googleSignInButtonVisibilityIs(true);
        }),
      );

      testWidgets(
        'google button is not shown if there is a loading indicator',
        harness((given, when, then) async {
          await given.loginFormIsPumped();

          await when.emailFilledWith('abc@test.com');
          await when.passwordFilledWith('12345');

          await when.tapOnLoginButton();

          then.googleSignInButtonVisibilityIs(false);
        }),
      );
    });

    group('error message', () {
      testWidgets(
        'no error message is shown by default',
        harness((given, when, then) async {
          await given.loginFormIsPumped();

          then.errorMessageIsShown(false);
        }),
      );

      testWidgets(
        'error message is shown if an exception throws',
        harness((given, when, then) async {
          const input = UserInput(email: 'abc@test.com', password: '12345');

          await given.loginFormIsPumped();

          await when.emailFilledWith(input.email!);
          await when.passwordFilledWith(input.password!);

          await when.tapOnLoginButton();
          when.loginApiCompletesWithExceptionFor(input);

          then.errorMessageIsShown(true);
        }),
      );
    });
  });
}
