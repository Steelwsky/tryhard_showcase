import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:given_when_then/given_when_then.dart';
import 'package:tryhard_showcase/app/constants/keys.dart';
import 'package:tryhard_showcase/app/data/auth/models/auth_user/auth_user.dart';
import 'package:tryhard_showcase/app/di/di.dart';
import 'package:tryhard_showcase/features/auth/data/auth_repository.dart';
import 'package:tryhard_showcase/features/auth/domain/auth_cubit/auth_cubit.dart';
import 'package:tryhard_showcase/features/home_wrapper/domain/home_cubit/home_cubit.dart';
import 'package:tryhard_showcase/features/home_wrapper/ui/home_wrapper.dart';
import 'package:tryhard_showcase/features/profile/data/user_repository.dart';
import 'package:tryhard_showcase/features/profile/domain/profile_cubit.dart';

Future<void> Function(WidgetTester) harness(
    WidgetTestHarnessCallback<HomeWrapperWidgetTestHarness> callback) {
  return (tester) =>
      givenWhenThenWidgetTest(HomeWrapperWidgetTestHarness(tester), callback);
}

class HomeWrapperWidgetTestHarness extends WidgetTestHarness {
  HomeWrapperWidgetTestHarness(WidgetTester tester) : super(tester);

  final homeWrapperCubit = HomeWrapperCubit();
  final profileCubit = ProfileCubit(
    sl<AuthRepository>(),
    sl<UserRepository>(),
    sl<AuthCubit>(),
  );
}

extension ExampleGiven on WidgetTestGiven<HomeWrapperWidgetTestHarness> {
  Future<void> widgetIsPumped(AuthUser authUser) async {
    await tester.pumpWidget(
      _TestHomeWrapperWidget(
        profileCubit: this.harness.profileCubit,
        homeWrapperCubit: this.harness.homeWrapperCubit,
      ),
    );
  }
}

extension ExampleWhen on WidgetTestWhen<HomeWrapperWidgetTestHarness> {
  Future<void> bottomNavBarItemIsTapped({required int index}) async {
    await tester.tap(find
        .byIcon(this.harness.homeWrapperCubit.state.tabs[index].icon!.icon!));
  }
}

extension ExampleThen on WidgetTestThen<HomeWrapperWidgetTestHarness> {
  Future<void> widgetIsFound() async {
    await tester.pump();
    expect(find.byType(HomeScreenWrapper), findsOneWidget);
  }

  Future<void> findOverviewScreen() async {
    await tester.pump();
    expect(find.byKey(kOverviewScreen), findsOneWidget);
  }

  Future<void> findInfoScreen() async {
    await tester.pump();
    expect(find.byKey(kInfoScreen), findsOneWidget);
  }
}

class _TestHomeWrapperWidget extends StatelessWidget {
  const _TestHomeWrapperWidget({
    Key? key,
    required this.profileCubit,
    required this.homeWrapperCubit,
  }) : super(key: key);
  final ProfileCubit profileCubit;
  final HomeWrapperCubit homeWrapperCubit;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MultiBlocProvider(
          providers: [
            BlocProvider.value(value: profileCubit),
            BlocProvider.value(value: homeWrapperCubit),
          ],
          child: const HomeScreenWrapper(),
        ),
      ),
    );
  }
}
