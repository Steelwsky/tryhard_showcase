import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tryhard_showcase/app/data/datasource/models/user.dart';
import 'package:tryhard_showcase/app/di/di.dart';
import 'package:tryhard_showcase/features/auth/data/auth_repository.dart';
import 'package:tryhard_showcase/features/profile/domain/interactor/user_interactor.dart';

import '../../../storage/fake_storage.dart';
import 'home_wrapper_support.dart';

void main() {
  const String userGuid = '123456789101112';
  const String email = 'test@test.com';

  const index0 = 0;
  const index1 = 1;
  const index2 = 2;

  const listIndexes = [index0, index1, index2];

  final UserProfile userProfile = UserProfile(
    guid: userGuid,
    email: email,
    searchId: userGuid.substring(0, 12),
  );

  setUp(() async {
    initHydratedStorage();

    await initDi("test");

    when(
      () => sl<AuthRepository>().getCurrentUserId(),
    ).thenAnswer((_) => userGuid);
    when(
      () => sl<UserInteractor>().getUserProfile(userGuid: userGuid),
    ).thenAnswer((_) async {
      return userProfile;
    });
  });

  tearDown(() {
    sl.reset(dispose: true);
  });

  group('HomeWrapper', () {
    testWidgets(
      'The home wrapper is found after pumping up',
      harness((given, when, then) async {
        await given.userHomeWrapperStateAsInitial();
        await given.widgetIsPumped();
        await then.homeScreenWrapperWidgetIsFound();
      }),
    );
  });

  group('something', () {
    for (int index in listIndexes) {
      testWidgets(
        'Screen with index $index screen is found when info bottom nav bar item with index $index is tapped',
        harness((given, when, then) async {
          await given.userHomeWrapperStateWithPageIndex(index);
          await given.widgetViewIsPumped();
          await when.bottomNavBarItemIsTappedWithIndex(index);
          await then.findScreenWithKeyByIndex(index);
        }),
      );
    }
  });
}
