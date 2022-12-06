import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tryhard_showcase/app/data/datasource/models/exception.dart';
import 'package:tryhard_showcase/app/data/datasource/models/user.dart';
import 'package:tryhard_showcase/app/di/di.dart';
import 'package:tryhard_showcase/features/profile/data/user_repository.dart';

import '../../../fake_storage.dart';
import 'support_test.dart';

void main() {
  const String userGuid = '123456789101112';
  const String exceptionCaseUserGuid = '11111';
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

  setUp(() async {
    late Storage storage;
    storage = FakeStorage();
    when(() => storage.write(any(), any<dynamic>())).thenAnswer((_) async {});
    when<dynamic>(() => storage.read(any())).thenReturn(<String, dynamic>{});
    when(() => storage.delete(any())).thenAnswer((_) async {});
    when(() => storage.clear()).thenAnswer((_) async {});

    HydratedBloc.storage = storage;

    await initDi("test");

    when(
      () => sl<UserRepository>().getUserProfile(
        userGuid: userGuid,
      ),
    ).thenAnswer((_) async {
      return userProfile;
    });

    when(
      () => sl<UserRepository>().getUserProfile(
        userGuid: exceptionCaseUserGuid,
      ),
    ).thenThrow(dbException);
  });

  tearDown(() {
    sl.reset(dispose: true);
  });

  group('testing overview screen', () {
    group('loading user profile', () {
      testWidgets(
        'widget is pumped',
        harness((given, when, then) async {
          await given.widgetIsPumped();
          await then.findOverviewScreen();
        }),
      );

      testWidgets(
        'should show an initial overview form before loading user profile',
        harness((given, when, then) async {
          await given.widgetIsPumped();
          await then.findInitialProfileOverview();
        }),
      );

      testWidgets(
        'should show a loaded user overview',
        harness((given, when, then) async {
          await given.widgetIsPumped();

          when.loadUserProfile(userGuid);

          then.findUserLoadedOverview();
        }),
      );

      testWidgets(
        'should be no overview screen if getting user data api returns an error',
        harness((given, when, then) async {
          await given.widgetIsPumped();

          when.loadUserProfile(exceptionCaseUserGuid);

          await then.findInitialProfileOverview();
        }),
      );
    });
  });
}
