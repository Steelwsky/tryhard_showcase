import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:given_when_then/given_when_then.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tryhard_showcase/features/home_wrapper/domain/cubit/home_cubit.dart';
import 'package:tryhard_showcase/features/home_wrapper/domain/models/tabs.dart';
import 'package:tryhard_showcase/features/home_wrapper/ui/home_wrapper.dart';

const _testKey0 = ValueKey('testKey0');
const _testKey1 = ValueKey('testKey1');
const _testKey2 = ValueKey('testKey2');

class MockHomeWrapperCubit extends MockCubit<HomeWrapperState>
    implements HomeWrapperCubit {}

Future<void> Function(WidgetTester) harness(
    WidgetTestHarnessCallback<HomeWrapperWidgetTestHarness> callback) {
  return (tester) =>
      givenWhenThenWidgetTest(HomeWrapperWidgetTestHarness(tester), callback);
}

class HomeWrapperWidgetTestHarness extends WidgetTestHarness {
  HomeWrapperWidgetTestHarness(WidgetTester tester) : super(tester);

  final pages = [
    const _TestPage0(
      key: _testKey0,
    ),
    const _TestPage1(
      key: _testKey1,
    ),
    const _TestPage2(
      key: _testKey2,
    ),
  ];

  final homeWrapperCubit = MockHomeWrapperCubit();
}

extension ExampleGiven on WidgetTestGiven<HomeWrapperWidgetTestHarness> {
  Future<void> userHomeWrapperStateAsInitial() async {
    when(() => this.harness.homeWrapperCubit.state).thenReturn(
      HomeWrapperState(
        page: 0,
        pages: this.harness.pages,
        tabs: BottomNavBarItems().tabs,
      ),
    );
  }

  Future<void> userHomeWrapperStateWithPageIndex(int index) async {
    when(() => this.harness.homeWrapperCubit.state).thenReturn(
      HomeWrapperState(
        page: index,
        pages: this.harness.pages,
        tabs: BottomNavBarItems().tabs,
      ),
    );
  }

  Future<void> widgetIsPumped() async {
    await tester.pumpWidget(
      const MaterialApp(
        home: HomeScreenWrapper(),
      ),
    );
  }

  Future<void> widgetViewIsPumped() async {
    await tester.pumpWidget(
      _TestHomeWrapperWidget(homeWrapperCubit: this.harness.homeWrapperCubit),
    );
  }
}

extension ExampleWhen on WidgetTestWhen<HomeWrapperWidgetTestHarness> {
  Future<void> bottomNavBarItemIsTappedWithIndex(int index) async {
    await tester.tap(
      find.byKey(
        this.harness.homeWrapperCubit.state.tabs[index].icon!.key!,
      ),
    );
  }
}

extension ExampleThen on WidgetTestThen<HomeWrapperWidgetTestHarness> {
  Future<void> homeScreenWrapperWidgetIsFound() async {
    await tester.pump();
    expect(find.byType(HomeScreenWrapper), findsOneWidget);
  }

  Future<void> findScreenWithKey0() async {
    await tester.pump();
    expect(find.byKey(_testKey0), findsOneWidget);
  }

  Future<void> findScreenWithKeyByIndex(int index) async {
    await tester.pump();
    expect(find.byKey(this.harness.pages[index].key!), findsOneWidget);
  }
}

class _TestHomeWrapperWidget extends StatelessWidget {
  const _TestHomeWrapperWidget({required this.homeWrapperCubit});

  final HomeWrapperCubit homeWrapperCubit;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => homeWrapperCubit,
        child: const HomeScreenWrapperView(),
      ),
    );
  }
}

class _TestPage0 extends StatelessWidget {
  const _TestPage0({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _TestPage1 extends StatelessWidget {
  const _TestPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _TestPage2 extends StatelessWidget {
  const _TestPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
