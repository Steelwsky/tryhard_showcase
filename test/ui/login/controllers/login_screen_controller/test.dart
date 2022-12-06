import 'package:flutter_test/flutter_test.dart';
import 'package:tryhard_showcase/data/api/auth/models/auth_exception.dart';
import 'package:tryhard_showcase/data/api/auth/models/auth_user.dart';
import 'package:tryhard_showcase/data/api/datasource/models/exception.dart';
import 'package:tryhard_showcase/ui/login/models/user_input.dart';
import 'package:uuid/uuid.dart';

import '../../../../matchers.dart';
import 'support_test.dart';

void main() {
  const String inputEmail = 'abc@test.com';
  const String inputPassword = '12345';

  group('testing user login screen controller', () {
    group('call login from auth repository', () {
      test(
        'should throw an exception if the user is already logged in',
        harness((given, when, then) async {
          const input = UserInput(
            email: inputEmail,
            password: inputPassword,
          );

          when.userLoggedInStateIs(true);
          final result = when.userLoggingIn(userInput: input);

          await expectLater(
            () => result,
            throwsA(
              authException(
                code: 'login-error',
                message: 'User is already logged in',
              ),
            ),
          );
        }),
      );

      test(
        'completes successfully',
        harness((given, when, then) async {
          const input = UserInput(
            email: inputEmail,
            password: inputPassword,
          );

          when.userLoggedInStateIs(false);
          when.userLoggingIn(userInput: input);
          when.logInApiCompletesSuccessfully(userInput: input);

          then.logInExpects(
            userInput: input,
            matcher: isNotEmpty,
          );
        }),
      );

      test(
        'completes with exception',
        harness((given, when, then) async {
          const input = UserInput(email: inputEmail, password: inputPassword);

          when.userLoggedInStateIs(false);

          final result = when.userLoggingIn(userInput: input);
          when.logInApiCompletesWithException(
            userInput: input,
            exception: AuthException(
              code: 'login-error',
              message: 'error message',
            ),
          );

          await expectLater(
                () => result,
            throwsA(
              authException(
                code: 'login-error',
                message: 'error message',
              ),
            ),
          );
        }),
      );
    });

    group('call register from auth repository', () {
      test(
        'completes with caught auth exception',
        harness((given, when, then) async {
          const input = UserInput(
            email: inputEmail,
            password: inputPassword,
          );

          final result = when.userRegister(userInput: input);
          when.registerAuthApiCompletesWithAuthException(
            userInput: input,
            exception: AuthException(
              code: 'register-error',
              message: 'error message',
            ),
          );

          await expectLater(
                () => result,
            throwsA(
              authException(
                code: 'register-error',
                message: 'error message',
              ),
            ),
          );
        }),
      );

      test(
        'should throw an exception if the user is not logged in auth service after successful registration',
        harness((given, when, then) async {
          const input = UserInput(email: inputEmail, password: inputPassword);

          final Future<dynamic> result = when.userRegister(userInput: input);
          when.registerAuthApiCompletesSuccessfully(userInput: input);

          when.userLoggedInStateIs(true);
          when.setAuthFakeUser(
            AuthUser(
              userGuid: const Uuid().v4(),
              email: input.email,
            ),
          );

          await Future.microtask(() {});

          when.registerUserApiCompletesWithApiException(
            userInput: input,
            exception: ApiException(
              code: 'register-error',
              description: 'user is not logged in',
            ),
          );

          await expectLater(
                () => result,
            throwsA(
              apiException(
                code: 'register-error',
                description: 'user is not logged in',
              ),
            ),
          );
        }),
      );

      test(
        'should throw an exception if the user is not created in Database',
        harness((given, when, then) async {
          const input = UserInput(email: inputEmail, password: inputPassword);

          final result = when.userRegister(userInput: input);
          when.registerAuthApiCompletesSuccessfully(userInput: input);
          when.userLoggedInStateIs(true);
          when.setAuthFakeUser(
            AuthUser(
              userGuid: const Uuid().v4(),
              email: input.email,
            ),
          );

          await Future.microtask(() {});
          when.registerUserApiCompletesWithApiException(
            userInput: input,
            exception: ApiException(
              code: 'user-api',
              description: 'user not created',
            ),
          );

          await expectLater(
                () => result,
            throwsA(
              apiException(
                code: 'user-api',
                description: 'user not created',
              ),
            ),
          );
        }),
      );

      test(
        'should completes after successful registration',
        harness((given, when, then) async {
          const input = UserInput(
            email: inputEmail,
            password: inputPassword,
          );

          when.userRegister(userInput: input);
          when.registerAuthApiCompletesSuccessfully(userInput: input);
          when.userLoggedInStateIs(true);
          when.setAuthFakeUser(
            AuthUser(
              userGuid: const Uuid().v4(),
              email: input.email,
            ),
          );

          await Future.microtask(() {});
          when.registerDbApiCompletesSuccessfully(
            userInput: input,
          );

          then.registerExpects(
            userInput: input,
            matcher: isNotEmpty,
          );
        }),
      );
    });

    group('on google sign in', () {
      test(
        'should return an auth exception if google service returns an error',
        harness((given, when, then) async {
          final result = when.googleSignIn();
          when.googleSignInAuthApiCompletesWithAuthException(
            exception: AuthException(
              code: 'auth-user',
              message: 'api returns an error',
            ),
          );

          await expectLater(
            () => result,
            throwsA(authException(
              code: 'auth-user',
              message: 'api returns an error',
            )),
          );
        }),
      );

      test(
        'should return an auth exception if user still is not logged in after successful google response',
        harness((given, when, then) async {
          final result = when.googleSignIn();
          when.googleSignInAuthApiCompletesSuccessfully();
          when.userLoggedInStateIs(false);

          await expectLater(
                () => result,
            throwsA(
              authException(
                code: 'auth-user',
                message: 'An error occurred. Please try again',
              ),
            ),
          );
        }),
      );

      test(
        'should return an auth exception if user is null after logged in',
        harness((given, when, then) async {
          final result = when.googleSignIn();
          when.googleSignInAuthApiCompletesSuccessfully();
          when.userLoggedInStateIs(true);
          when.setAuthFakeUser(null);

          await expectLater(
                () => result,
            throwsA(
              authException(
                code: 'auth-user',
                message: 'Google sign in is canceled',
              ),
            ),
          );
        }),
      );

      test(
        'should return an api exception if user is not created in DB',
        harness((given, when, then) async {
          final result = when.googleSignIn();
          when.googleSignInAuthApiCompletesSuccessfully();
          when.userLoggedInStateIs(true);
          when.setAuthFakeUser(
            AuthUser(
              userGuid: const Uuid().v4(),
              email: inputEmail,
            ),
          );

          await Future.microtask(() {});
          when.registerUserApiCompletesWithApiException(
            userInput: const UserInput(email: inputEmail),
            exception: ApiException(
              code: 'register-error',
              description: 'user is not created in DB',
            ),
          );

          await expectLater(
                () => result,
            throwsA(
              apiException(
                code: 'register-error',
                description: 'user is not created in DB',
              ),
            ),
          );
        }),
      );

      test(
        'should successfully completes if no exceptions appeared',
        harness((given, when, then) async {
          when.googleSignIn();
          when.googleSignInAuthApiCompletesSuccessfully();
          when.userLoggedInStateIs(true);
          when.setAuthFakeUser(
            AuthUser(
              userGuid: const Uuid().v4(),
              email: inputEmail,
            ),
          );

          await Future.microtask(() {});
          when.registerDbApiCompletesSuccessfully(
            userInput: const UserInput(email: inputEmail),
          );

          then.googleSignInExpects(isNotEmpty);
        }),
      );
    });
  });
}
