import 'package:flutter_test/flutter_test.dart';
import 'package:given_when_then/given_when_then.dart';
import 'package:tryhard_showcase/data/api/auth/models/auth_user.dart';
import 'package:tryhard_showcase/data/repositories/user/models/user.dart';
import 'package:tryhard_showcase/ui/profile/overview/controllers/overview_controller.dart';
import 'package:tryhard_showcase/ui/toast/controllers/toast_controller.dart';

import '../../../../../data/repositories/fake_auth_repository.dart';
import '../../../../../data/repositories/fake_user_repository.dart';

Future<void> Function() harness(UnitTestHarnessCallback<ProfileOverviewTestHarness> callback) {
  return () => givenWhenThenUnitTest(ProfileOverviewTestHarness(), callback);
}

class ProfileOverviewTestHarness {
  ProfileOverviewTestHarness() : super();

  final auth = FakeAuthRepository();
  final userRepository = FakeUserRepository();
  final toastController = FakeToastController();

  late final profileOverviewController = RealProfileOverviewController(
    auth: auth,
    userRepository: userRepository,
    toastController: toastController,
  );
}

extension ExampleGiven on UnitTestGiven<ProfileOverviewTestHarness> {
  void fakeLoggedUserIs(AuthUser? user) {
    this.harness.auth.setFakeUser(user);
    this.harness.userRepository.setFakeUser(
          UserProfile(
            guid: user!.userGuid!,
            email: user.email,
            searchId: user.userGuid!.substring(0, 12),
          ),
        );
  }
}

extension ExampleWhen on UnitTestWhen<ProfileOverviewTestHarness> {
  Future<void> userLogouts() {
    return this.harness.profileOverviewController.logout();
  }

  void logoutCompletesSuccessfully() {
    this.harness.auth.authLogoutCompleters.single.complete();
  }

  void logoutCompletesWithAnException({required Exception exception}) {
    this.harness.auth.authLogoutCompleters.single.completeError(exception);
  }

  Future<void> loadUserProfile() {
    return this.harness.profileOverviewController.loadUserProfile();
  }

  void loadUserProfileCompletesSuccessfully(String userGuid) {
    this.harness.userRepository.getUserProfileCompleters[userGuid]?.last.complete();
  }

  void loadUserProfileCompletesWithAnException({
    required String userGuid,
    required Exception exception,
  }) {
    this.harness.userRepository.getUserProfileCompleters[userGuid]?.last.completeError(exception);
  }
}

extension ExampleThen on UnitTestThen<ProfileOverviewTestHarness> {
  void toastMessageIs(String? msg) async {
    await Future.microtask(() {});
    expect(this.harness.toastController.msg, equals(msg));
  }
}

class FakeToastController implements ToastController {
  String? msg;

  @override
  void dispose() {}

  @override
  void setMessage(String message) {
    msg = message;
  }
}
