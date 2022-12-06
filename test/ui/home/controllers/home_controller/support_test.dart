import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:given_when_then/given_when_then.dart';
import 'package:tryhard_showcase/ui/home/controllers/home_controller.dart';
import 'package:tryhard_showcase/ui/home/models/home_viewmodel.dart';
import 'package:tryhard_showcase/ui/home/models/tabs.dart';

Future<void> Function() harness(UnitTestHarnessCallback<MyControllerTestHarness> callback) {
  return () => givenWhenThenUnitTest(MyControllerTestHarness(), callback);
}

class MyControllerTestHarness {
  MyControllerTestHarness() : super();
  final List<BottomNavBarItemModel> tabs = BottomNavBarItems().tabs;
  final pages = const [
    Placeholder(),
    Placeholder(),
  ];

  late final homeController = RealHomeWrapperController(
    page: 0,
    pages: pages,
    tabs: tabs,
  );
}

extension ExampleGiven on UnitTestGiven<MyControllerTestHarness> {}

extension ExampleWhen on UnitTestWhen<MyControllerTestHarness> {
  void changingPageTo(int index) {
    this.harness.homeController.changePage(index);
  }
}

extension ExampleThen on UnitTestThen<MyControllerTestHarness> {
  void viewModelWouldBeWithPage(int index) {
    expect(
      this.harness.homeController.viewModel.value,
      HomeWrapperViewModel.data(
        page: index,
        pages: this.harness.homeController.viewModel.value.pages,
        tabs: this.harness.homeController.viewModel.value.tabs,
      ),
    );
  }
}
