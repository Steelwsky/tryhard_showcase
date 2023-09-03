import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:given_when_then/given_when_then.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tryhard_showcase/app/constants/keys.dart';
import 'package:tryhard_showcase/app/data/datasource/models/user.dart';
import 'package:tryhard_showcase/app/ui/components/avatar.dart';
import 'package:tryhard_showcase/features/auth/domain/auth_cubit/auth_cubit.dart';
import 'package:tryhard_showcase/features/profile/domain/cubit/profile_cubit.dart';
import 'package:tryhard_showcase/features/profile/ui/profile.dart';

class MockProfileCubit extends MockCubit<ProfileState>
    implements ProfileCubit {}

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

Future<void> Function(WidgetTester) harness(
    WidgetTestHarnessCallback<ProfileOverviewWidgetTestHarness> callback) {
  return (tester) => givenWhenThenWidgetTest(
      ProfileOverviewWidgetTestHarness(tester), callback);
}

class ProfileOverviewWidgetTestHarness extends WidgetTestHarness {
  ProfileOverviewWidgetTestHarness(WidgetTester tester) : super(tester);

  final profileCubit = MockProfileCubit();
  final authCubit = MockAuthCubit();
}

extension ExampleGiven on WidgetTestGiven<ProfileOverviewWidgetTestHarness> {
  Future<void> userProfileStateAsInitial() async {
    when(() => this.harness.profileCubit.state)
        .thenReturn(ProfileState.initial());
  }

  Future<void> userProfileStateAsLoading() async {
    when(() => this.harness.profileCubit.state)
        .thenReturn(ProfileState.loading());
  }

  Future<void> userProfileStateAsLoadedWith(UserProfile userProfile) async {
    when(() => this.harness.profileCubit.state)
        .thenReturn(ProfileState.loaded(userProfile));
  }

  Future<void> userProfileStateAsError({
    required UserProfile? userProfile,
    required String error,
  }) async {
    when(() => this.harness.profileCubit.state).thenReturn(
      ProfileState.error(userProfile, error),
    );
  }

  Future<void> screenWidgetIsPumped() async {
    await tester.pumpWidget(
      const _TestProfileOverviewScreen(),
    );
  }

  Future<void> contentWidgetIsPumped() async {
    await tester.pumpWidget(
      _TestProfileContentView(
        authCubit: this.harness.authCubit,
        profileCubit: this.harness.profileCubit,
      ),
    );
  }
}

extension ExampleWhen on WidgetTestWhen<ProfileOverviewWidgetTestHarness> {
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
    await tester.runAsync(() => tester.pump());
    expect(find.byKey(kOverviewFormInitial), findsOneWidget);
  }

  Future<void> findProfileOverview() async {
    await tester.runAsync(() => tester.pump());
    expect(find.byKey(kOverviewForm), findsOneWidget);
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
  const _TestProfileOverviewScreen();

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: ProfileOverviewScreen(),
      ),
    );
  }
}

class _TestProfileContentView extends StatelessWidget {
  const _TestProfileContentView({
    required this.authCubit,
    required this.profileCubit,
  });

  final AuthCubit authCubit;
  final ProfileCubit profileCubit;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MultiBlocProvider(
          providers: [
            BlocProvider.value(value: authCubit),
            BlocProvider.value(value: profileCubit),
          ],
          child: const ProfileContentView(),
        ),
      ),
    );
  }
}
