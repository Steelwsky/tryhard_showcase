import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:given_when_then/given_when_then.dart';
import 'package:tryhard_showcase/data/api/auth/models/auth_user.dart';
import 'package:tryhard_showcase/data/repositories/user/models/user.dart';
import 'package:tryhard_showcase/ui/profile/overview/controllers/overview_controller.dart';
import 'package:tryhard_showcase/ui/profile/overview/views/overview.dart';
import 'package:tryhard_showcase/ui/shared/avatar.dart';
import 'package:tryhard_showcase/ui/toast/controllers/toast_controller.dart';

import '../../../../../data/repositories/fake_auth_repository.dart';
import '../../../../../data/repositories/fake_user_repository.dart';

Future<void> Function(WidgetTester) harness(
    WidgetTestHarnessCallback<ProfileOverviewWidgetTestHarness> callback) {
  return (tester) => givenWhenThenWidgetTest(ProfileOverviewWidgetTestHarness(tester), callback);
}

class ProfileOverviewWidgetTestHarness extends WidgetTestHarness {
  ProfileOverviewWidgetTestHarness(WidgetTester tester) : super(tester);

  final auth = FakeAuthRepository();
  final userRepository = FakeUserRepository();
  final toastController = FakeToastController();

  late final profileOverviewController = RealProfileOverviewController(
    auth: auth,
    userRepository: userRepository,
    toastController: toastController,
  );
}

extension ExampleGiven on WidgetTestGiven<ProfileOverviewWidgetTestHarness> {
  Future<void> widgetIsPumped() async {
    await tester.pumpWidget(
      _TestProfileOverviewScreen(
        profileOverviewController: this.harness.profileOverviewController,
      ),
    );
  }

  Future<void> setFakeUserTo(AuthUser? user) async {
    this.harness.auth.setFakeUser(user);
    final profile = user == null
        ? null
        : UserProfile(
            guid: user.userGuid!,
            email: user.email,
            searchId: user.userGuid!.substring(0, 12),
          );
    this.harness.userRepository.setFakeUser(profile);
  }

  Future<void> userProfileIsLoaded(AuthUser? user) async {
    this.harness.auth.setFakeUser(user);
    final profile = user == null
        ? null
        : UserProfile(
            guid: user.userGuid!,
            email: user.email,
            searchId: user.userGuid!.substring(0, 12),
          );
    this.harness.userRepository.setFakeUser(profile);
  }

  Future<void> viewModelIsSetWithUserData() async {
    return this.harness.profileOverviewController.getCurrentUserProfile();
  }
}

extension ExampleWhen on WidgetTestWhen<ProfileOverviewWidgetTestHarness> {
  void getCurrentUserProfile() {
    return this.harness.profileOverviewController.getCurrentUserProfile();
  }

  Future<void> userProfileIsLoading() {
    return this.harness.profileOverviewController.loadUserProfile();
  }

  void userProfileCompletesSuccessfully(String userGuid) {
    this.harness.userRepository.getUserProfileCompleters[userGuid]!.last.complete();
  }

  void userProfileCompletesWithException({required String userGuid, required Exception exception}) {
    this.harness.userRepository.getUserProfileCompleters[userGuid]!.last.completeError(exception);
  }

  Future<void> userTapsOnLogoutButton() async {
    await tester.pump();
    await tester.tap(find.byType(TextButton));
  }
}

extension ExampleThen on WidgetTestThen<ProfileOverviewWidgetTestHarness> {
  Future<void> findOverviewScreen() async {
    await tester.pump();
    expect(find.byType(ProfileOverviewScreen), findsOneWidget);
  }

  Future<void> findCircularProgressIndicator() async {
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  }

  Future<void> findUserLoadedOverview() async {
    await tester.pump();
    expect(find.byKey(const ValueKey('overviewForm')), findsOneWidget);
    expect(find.byType(UserAvatar), findsOneWidget);
    expect(find.byKey(const ValueKey('logoutButton')), findsOneWidget);
  }
}

class _TestProfileOverviewScreen extends StatelessWidget {
  const _TestProfileOverviewScreen({
    Key? key,
    required this.profileOverviewController,
  }) : super(key: key);
  final ProfileOverviewController profileOverviewController;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfileOverviewScreen(
        profileOverviewController: profileOverviewController,
      ),
    );
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
