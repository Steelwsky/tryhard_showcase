import 'package:flutter_test/flutter_test.dart';
import 'package:tryhard_showcase/data/api/auth/models/auth_user.dart';
import 'package:tryhard_showcase/data/api/datasource/models/exception.dart';
import 'package:uuid/uuid.dart';

import 'support_test.dart';

void main() {
  group('testing overview screen', () {
    testWidgets(
      'widget is pumped',
      harness((given, when, then) async {
        await given.widgetIsPumped();
        await then.findOverviewScreen();
      }),
    );

    testWidgets(
      'should show a circular progress indicator when widget is just pumped up',
      harness((given, when, then) async {
        await given.widgetIsPumped();
        await then.findCircularProgressIndicator();
      }),
    );

    testWidgets(
      'should show a circular progress indicator if the user is null',
      harness((given, when, then) async {
        await given.widgetIsPumped();
        await given.setFakeUserTo(null);
        await then.findCircularProgressIndicator();
      }),
    );

    testWidgets(
      'should show a circular progress indicator if user data is loading',
      harness((given, when, then) async {
        final user = AuthUser(userGuid: const Uuid().v4(), email: 'abc@test.com');
        await given.widgetIsPumped();
        await given.setFakeUserTo(user);
        when.userProfileIsLoading();

        await then.findCircularProgressIndicator();
      }),
    );

    testWidgets(
      'should show user form overview screen when data is loaded',
      harness((given, when, then) async {
        final user = AuthUser(userGuid: const Uuid().v4(), email: 'abc@test.com');

        await given.widgetIsPumped();
        await given.setFakeUserTo(user);
        when.userProfileIsLoading();

        when.getCurrentUserProfile();
        when.userProfileCompletesSuccessfully(user.userGuid!);

        await then.findUserLoadedOverview();
      }),
    );

    testWidgets(
      'should be no overview screen if getting user data api returns an error',
      harness((given, when, then) async {
        final user = AuthUser(userGuid: const Uuid().v4(), email: 'abc@test.com');
        final exception = ApiException(
          code: 'code',
          description: 'load user data error',
        );

        await given.widgetIsPumped();
        await given.setFakeUserTo(user);
        when.userProfileIsLoading();

        when.getCurrentUserProfile();
        when.userProfileCompletesWithException(
          userGuid: user.userGuid!,
          exception: exception,
        );

        await Future.microtask(() {});

        await then.findUserLoadedOverview();
      }),
    );
  });
}
