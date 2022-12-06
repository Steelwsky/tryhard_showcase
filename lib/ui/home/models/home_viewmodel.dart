import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'tabs.dart';

class HomeWrapperViewModel extends Equatable {
  static const initPage = 0;

  final int page;
  final List<Widget> pages;
  final List<BottomNavBarItemModel> tabs;

  const HomeWrapperViewModel._({
    required this.page,
    required this.pages,
    required this.tabs,
  });

  const HomeWrapperViewModel.data({
    required this.page,
    required this.pages,
    required this.tabs,
  });

  HomeWrapperViewModel.initial()
      : page = initPage,
        pages = [],
        tabs = [];

  HomeWrapperViewModel changePage({
    int? page,
  }) {
    return HomeWrapperViewModel._(
      page: page ?? this.page,
      pages: pages,
      tabs: tabs,
    );
  }

  @override
  List<Object?> get props => [
        page,
        pages,
        tabs,
      ];
}
