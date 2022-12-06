import 'dart:collection';

import 'package:flutter/material.dart';

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
        name: 'Profile',
        icon: const Icon(
          Icons.person,
        ),
      ),
      BottomNavBarItemModel(
        name: 'Info',
        icon: const Icon(
          Icons.info,
        ),
      ),
    ];
  }

  late List<BottomNavBarItemModel> _tabs;

  UnmodifiableListView<BottomNavBarItemModel> get tabs => UnmodifiableListView(_tabs);
}
