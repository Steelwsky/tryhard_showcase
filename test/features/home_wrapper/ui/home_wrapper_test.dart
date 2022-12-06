import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tryhard_showcase/app/data/auth/models/auth_user/auth_user.dart';
import 'package:tryhard_showcase/app/data/datasource/models/user.dart';
import 'package:tryhard_showcase/app/di/di.dart';
import 'package:tryhard_showcase/features/auth/data/auth_repository.dart';
import 'package:tryhard_showcase/features/profile/data/user_repository.dart';

import '../../../fake_storage.dart';
import 'home_wrapper_support_test.dart';

void main() {
  const String userGuid = '123456789101112';
  const String email = 'test@test.com';

  const AuthUser authUser = AuthUser(
    userGuid: userGuid,
    email: email,
  );

  final UserProfile userProfile = UserProfile(
    guid: userGuid,
    email: email,
    searchId: userGuid.substring(0, 12),
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
      () => sl<AuthRepository>().getCurrentUserId(),
    ).thenAnswer((_) => userGuid);
    when(
      () => sl<UserRepository>().getUserProfile(
        userGuid: userGuid,
      ),
    ).thenAnswer((_) async => userProfile);
  });

  tearDown(() {
    sl.reset(dispose: true);
  });

  group('HomeWrapper', () {
    testWidgets(
      'The home wrapper is found after pumping up',
      harness((given, when, then) async {
        await given.widgetIsPumped(authUser);
        await then.widgetIsFound();
      }),
    );

    testWidgets(
      'Overview screen is found when bottom nav bar item with index 0 is tapped',
      harness((given, when, then) async {
        await given.widgetIsPumped(authUser);
        await when.bottomNavBarItemIsTapped(index: 0);
        await then.findOverviewScreen();
      }),
    );

    testWidgets(
      'Info screen is found when bottom nav bar item with index 1 is tapped',
      harness((given, when, then) async {
        await given.widgetIsPumped(authUser);
        await when.bottomNavBarItemIsTapped(index: 1);
        await then.findInfoScreen();
      }),
    );
  });
}
