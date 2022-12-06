import 'package:flutter_test/flutter_test.dart';
import 'package:tryhard_showcase/data/api/auth/models/auth_exception.dart';
import 'package:tryhard_showcase/ui/login/models/login_form.dart';
import 'package:tryhard_showcase/ui/login/models/user_input.dart';

import 'support_test.dart';

void main() {
  group('viewModel changes by user interactions', () {
    test(
      'view model changes on login form type changed to register',
      harness((given, when, then) async {
        when.selectFormType(LoginFormType.register);
        then.viewModelIs(
          const LoginFormViewModel.initial().copyWith(
            selectedFormType: LoginFormType.register,
          ),
        );
      }),
    );

    test(
      'view model changes on changing hiding password',
      harness((given, when, then) async {
        final currentValue = const LoginFormViewModel.initial().isPasswordHidden;

        when.changePasswordVisibility();
        then.viewModelIs(
          const LoginFormViewModel.initial().copyWith(isPasswordHidden: !currentValue),
        );
      }),
    );

    test(
      'view model changes on changing isTrainer value',
      harness((given, when, then) async {
        final currentValue = const LoginFormViewModel.initial().isTrainer;

        when.changeIsTrainerOption();
        then.viewModelIs(
          const LoginFormViewModel.initial().copyWith(isTrainer: !currentValue),
        );
      }),
    );
  });

  group('testing login call', () {
    group('login with different input cases', () {
      const inputsForEmptyFieldsException = [
        UserInput(email: "", password: ""),
        UserInput(email: "", password: "12345"),
        UserInput(email: "abc@test.com", password: ""),
      ];
      for (var input in inputsForEmptyFieldsException) {
        test(
          'login call with email: ${input.email} and password: ${input.password} should return an Exception',
          harness((given, when, then) async {
            given.userInputsAre(userInput: input);
            when.callToLoginApi();
            then.returnEmptyInputsException();
          }),
        );
      }

      test(
        'login call with filled email and password should return loading before api returns a result',
        harness((given, when, then) async {
          const input = UserInput(email: "abc@test.com", password: "12345");
          given.userInputsAre(userInput: input);
          when.callToLoginApi();
          then.viewModelIsLoading();
        }),
      );
    });

    test(
      'login call api throws an error, viewModel should contains error message',
      harness((given, when, then) async {
        const input = UserInput(email: "abc@test.com", password: "12345");

        final exception = AuthException(
          code: 'code',
          message: 'errorMessage',
        );

        given.userInputsAre(userInput: input);
        when.callToLoginApi();
        when.loginApiCompletesWithException(userInput: input, exception: exception);
        then.viewModelErrorMessageIs(exception.message);
      }),
    );

    test(
      'login call api completes successfully, viewModel should stay on loading',
      harness((given, when, then) async {
        const input = UserInput(email: "abc@test.com", password: "12345");

        given.userInputsAre(userInput: input);
        when.callToLoginApi();
        when.loginApiCompletesSuccessfully(userInput: input);
        then.viewModelIsLoading();
      }),
    );
  });

  group('testing register call', () {
    group('register with different input cases', () {
      const inputsForEmptyFieldsException = [
        UserInput(email: "", password: ""),
        UserInput(email: "", password: "12345"),
        UserInput(email: "abc@test.com", password: ""),
      ];
      for (var input in inputsForEmptyFieldsException) {
        test(
          'register call with email: ${input.email} and password: ${input.password} should return an Exception',
          harness((given, when, then) async {
            given.userInputsAre(userInput: input);
            when.callToRegisterApi();
            then.returnEmptyInputsException();
          }),
        );
      }

      test(
        'register call with filled email and password should return loading before login api returns a result',
        harness((given, when, then) async {
          const input = UserInput(email: "abc@test.com", password: "12345");
          given.userInputsAre(userInput: input);
          when.callToRegisterApi();
          then.viewModelIsLoading();
        }),
      );
    });

    test(
      'register call api throws an error, viewModel should contains error message',
      harness((given, when, then) async {
        const input = UserInput(email: "abc@test.com", password: "12345");

        final exception = AuthException(
          code: 'code',
          message: 'errorMessage',
        );

        given.userInputsAre(userInput: input);
        when.callToRegisterApi();
        when.registerApiCompletesWithException(userInput: input, exception: exception);
        then.viewModelErrorMessageIs(exception.message);
      }),
    );

    test(
      'register call api completes successfully, viewModel should stay on loading',
      harness((given, when, then) async {
        const input = UserInput(email: "abc@test.com", password: "12345");

        given.userInputsAre(userInput: input);
        when.callToRegisterApi();
        when.registerApiCompletesSuccessfully(userInput: input);
        then.viewModelIsLoading();
      }),
    );
  });

  group('testing google sign in', () {
    test(
      'should return loading before api returns a result',
      harness((given, when, then) async {
        when.callToGoogleSignInApi();
        then.viewModelIsLoading();
      }),
    );

    test(
      'when api throws an error, viewModel should contains error message',
      harness((given, when, then) async {
        final exception = AuthException(
          code: 'code',
          message: 'errorMessage',
        );

        when.callToGoogleSignInApi();
        when.googleSignInCompletesWithException(exception: exception);
        then.viewModelErrorMessageIs(exception.message);
      }),
    );

    test(
      'when completes with exception, viewModel should stay on loading',
      harness((given, when, then) async {
        when.callToGoogleSignInApi();
        when.googleSignInApiCompletesSuccessfully();
        then.viewModelIsLoading();
      }),
    );
    test(
      'when api completes with exception, login/register button stays enabled if inputs are filled properly',
      harness((given, when, then) async {
        given.userInputsAre(
            userInput: const UserInput(
          email: 'email@email.com',
          password: '12345',
        ));

        when.callToGoogleSignInApi();
        when.googleSignInCompletesWithException(
          exception: AuthException(
            code: 'code',
            message: 'message',
          ),
        );

        then.viewModelButtonEnabled();
      }),
    );

    test(
      'when api completes with exception, login/register button stays disabled if inputs are not filled',
      harness((given, when, then) async {
        given.userInputsAre(
          userInput: const UserInput(
            email: '',
            password: '',
          ),
        );

        when.callToGoogleSignInApi();
        when.googleSignInCompletesWithException(
          exception: AuthException(
            code: 'code',
            message: 'message',
          ),
        );

        then.viewModelButtonDisabled();
      }),
    );
  });
}
