import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tryhard_showcase/app/constants/strings/errors.dart';
import 'package:tryhard_showcase/app/data/auth/models/auth_exception.dart';
import 'package:tryhard_showcase/app/data/auth/models/auth_user/auth_user.dart';
import 'package:tryhard_showcase/app/data/datasource/models/exception.dart';
import 'package:tryhard_showcase/app/data/datasource/models/user_info_basic.dart';
import 'package:tryhard_showcase/features/auth/data/auth_repository.dart';
import 'package:tryhard_showcase/features/auth/data/fake_auth_repository.dart';
import 'package:tryhard_showcase/features/auth/domain/auth_cubit/auth_cubit.dart';
import 'package:tryhard_showcase/features/auth/domain/auth_form_cubit/auth_form_cubit.dart';
import 'package:tryhard_showcase/features/auth/domain/auth_form_cubit/auth_form_state.dart';
import 'package:tryhard_showcase/features/auth/domain/models/user_input.dart';
import 'package:tryhard_showcase/features/profile/data/fake_user_repository.dart';
import 'package:tryhard_showcase/features/profile/data/user_repository.dart';

import '../../../fake_storage.dart';

void main() {
  late AuthRepository authRepository;
  late UserRepository userRepository;
  late AuthCubit authCubit;

  const String userGuid = "123456789010111213";
  const String inputName = "testName";
  const String inputEmail = "test@test.com";
  const String inputNotValidEmail = "testtest.com";
  const String inputEmptyEmail = "";
  const String inputPassword = "12345";
  const String inputEmptyPassword = "";

  const String inputErrorMessage = AppStringErrors.emailAndPasswordMustBeFilled;

  const AuthUser authUser = AuthUser(
    userGuid: userGuid,
    email: inputEmail,
  );

  final userBasicInfo = UserRegistrationBasicInfo.create(
    guid: authUser.userGuid!,
    email: authUser.email!,
  );

  final authException = AuthException(
    code: 'error code',
    message: 'Some error here',
  );

  final dbException = ApiException(
    code: 'error code',
    description: 'Some error here',
  );

  setUp(() async {
    late Storage storage;
    storage = FakeStorage();
    when(() => storage.write(any(), any<dynamic>())).thenAnswer((_) async {});
    when<dynamic>(() => storage.read(any())).thenReturn(<String, dynamic>{});
    when(() => storage.delete(any())).thenAnswer((_) async {});
    when(() => storage.clear()).thenAnswer((_) async {});

    HydratedBloc.storage = storage;
    authRepository = FakeAuthRepository();
    userRepository = FakeUserRepository();
    authCubit = AuthCubit(authRepository, userRepository);
  });

  group('AuthFormCubit', () {
    test('initial state is AuthFormState.initial() ', () {
      expect(AuthFormCubit(authCubit).state, const AuthFormState.initial());
    });

    group('auh form filling', () {
      blocTest<AuthFormCubit, AuthFormState>(
        'user entered email',
        build: () => AuthFormCubit(authCubit),
        act: (cubit) => cubit.onEmailChanged(inputEmail),
        expect: () => <AuthFormState>[
          const AuthFormState.initial().copyWith(
            inputs: const UserInput.initial().copyWith(
              email: inputEmail,
            ),
          ),
        ],
      );

      blocTest<AuthFormCubit, AuthFormState>(
        'user entered password',
        build: () => AuthFormCubit(authCubit),
        act: (cubit) => cubit.onPasswordChanged(inputPassword),
        expect: () => <AuthFormState>[
          const AuthFormState.initial().copyWith(
            inputs: const UserInput.initial().copyWith(
              password: inputPassword,
            ),
          ),
        ],
      );

      blocTest<AuthFormCubit, AuthFormState>(
        'user set password field visible',
        build: () => AuthFormCubit(authCubit),
        act: (cubit) => cubit.onHidePasswordChanged(),
        expect: () => <AuthFormState>[
          const AuthFormState.initial().copyWith(
            isPasswordHidden: false,
          ),
        ],
      );

      blocTest<AuthFormCubit, AuthFormState>(
        'login button is disabled if only email is filled',
        build: () => AuthFormCubit(authCubit),
        act: (cubit) => cubit.onEmailChanged(inputEmail),
        expect: () => <AuthFormState>[
          const AuthFormState.initial().copyWith(
            inputs: const UserInput.initial().copyWith(
              email: inputEmail,
            ),
            authButtonState: AuthButtonState.disabled,
          ),
        ],
      );

      blocTest<AuthFormCubit, AuthFormState>(
        'login button is disabled if only password is filled',
        build: () => AuthFormCubit(authCubit),
        act: (cubit) => cubit.onPasswordChanged(inputPassword),
        expect: () => <AuthFormState>[
          const AuthFormState.initial().copyWith(
            inputs: const UserInput.initial().copyWith(
              password: inputPassword,
            ),
            authButtonState: AuthButtonState.disabled,
          ),
        ],
      );

      blocTest<AuthFormCubit, AuthFormState>(
        'login button is disabled if password is filled, but email is not valid',
        build: () => AuthFormCubit(authCubit),
        seed: () => const AuthFormState.initial().copyWith(
          inputs: const UserInput(
            password: inputPassword,
          ),
        ),
        act: (cubit) => cubit.onEmailChanged(inputNotValidEmail),
        expect: () => <AuthFormState>[
          const AuthFormState.initial().copyWith(
            inputs: const UserInput.initial().copyWith(
              email: inputNotValidEmail,
              password: inputPassword,
            ),
            authButtonState: AuthButtonState.disabled,
          ),
        ],
      );

      blocTest<AuthFormCubit, AuthFormState>(
        'login button is enabled if email and password are filled properly',
        build: () => AuthFormCubit(authCubit),
        seed: () => const AuthFormState.initial().copyWith(
          inputs: const UserInput(
            password: inputPassword,
          ),
        ),
        act: (cubit) => cubit.onEmailChanged(inputEmail),
        expect: () => <AuthFormState>[
          const AuthFormState.initial().copyWith(
            inputs: const UserInput.initial().copyWith(
              email: inputEmail,
              password: inputPassword,
            ),
            authButtonState: AuthButtonState.enabled,
          ),
        ],
      );

      blocTest<AuthFormCubit, AuthFormState>(
        'user changed form to Register',
        build: () => AuthFormCubit(authCubit),
        act: (cubit) => cubit.onFormTypeChanged(AuthFormType.register),
        expect: () => <AuthFormState>[
          const AuthFormState.initial().copyWith(
            selectedFormType: AuthFormType.register,
          ),
        ],
      );

      blocTest<AuthFormCubit, AuthFormState>(
        'user filled name field on Register form',
        build: () => AuthFormCubit(authCubit),
        seed: () => const AuthFormState.initial()
            .copyWith(selectedFormType: AuthFormType.register),
        act: (cubit) => cubit.onNameChanged(inputName),
        expect: () => <AuthFormState>[
          const AuthFormState.initial().copyWith(
            selectedFormType: AuthFormType.register,
            inputs: const UserInput.initial().copyWith(
              name: inputName,
            ),
          ),
        ],
      );

      blocTest<AuthFormCubit, AuthFormState>(
        'user changed isTrainer checkbox on Register form',
        build: () => AuthFormCubit(authCubit),
        seed: () => const AuthFormState.initial().copyWith(
          selectedFormType: AuthFormType.register,
        ),
        act: (cubit) => cubit.onIsTrainerChanged(),
        expect: () => <AuthFormState>[
          const AuthFormState.initial().copyWith(
            selectedFormType: AuthFormType.register,
            inputs: const UserInput.initial().copyWith(
              isTrainer: true,
            ),
          ),
        ],
      );

      blocTest<AuthFormCubit, AuthFormState>(
        'register button is disabled if only email is filled',
        build: () => AuthFormCubit(authCubit),
        seed: () => const AuthFormState.initial()
            .copyWith(selectedFormType: AuthFormType.register),
        act: (cubit) => cubit.onEmailChanged(inputEmail),
        expect: () => <AuthFormState>[
          const AuthFormState.initial().copyWith(
            selectedFormType: AuthFormType.register,
            inputs: const UserInput.initial().copyWith(
              email: inputEmail,
            ),
            authButtonState: AuthButtonState.disabled,
          ),
        ],
      );

      blocTest<AuthFormCubit, AuthFormState>(
        'register button is disabled if only password is filled',
        build: () => AuthFormCubit(authCubit),
        seed: () => const AuthFormState.initial()
            .copyWith(selectedFormType: AuthFormType.register),
        act: (cubit) => cubit.onPasswordChanged(inputPassword),
        expect: () => <AuthFormState>[
          const AuthFormState.initial().copyWith(
            selectedFormType: AuthFormType.register,
            inputs: const UserInput.initial().copyWith(
              password: inputPassword,
            ),
            authButtonState: AuthButtonState.disabled,
          ),
        ],
      );

      blocTest<AuthFormCubit, AuthFormState>(
        'register button is disabled if password is filled, but email is not valid',
        build: () => AuthFormCubit(authCubit),
        seed: () => const AuthFormState.initial().copyWith(
          selectedFormType: AuthFormType.register,
          inputs: const UserInput(
            password: inputPassword,
          ),
        ),
        act: (cubit) => cubit.onEmailChanged(inputNotValidEmail),
        expect: () => <AuthFormState>[
          const AuthFormState.initial().copyWith(
            selectedFormType: AuthFormType.register,
            inputs: const UserInput.initial().copyWith(
              email: inputNotValidEmail,
              password: inputPassword,
            ),
            authButtonState: AuthButtonState.disabled,
          ),
        ],
      );

      blocTest<AuthFormCubit, AuthFormState>(
        'register button is enabled if email and password are filled properly',
        build: () => AuthFormCubit(authCubit),
        seed: () => const AuthFormState.initial().copyWith(
          selectedFormType: AuthFormType.register,
          inputs: const UserInput(
            password: inputPassword,
          ),
        ),
        act: (cubit) => cubit.onEmailChanged(inputEmail),
        expect: () => <AuthFormState>[
          const AuthFormState.initial().copyWith(
            selectedFormType: AuthFormType.register,
            inputs: const UserInput.initial().copyWith(
              email: inputEmail,
              password: inputPassword,
            ),
            authButtonState: AuthButtonState.enabled,
          ),
        ],
      );
    });

    group('testing behaviour of auth form by executing login method', () {
      blocTest<AuthFormCubit, AuthFormState>(
        'login returns an input error, if email is empty, then state must contain error message',
        setUp: () {
          when(
            () => authRepository.login(
              email: inputEmptyEmail,
              password: inputPassword,
            ),
          ).thenThrow(authException);
        },
        seed: () => const AuthFormState.initial().copyWith(
          inputs: const UserInput(
            email: inputEmptyEmail,
            password: inputPassword,
          ),
        ),
        build: () => AuthFormCubit(authCubit),
        act: (cubit) => cubit.onLogin(),
        expect: () => <AuthFormState>[
          const AuthFormState.error(
            errorMessage: inputErrorMessage,
            inputs: UserInput(
              email: inputEmptyEmail,
              password: inputPassword,
            ),
            isPasswordHidden: true,
            authButtonState: AuthButtonState.disabled,
            selectedFormType: AuthFormType.login,
          ),
        ],
      );

      blocTest<AuthFormCubit, AuthFormState>(
        'login returns an input error, if password is empty, then state must contain error message',
        setUp: () {
          when(
            () => authRepository.login(
              email: inputEmail,
              password: inputEmptyPassword,
            ),
          ).thenThrow(authException);
        },
        seed: () => const AuthFormState.initial().copyWith(
          inputs: const UserInput(
            email: inputEmail,
            password: inputEmptyPassword,
          ),
        ),
        build: () => AuthFormCubit(authCubit),
        act: (cubit) => cubit.onLogin(),
        expect: () => <AuthFormState>[
          const AuthFormState.error(
            errorMessage: inputErrorMessage,
            inputs: UserInput(
              email: inputEmail,
              password: inputEmptyPassword,
            ),
            isPasswordHidden: true,
            authButtonState: AuthButtonState.disabled,
            selectedFormType: AuthFormType.login,
          ),
        ],
      );

      blocTest<AuthFormCubit, AuthFormState>(
        'login returns an error, error must be caught and state must contain error message',
        setUp: () {
          when(
            () => authRepository.login(
                email: inputEmail, password: inputPassword),
          ).thenThrow(authException);
        },
        seed: () => const AuthFormState.initial().copyWith(
          inputs: const UserInput(
            email: inputEmail,
            password: inputPassword,
          ),
        ),
        build: () => AuthFormCubit(authCubit),
        act: (cubit) => cubit.onLogin(),
        expect: () => <AuthFormState>[
          const AuthFormState.loading(
            selectedFormType: AuthFormType.login,
            inputs: UserInput(
              email: inputEmail,
              password: inputPassword,
            ),
            isPasswordHidden: true,
          ),
          AuthFormState.error(
            errorMessage: authException.message,
            inputs: const UserInput(
              email: inputEmail,
              password: inputPassword,
            ),
            isPasswordHidden: true,
            authButtonState: AuthButtonState.enabled,
            selectedFormType: AuthFormType.login,
          ),
        ],
      );

      blocTest<AuthFormCubit, AuthFormState>(
        'user successfully passed login',
        setUp: () {
          when(
            () => authRepository.login(
                email: inputEmail, password: inputPassword),
          ).thenAnswer((_) async {
            return authUser;
          });
        },
        seed: () => const AuthFormState.initial().copyWith(
          inputs: const UserInput(
            email: inputEmail,
            password: inputPassword,
          ),
        ),
        build: () => AuthFormCubit(authCubit),
        act: (cubit) => cubit.onLogin(),
        expect: () => <AuthFormState>[
          const AuthFormState.loading(
            selectedFormType: AuthFormType.login,
            inputs: UserInput(
              email: inputEmail,
              password: inputPassword,
            ),
            isPasswordHidden: true,
          ),
          AuthFormState.done(
            inputs: const UserInput(
              email: inputEmail,
              password: inputPassword,
            ),
          ),
        ],
      );
    });

    group('testing behaviour of auth form by executing register method', () {
      blocTest<AuthFormCubit, AuthFormState>(
        'register returns an input error, if email is empty, then state must contain error message',
        setUp: () {
          when(
            () => authRepository.register(
              email: inputEmptyEmail,
              password: inputPassword,
            ),
          ).thenThrow(authException);
        },
        seed: () => const AuthFormState.initial().copyWith(
          selectedFormType: AuthFormType.register,
          inputs: const UserInput(
            email: inputEmptyEmail,
            password: inputPassword,
          ),
        ),
        build: () => AuthFormCubit(authCubit),
        act: (cubit) => cubit.onRegister(),
        expect: () => <AuthFormState>[
          const AuthFormState.error(
            errorMessage: inputErrorMessage,
            inputs: UserInput(
              email: inputEmptyEmail,
              password: inputPassword,
            ),
            isPasswordHidden: true,
            authButtonState: AuthButtonState.disabled,
            selectedFormType: AuthFormType.register,
          ),
        ],
      );

      blocTest<AuthFormCubit, AuthFormState>(
        'register returns an input error, if password is empty, then state must contain error message',
        setUp: () {
          when(
            () => authRepository.register(
              email: inputEmail,
              password: inputEmptyPassword,
            ),
          ).thenThrow(authException);
        },
        seed: () => const AuthFormState.initial().copyWith(
          selectedFormType: AuthFormType.register,
          inputs: const UserInput(
            email: inputEmail,
            password: inputEmptyPassword,
          ),
        ),
        build: () => AuthFormCubit(authCubit),
        act: (cubit) => cubit.onRegister(),
        expect: () => <AuthFormState>[
          const AuthFormState.error(
            errorMessage: inputErrorMessage,
            inputs: UserInput(
              email: inputEmail,
              password: inputEmptyPassword,
            ),
            isPasswordHidden: true,
            authButtonState: AuthButtonState.disabled,
            selectedFormType: AuthFormType.register,
          ),
        ],
      );

      blocTest<AuthFormCubit, AuthFormState>(
        'user registration is not succeed when auth repository returns an error, error must be in state',
        setUp: () {
          when(
            () => authRepository.register(
                email: inputEmail, password: inputPassword),
          ).thenThrow(authException);
        },
        seed: () => const AuthFormState.initial().copyWith(
          selectedFormType: AuthFormType.register,
          inputs: const UserInput(
            email: inputEmail,
            password: inputPassword,
          ),
        ),
        build: () => AuthFormCubit(authCubit),
        act: (cubit) => cubit.onRegister(),
        expect: () => <AuthFormState>[
          const AuthFormState.loading(
            inputs: UserInput(
              email: inputEmail,
              password: inputPassword,
            ),
            isPasswordHidden: true,
            selectedFormType: AuthFormType.register,
          ),
          AuthFormState.error(
            errorMessage: authException.message,
            inputs: const UserInput(
              email: inputEmail,
              password: inputPassword,
            ),
            isPasswordHidden: true,
            selectedFormType: AuthFormType.register,
            authButtonState: AuthButtonState.enabled,
          ),
        ],
      );

      blocTest<AuthFormCubit, AuthFormState>(
        'user registration is not succeed when user is not created in DB, error must be in state',
        setUp: () {
          when(
            () => authRepository.register(
                email: inputEmail, password: inputPassword),
          ).thenAnswer((_) async {
            return authUser;
          });
          when(
            () => userRepository.createUserProfile(
              userBasicInfo: userBasicInfo,
            ),
          ).thenThrow(dbException);
        },
        seed: () => const AuthFormState.initial().copyWith(
          selectedFormType: AuthFormType.register,
          inputs: const UserInput(
            email: inputEmail,
            password: inputPassword,
          ),
        ),
        build: () => AuthFormCubit(authCubit),
        act: (cubit) => cubit.onRegister(),
        expect: () => <AuthFormState>[
          const AuthFormState.loading(
            inputs: UserInput(
              email: inputEmail,
              password: inputPassword,
            ),
            isPasswordHidden: true,
            selectedFormType: AuthFormType.register,
          ),
          AuthFormState.error(
            errorMessage: dbException.description,
            inputs: const UserInput(
              email: inputEmail,
              password: inputPassword,
            ),
            isPasswordHidden: true,
            selectedFormType: AuthFormType.register,
            authButtonState: AuthButtonState.enabled,
          ),
        ],
      );

      blocTest<AuthFormCubit, AuthFormState>(
        'user successfully passed register',
        setUp: () {
          when(
            () => authRepository.register(
                email: inputEmail, password: inputPassword),
          ).thenAnswer((_) async {
            return authUser;
          });
          when(
            () => userRepository.createUserProfile(
              userBasicInfo: userBasicInfo,
            ),
          ).thenAnswer((_) async {});
        },
        seed: () => const AuthFormState.initial().copyWith(
          selectedFormType: AuthFormType.register,
          inputs: const UserInput(
            email: inputEmail,
            password: inputPassword,
          ),
        ),
        build: () => AuthFormCubit(authCubit),
        act: (cubit) => cubit.onRegister(),
        expect: () => <AuthFormState>[
          const AuthFormState.loading(
            inputs: UserInput(
              email: inputEmail,
              password: inputPassword,
            ),
            isPasswordHidden: true,
            selectedFormType: AuthFormType.register,
          ),
          AuthFormState.done(
            inputs: const UserInput(
              email: inputEmail,
              password: inputPassword,
            ),
          ),
        ],
      );
    });

    group('testing behaviour of auth form by executing google sign in method',
        () {
      blocTest<AuthFormCubit, AuthFormState>(
        'google sign in returns an auth error, then state must contain error message',
        setUp: () {
          when(
            () => authRepository.googleLogIn(),
          ).thenThrow(authException);
        },
        seed: () => const AuthFormState.initial(),
        build: () => AuthFormCubit(authCubit),
        act: (cubit) => cubit.onGoogleSignIn(),
        expect: () => <AuthFormState>[
          const AuthFormState.initial()
              .copyWith(authButtonState: AuthButtonState.loading),
          const AuthFormState.initial()
              .copyWith(errorMessage: authException.message)
        ],
      );

      blocTest<AuthFormCubit, AuthFormState>(
        'google sign in returns an auth error, form is filled, then state must contain error message and filled form',
        setUp: () {
          when(
            () => authRepository.googleLogIn(),
          ).thenThrow(authException);
        },
        seed: () => const AuthFormState.initial().copyWith(
          inputs: const UserInput(
            email: inputEmail,
            password: inputPassword,
            isTrainer: true,
          ),
          selectedFormType: AuthFormType.login,
          isPasswordHidden: false,
          authButtonState: AuthButtonState.enabled,
        ),
        build: () => AuthFormCubit(authCubit),
        act: (cubit) => cubit.onGoogleSignIn(),
        expect: () => <AuthFormState>[
          const AuthFormState.loading(
              inputs: UserInput(
                email: inputEmail,
                password: inputPassword,
                isTrainer: true,
              ),
              selectedFormType: AuthFormType.login,
              isPasswordHidden: false),
          AuthFormState.error(
            errorMessage: authException.message,
            inputs: const UserInput(
              email: inputEmail,
              password: inputPassword,
              isTrainer: true,
            ),
            selectedFormType: AuthFormType.login,
            isPasswordHidden: false,
            authButtonState: AuthButtonState.enabled,
          ),
        ],
      );

      blocTest<AuthFormCubit, AuthFormState>(
        'google sign in is not succeed when user is not created in DB, error must be in state',
        setUp: () {
          when(
            () => authRepository.googleLogIn(),
          ).thenAnswer((_) async {
            return authUser;
          });
          when(
            () => userRepository.createUserProfile(
              userBasicInfo: userBasicInfo,
            ),
          ).thenThrow(dbException);
        },
        seed: () => const AuthFormState.initial(),
        build: () => AuthFormCubit(authCubit),
        act: (cubit) => cubit.onGoogleSignIn(),
        expect: () => <AuthFormState>[
          const AuthFormState.initial().copyWith(
            authButtonState: AuthButtonState.loading,
          ),
          const AuthFormState.initial().copyWith(
            errorMessage: dbException.description,
          ),
        ],
      );

      blocTest<AuthFormCubit, AuthFormState>(
        'user successfully passed google sign in',
        setUp: () {
          when(
            () => authRepository.googleLogIn(),
          ).thenAnswer((_) async {
            return authUser;
          });
          when(
            () => userRepository.createUserProfile(
              userBasicInfo: userBasicInfo,
            ),
          ).thenAnswer((_) async {});
        },
        build: () => AuthFormCubit(authCubit),
        act: (cubit) => cubit.onGoogleSignIn(),
        expect: () => <AuthFormState>[
          const AuthFormState.initial().copyWith(
            authButtonState: AuthButtonState.loading,
          ),
          AuthFormState.done(inputs: const UserInput()),
        ],
      );
    });
  });
}
