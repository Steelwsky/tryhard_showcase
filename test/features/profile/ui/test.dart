import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tryhard_showcase/app/data/datasource/models/exception.dart';
import 'package:tryhard_showcase/app/data/datasource/models/user.dart';
import 'package:tryhard_showcase/app/di/di.dart';
import 'package:tryhard_showcase/features/auth/data/auth_repository.dart';
import 'package:tryhard_showcase/features/profile/domain/interactor/user_interactor.dart';

import '../../../storage/fake_storage.dart';
import 'support.dart';

void main() {
  const String userGuid = '123456789101112';
  const String email = 'test@test.com';

  final UserProfile userProfile = UserProfile(
    guid: userGuid,
    email: email,
    searchId: userGuid.substring(0, 12),
  );

  final ApiException dbException = ApiException(
    code: 'code',
    description: 'description',
  );

  setUpAll(() async {
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

  group('testing overview screen', () {
    group('loading user profile', () {
      testWidgets(
        'screen widget is pumped',
        harness((given, when, then) async {
          await given.screenWidgetIsPumped();
          await then.findOverviewScreen();
        }),
      );

      testWidgets(
        'should show an initial overview form before loading user profile',
        harness((given, when, then) async {
          await given.userProfileStateAsInitial();
          await given.contentWidgetIsPumped();
          await then.findInitialProfileOverview();
        }),
      );

      testWidgets(
        'should show a loading user overview',
        harness((given, _, then) async {
          await given.userProfileStateAsLoading();
          await given.contentWidgetIsPumped();
          then.findCircularProgressIndicator();
        }),
      );

      testWidgets(
        'should show a loaded user overview with user profile',
        harness((given, _, then) async {
          await given.userProfileStateAsLoadedWith(userProfile);
          await given.contentWidgetIsPumped();
          then.findUserLoadedOverview();
        }),
      );

      testWidgets(
        'should be an initial profile overview if getting user data api returns an error '
        'and userProfile was null before fetching',
        harness((given, when, then) async {
          await given.userProfileStateAsError(
            userProfile: null,
            error: dbException.description,
          );
          await given.contentWidgetIsPumped();
          await then.findInitialProfileOverview();
        }),
      );

      testWidgets(
        'should be an overview screen if getting user data api returns an error '
        'and userProfile was not null before fetching',
        harness((given, when, then) async {
          await given.userProfileStateAsError(
            userProfile: userProfile,
            error: dbException.description,
          );
          await given.contentWidgetIsPumped();
          await then.findProfileOverview();
        }),
      );
    });
  });
}
