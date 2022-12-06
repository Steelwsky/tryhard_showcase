import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tryhard_showcase/app/data/auth/models/auth_exception.dart';
import 'package:tryhard_showcase/app/data/datasource/models/exception.dart';
import 'package:tryhard_showcase/app/data/datasource/models/user.dart';
import 'package:tryhard_showcase/features/auth/data/auth_repository.dart';
import 'package:tryhard_showcase/features/auth/data/fake_auth_repository.dart';
import 'package:tryhard_showcase/features/auth/domain/auth_cubit/auth_cubit.dart';
import 'package:tryhard_showcase/features/profile/data/fake_user_repository.dart';
import 'package:tryhard_showcase/features/profile/data/user_repository.dart';
import 'package:tryhard_showcase/features/profile/domain/profile_cubit.dart';

import '../../../fake_storage.dart';

void main() {
  late AuthRepository authRepository;
  late UserRepository userRepository;
  late AuthCubit authCubit;

  const String userGuid = '1234567890';
  final UserProfile userProfile = UserProfile(
    guid: userGuid,
    email: "test@test.com",
    searchId: '1234567',
  );
  final ApiException dbException =
      ApiException(code: 'code', description: 'description');
  final AuthException authException =
      AuthException(code: 'code', message: 'description');

  setUp(() {
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

  group('ProfileCubit', () {
    test('profile state is initial', () {
      expect(
          ProfileCubit(
            authRepository,
            userRepository,
            authCubit,
          ).state,
          ProfileState.initial());
    });

    group('load user profile', () {
      blocTest(
        'An error occurred on loading user profile',
        setUp: () {
          when(
            () => userRepository.getUserProfile(userGuid: userGuid),
          ).thenThrow(dbException);
        },
        build: () => ProfileCubit(
          authRepository,
          userRepository,
          authCubit,
        ),
        act: (cubit) => cubit.loadUserProfile(userGuid),
        expect: () => <ProfileState>[
          ProfileState.loading(),
          ProfileState.error(null, dbException.description),
        ],
      );

      blocTest(
        'User profile successfully loaded',
        setUp: () {
          when(
            () => userRepository.getUserProfile(userGuid: userGuid),
          ).thenAnswer((_) async {
            return userProfile;
          });
        },
        build: () => ProfileCubit(
          authRepository,
          userRepository,
          authCubit,
        ),
        act: (cubit) => cubit.loadUserProfile(userGuid),
        expect: () => <ProfileState>[
          ProfileState.loading(),
          ProfileState.loaded(userProfile),
        ],
      );
    });

    group('logout', () {
      blocTest(
        'An error occurred on attempting to logout',
        setUp: () {
          when(
            () => authRepository.logout(),
          ).thenThrow(authException);
        },
        seed: () => ProfileState.loaded(userProfile),
        build: () => ProfileCubit(
          authRepository,
          userRepository,
          authCubit,
        ),
        act: (cubit) => cubit.logout(),
        expect: () => <ProfileState>[
          ProfileState.error(userProfile, authException.message),
        ],
      );

      blocTest(
        'User successfully logouts',
        setUp: () {
          when(
            () => authRepository.logout(),
          ).thenAnswer((_) async {});
        },
        build: () => ProfileCubit(
          authRepository,
          userRepository,
          authCubit,
        ),
        act: (cubit) => cubit.logout(),
        expect: () => <ProfileState>[
          ProfileState.initial(),
        ],
      );
    });
  });
}
