import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tryhard_showcase/app/data/auth/models/auth_exception.dart';
import 'package:tryhard_showcase/app/data/auth/models/auth_user/auth_user.dart';
import 'package:tryhard_showcase/app/data/datasource/models/exception.dart';
import 'package:tryhard_showcase/app/data/datasource/models/user_info_basic.dart';
import 'package:tryhard_showcase/features/auth/data/auth_repository.dart';
import 'package:tryhard_showcase/features/auth/data/fake_auth_repository.dart';
import 'package:tryhard_showcase/features/auth/domain/auth_cubit/auth_cubit.dart';
import 'package:tryhard_showcase/features/profile/data/remote/fake_user_repository.dart';
import 'package:tryhard_showcase/features/profile/data/remote/user_repository.dart';

import '../../../storage/fake_storage.dart';

void main() {
  late AuthRepository authRepository;
  late UserRepository userRepository;

  const String userGuid = "123456789010111213";
  const String inputEmail = "test@test.com";
  const String inputPassword = "12345";

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
    initHydratedStorage();
    authRepository = FakeAuthRepository();
    userRepository = FakeUserRepository();
  });

  group('AuthCubit', () {
    test('initial state is not Authorized ', () {
      expect(AuthCubit(authRepository, userRepository).state,
          AuthNotAuthorizedState());
    });

    group('call login from auth repository', () {
      blocTest<AuthCubit, AuthState>(
        'user successfully passed auth',
        setUp: () {
          when(
            () => authRepository.login(
                email: inputEmail, password: inputPassword),
          ).thenAnswer((_) async {
            return authUser;
          });
        },
        build: () => AuthCubit(authRepository, userRepository),
        act: (cubit) => cubit.logIn(email: inputEmail, password: inputPassword),
        expect: () => <AuthState>[
          AuthAuthorizedState(user: authUser),
        ],
      );

      blocTest<AuthCubit, AuthState>(
        'login returns an exception, state is not Authorized',
        setUp: () {
          when(
            () => authRepository.login(
                email: inputEmail, password: inputPassword),
          ).thenThrow(authException);
        },
        build: () => AuthCubit(authRepository, userRepository),
        act: (cubit) => cubit.logIn(email: inputEmail, password: inputPassword),
        expect: () => <AuthState>[
          AuthNotAuthorizedState(),
        ],
        errors: () => <AuthException>[
          authException,
        ],
      );
    });

    group('call register from auth repository', () {
      blocTest<AuthCubit, AuthState>(
        'user successfully passed register auth',
        setUp: () {
          when(
            () => authRepository.register(
              email: inputEmail,
              password: inputPassword,
            ),
          ).thenAnswer((_) async {
            return authUser;
          });
          when(
            () => userRepository.createUserProfile(
              userBasicInfo: userBasicInfo,
            ),
          ).thenAnswer((_) async {});
        },
        build: () => AuthCubit(authRepository, userRepository),
        act: (cubit) => cubit.register(
          email: inputEmail,
          password: inputPassword,
        ),
        expect: () => <AuthState>[
          AuthAuthorizedState(user: authUser),
        ],
      );

      blocTest<AuthCubit, AuthState>(
        'auth api returns an exception state stays as not authorized',
        setUp: () {
          when(
            () => authRepository.register(
                email: inputEmail, password: inputPassword),
          ).thenThrow(authException);
        },
        build: () => AuthCubit(authRepository, userRepository),
        act: (cubit) =>
            cubit.register(email: inputEmail, password: inputPassword),
        expect: () => <AuthState>[
          AuthNotAuthorizedState(),
        ],
        errors: () => <Exception>[
          authException,
        ],
      );

      blocTest<AuthCubit, AuthState>(
        'creating user method returns an exception state stays as not authorized',
        setUp: () {
          when(
            () => authRepository.register(
              email: inputEmail,
              password: inputPassword,
            ),
          ).thenAnswer((_) async {
            return authUser;
          });
          when(
            () => userRepository.createUserProfile(
              userBasicInfo: userBasicInfo,
            ),
          ).thenThrow(dbException);
        },
        build: () => AuthCubit(authRepository, userRepository),
        act: (cubit) =>
            cubit.register(email: inputEmail, password: inputPassword),
        errors: () => <Exception>[
          dbException,
        ],
      );
    });

    group('call google log in from auth repository', () {
      blocTest<AuthCubit, AuthState>(
        'user successfully logged in',
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
        build: () => AuthCubit(authRepository, userRepository),
        act: (cubit) => cubit.onGoogleSignIn(),
        expect: () => <AuthState>[
          AuthAuthorizedState(user: authUser),
        ],
      );

      blocTest<AuthCubit, AuthState>(
        'auth api returns an exception state stays as not Authorized',
        setUp: () {
          when(
            () => authRepository.googleLogIn(),
          ).thenThrow(authException);
        },
        build: () => AuthCubit(authRepository, userRepository),
        act: (cubit) => cubit.onGoogleSignIn(),
        expect: () => <AuthState>[
          AuthNotAuthorizedState(),
        ],
        errors: () => <Exception>[
          authException,
        ],
      );

      blocTest<AuthCubit, AuthState>(
        'creating user method returns an exception state stays as not Authorized',
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
        build: () => AuthCubit(authRepository, userRepository),
        act: (cubit) => cubit.onGoogleSignIn(),
        errors: () => <Exception>[
          dbException,
        ],
      );
    });

    group('call logout from auth repository', () {
      blocTest<AuthCubit, AuthState>(
        'user successfully logged out',
        setUp: () {
          when(
            () => authRepository.logout(),
          ).thenAnswer((_) async {
            return;
          });
        },
        build: () => AuthCubit(authRepository, userRepository),
        act: (cubit) => cubit.logout(),
        expect: () => <AuthState>[
          AuthNotAuthorizedState(),
        ],
      );

      blocTest<AuthCubit, AuthState>(
        'logout returns an AuthException error, state will become as not Authorized',
        setUp: () {
          when(
            () => authRepository.logout(),
          ).thenThrow(authException);
        },
        build: () => AuthCubit(authRepository, userRepository),
        act: (cubit) => cubit.logout(),
        expect: () => <AuthState>[
          AuthErrorState(message: authException.message),
          AuthNotAuthorizedState(),
        ],
      );
    });
  });
}
