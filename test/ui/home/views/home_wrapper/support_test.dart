import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:given_when_then/given_when_then.dart';
import 'package:tryhard_showcase/ui/home/controllers/home_controller.dart';
import 'package:tryhard_showcase/ui/home/models/tabs.dart';
import 'package:tryhard_showcase/ui/home/views/home_wrapper.dart';

Future<void> Function(WidgetTester) harness(
    WidgetTestHarnessCallback<HomeWrapperWidgetTestHarness> callback) {
  return (tester) => givenWhenThenWidgetTest(HomeWrapperWidgetTestHarness(tester), callback);
}

class HomeWrapperWidgetTestHarness extends WidgetTestHarness {
  HomeWrapperWidgetTestHarness(WidgetTester tester) : super(tester);

  final fake0 = 0;
  final fake1 = 1;
  final tabs = BottomNavBarItems().tabs;

  late final pages = [
    _FakeScreen(index: fake0),
    _FakeScreen(index: fake1),
  ];

  late final homeWrapperController = RealHomeWrapperController(
    page: 0,
    pages: pages,
    tabs: tabs,
  );
}

extension ExampleGiven on WidgetTestGiven<HomeWrapperWidgetTestHarness> {
  Future<void> widgetIsPumped() async {
    await tester.pumpWidget(
      _TestHomeWrapperWidget(
        homeWrapperController: this.harness.homeWrapperController,
      ),
    );
  }
}

extension ExampleWhen on WidgetTestWhen<HomeWrapperWidgetTestHarness> {
  Future<void> bottomNavBarItemIsTapped({required int index}) async {
    await tester.tap(find.byIcon(this.harness.tabs[index].icon!.icon!));
  }
}

extension ExampleThen on WidgetTestThen<HomeWrapperWidgetTestHarness> {
  Future<void> widgetIsFound() async {
    await tester.pump();
    expect(find.byType(HomeScreenWrapper), findsOneWidget);
  }

  Future<void> findScreenWithIndex(int index) async {
    await tester.pump();
    expect(find.byKey(ValueKey(index)), findsOneWidget);
  }
}

class _TestHomeWrapperWidget extends StatelessWidget {
  const _TestHomeWrapperWidget({
    Key? key,
    required this.homeWrapperController,
  }) : super(key: key);

  final HomeWrapperController homeWrapperController;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreenWrapper(
        homeWrapperController: homeWrapperController,
      ),
    );
  }
}

class _FakeScreen extends StatelessWidget {
  const _FakeScreen({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ValueKey(index),
      body: Center(
        child: Text(index.toString()),
      ),
    );
  }
}
