import 'package:flutter_test/flutter_test.dart';
import 'package:tryhard_showcase/data/api/auth/models/auth_exception.dart';
import 'package:tryhard_showcase/data/api/auth/models/auth_user.dart';
import 'package:tryhard_showcase/data/api/datasource/models/exception.dart';
import 'package:uuid/uuid.dart';

import 'support_test.dart';

void main() {
  group('testing profile overview controller', () {
    group('testing logout', () {
      test(
        'should be a toast if logout api call returns an exception',
        harness((given, when, then) async {
          final user = AuthUser(userGuid: const Uuid().v4());
          given.fakeLoggedUserIs(user);
          when.userLogouts();
          when.logoutCompletesWithAnException(
            exception: AuthException(
              code: 'code',
              message: 'logout error',
            ),
          );
          then.toastMessageIs('logout error');
        }),
      );

      test(
        'should be no toast message if logout api call is successful',
        harness((given, when, then) async {
          final user = AuthUser(userGuid: const Uuid().v4());
          given.fakeLoggedUserIs(user);
          when.userLogouts();
          when.logoutCompletesSuccessfully();
          then.toastMessageIs(null);
        }),
      );
    });

    group('testing loading user profile', () {
      test(
        'should be a toast if loading user profile api call returns an exception',
        harness((given, when, then) async {
          final user = AuthUser(userGuid: const Uuid().v4(), email: 'abc@test.com');
          given.fakeLoggedUserIs(user);

          when.loadUserProfile();
          when.loadUserProfileCompletesWithAnException(
            userGuid: user.userGuid!,
            exception: ApiException(
              code: 'code',
              description: 'user profile error',
            ),
          );

          then.toastMessageIs('user profile error');
        }),
      );

      test(
        'should be no toast error message if loading user profile was is successful',
        harness((given, when, then) async {
          final user = AuthUser(userGuid: const Uuid().v4(), email: 'abc@test.com');
          given.fakeLoggedUserIs(user);

          when.loadUserProfile();
          when.loadUserProfileCompletesSuccessfully(user.userGuid!);

          then.toastMessageIs(null);
        }),
      );
    });
  });
}
