import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:given_when_then/given_when_then.dart';
import 'package:tryhard_showcase/app/constants/keys.dart';
import 'package:tryhard_showcase/app/di/di.dart';
import 'package:tryhard_showcase/app/ui/components/avatar.dart';
import 'package:tryhard_showcase/features/auth/data/auth_repository.dart';
import 'package:tryhard_showcase/features/auth/domain/auth_cubit/auth_cubit.dart';
import 'package:tryhard_showcase/features/home_wrapper/domain/home_cubit/home_cubit.dart';
import 'package:tryhard_showcase/features/profile/data/user_repository.dart';
import 'package:tryhard_showcase/features/profile/domain/profile_cubit.dart';
import 'package:tryhard_showcase/features/profile/ui/profile.dart';

Future<void> Function(WidgetTester) harness(
    WidgetTestHarnessCallback<ProfileOverviewWidgetTestHarness> callback) {
  return (tester) => givenWhenThenWidgetTest(
      ProfileOverviewWidgetTestHarness(tester), callback);
}

class ProfileOverviewWidgetTestHarness extends WidgetTestHarness {
  ProfileOverviewWidgetTestHarness(WidgetTester tester) : super(tester);

  final homeWrapperCubit = HomeWrapperCubit();
  final profileCubit = ProfileCubit(
    sl<AuthRepository>(),
    sl<UserRepository>(),
    sl<AuthCubit>(),
  );
}

extension ExampleGiven on WidgetTestGiven<ProfileOverviewWidgetTestHarness> {
  Future<void> widgetIsPumped() async {
    await tester.pumpWidget(_TestProfileOverviewScreen(
      profileCubit: this.harness.profileCubit,
    ));
  }
}

extension ExampleWhen on WidgetTestWhen<ProfileOverviewWidgetTestHarness> {
  void loadUserProfile(String userGuid) {
    this.harness.profileCubit.loadUserProfile(userGuid);
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

  Future<void> findInitialProfileOverview() async {
    await tester.pump();
    expect(find.byKey(kOverviewFormInitial), findsOneWidget);
  }

  Future<void> findUserLoadedOverview() async {
    await tester.pump();
    await tester.pump();
    expect(find.byKey(kOverviewForm), findsOneWidget);
    expect(find.byType(UserAvatar), findsOneWidget);
    expect(find.byKey(kLogoutButton), findsOneWidget);
  }
}

class _TestProfileOverviewScreen extends StatelessWidget {
  const _TestProfileOverviewScreen({
    Key? key,
    required this.profileCubit,
  }) : super(key: key);

  final ProfileCubit profileCubit;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MultiBlocProvider(
          providers: [
            BlocProvider.value(value: profileCubit),
          ],
          child: const ProfileOverviewScreen(),
        ),
      ),
    );
  }
}
