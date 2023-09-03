import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tryhard_showcase/app/data/auth/models/auth_exception.dart';
import 'package:tryhard_showcase/app/data/auth/models/auth_user/auth_user.dart';
import 'package:tryhard_showcase/app/di/di.dart';
import 'package:tryhard_showcase/features/auth/data/auth_repository.dart';
import 'package:tryhard_showcase/features/auth/domain/models/user_input.dart';

import '../../../storage/fake_storage.dart';
import 'auth_form_support_test.dart';

void main() {
  const String userGuid = "123456789010111213";
  const String inputEmail = "test@test.com";
  const String input1Email = "test2@test.com";
  const String inputPassword = "12345";

  const UserInput userInput = UserInput(
    email: inputEmail,
    password: inputPassword,
  );

  const UserInput authExceptionCaseInput = UserInput(
    email: input1Email,
    password: inputPassword,
  );

  const AuthUser authUser = AuthUser(
    userGuid: userGuid,
    email: inputEmail,
  );

  final authException = AuthException(
    code: 'error code',
    message: 'Some error here',
  );

  setUp(() async {
    initHydratedStorage();

    await initDi("test");

    when(
      () => sl<AuthRepository>().login(
        email: authExceptionCaseInput.email ?? '',
        password: authExceptionCaseInput.password ?? '',
      ),
    ).thenThrow(authException);

    when(
      () => sl<AuthRepository>().login(
        email: userInput.email ?? '',
        password: userInput.password ?? '',
      ),
    ).thenAnswer((_) async => authUser);

    when(
      () => sl<AuthRepository>().register(
        email: authExceptionCaseInput.email ?? '',
        password: authExceptionCaseInput.password ?? '',
      ),
    ).thenThrow(authException);

    when(
      () => sl<AuthRepository>().register(
        email: userInput.email ?? '',
        password: userInput.password ?? '',
      ),
    ).thenAnswer((_) async => authUser);
  });

  tearDown(() {
    sl.reset(dispose: true);
  });

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

          await when.emailFilledWith(userInput.email!);
          await when.passwordFilledWith(userInput.password!);

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
          await when.emailFilledWith(userInput.email!);
          await when.passwordFilledWith(userInput.password!);

          await then.registerButtonClickableStateIs(true);
        }),
      );
    });

    group('loading states', () {
      testWidgets(
        'loading indicator is not shown by default',
        harness((given, when, then) async {
          await given.loginFormIsPumped();

          await when.emailFilledWith(userInput.email!);
          await when.passwordFilledWith(userInput.password!);

          then.loadingIndicatorShows(false);
        }),
      );

      testWidgets(
        'google button is shown if there is no loading',
        harness((given, when, then) async {
          await given.loginFormIsPumped();

          await when.emailFilledWith(userInput.email!);
          await when.passwordFilledWith(userInput.password!);

          then.googleSignInButtonVisibilityIs(true);
        }),
      );
    });

    group('error message', () {
      testWidgets(
        'is not shown by default',
        harness((given, when, then) async {
          await given.loginFormIsPumped();

          then.errorMessageIsShown(false);
        }),
      );

      testWidgets(
        'is shown if an exception throws',
        harness((given, when, then) async {
          await given.loginFormIsPumped();

          await when.emailFilledWith(authExceptionCaseInput.email!);
          await when.passwordFilledWith(authExceptionCaseInput.password!);

          await when.tapOnLoginButton();

          then.errorMessageIsShown(true);
        }),
      );
    });
  });
}
