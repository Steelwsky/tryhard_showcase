import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tryhard_showcase/app/data/datasource/models/exception.dart';
import 'package:tryhard_showcase/app/data/datasource/models/user.dart';
import 'package:tryhard_showcase/features/profile/domain/cubit/profile_cubit.dart';
import 'package:tryhard_showcase/features/profile/domain/interactor/fake_user_interactor.dart';
import 'package:tryhard_showcase/features/profile/domain/interactor/user_interactor.dart';

import '../../../storage/fake_storage.dart';

void main() {
  late UserInteractor userInteractor;

  const String userGuid = '1234567890';
  final UserProfile userProfile = UserProfile(
    guid: userGuid,
    email: "test@test.com",
    searchId: '1234567',
  );
  final ApiException dbException =
      ApiException(code: 'code', description: 'description');

  setUp(() {
    initHydratedStorage();

    userInteractor = FakeUserInteractor();
  });

  group('ProfileCubit', () {
    test('profile state is initial', () {
      expect(
          ProfileCubit(
            userInteractor: userInteractor,
          ).state,
          ProfileState.initial());
    });

    group('load user profile', () {
      blocTest(
        'An error occurred on loading user profile',
        setUp: () {
          when(
            () => userInteractor.getUserProfile(userGuid: userGuid),
          ).thenThrow(dbException);
        },
        build: () => ProfileCubit(
          userInteractor: userInteractor,
        ),
        act: (cubit) => cubit.loadUserProfile(userGuid: userGuid),
        expect: () => <ProfileState>[
          ProfileState.loading(),
          ProfileState.error(null, dbException.description),
        ],
      );

      blocTest(
        'User profile successfully loaded',
        setUp: () {
          when(
            () => userInteractor.getUserProfile(userGuid: userGuid),
          ).thenAnswer((_) async {
            return userProfile;
          });
        },
        build: () => ProfileCubit(
          userInteractor: userInteractor,
        ),
        act: (cubit) => cubit.loadUserProfile(userGuid: userGuid),
        expect: () => <ProfileState>[
          ProfileState.loading(),
          ProfileState.loaded(userProfile),
        ],
      );
    });
  });
}
