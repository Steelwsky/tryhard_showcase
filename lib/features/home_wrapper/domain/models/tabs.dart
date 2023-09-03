import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:tryhard_showcase/app/constants/keys.dart';

class BottomNavBarProps {
  final int initialTab;
  final List<BottomNavBarItemModel> tabs;

  BottomNavBarProps({
    required this.initialTab,
    required this.tabs,
  });
}

class BottomNavBarItemModel {
  BottomNavBarItemModel({
    this.name,
    this.icon,
  });

  final String? name;
  final Icon? icon;
}

class BottomNavBarItems {
  BottomNavBarItems() {
    _tabs = [
      BottomNavBarItemModel(
        name: 'Stopwatch',
        icon: const Icon(
          Icons.timer,
          key: kBottomNavBarStopwatchItem,
        ),
      ),
      BottomNavBarItemModel(
        name: 'Profile',
        icon: const Icon(
          Icons.person,
          key: kBottomNavBarProfileItem,
        ),
      ),
      BottomNavBarItemModel(
        name: 'Info',
        icon: const Icon(
          Icons.info,
          key: kBottomNavBarInfoItem,
        ),
      ),
    ];
  }

  late List<BottomNavBarItemModel> _tabs;

  UnmodifiableListView<BottomNavBarItemModel> get tabs => UnmodifiableListView(_tabs);
}
