import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tryhard_showcase/ui/home/models/home_viewmodel.dart';
import 'package:tryhard_showcase/ui/home/models/tabs.dart';

abstract class HomeWrapperController {
  ValueListenable<HomeWrapperViewModel> get viewModel;

  void changePage(int page);
}

class RealHomeWrapperController implements HomeWrapperController {
  RealHomeWrapperController({
    required int page,
    required List<Widget> pages,
    required List<BottomNavBarItemModel> tabs,
  }) {
    _viewModel.value = HomeWrapperViewModel.data(
      page: page,
      pages: pages,
      tabs: tabs,
    );
  }

  final ValueNotifier<HomeWrapperViewModel> _viewModel =
      ValueNotifier(HomeWrapperViewModel.initial());

  @override
  void changePage(int page) {
    _viewModel.value = viewModel.value.changePage(page: page);
  }

  @override
  ValueListenable<HomeWrapperViewModel> get viewModel => _viewModel;
}
