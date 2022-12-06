import 'package:flutter/material.dart';
import 'package:tryhard_showcase/data/repositories/auth/auth_repository.dart';
import 'package:tryhard_showcase/data/repositories/user/user_repository.dart';
import 'package:tryhard_showcase/ui/home/controllers/home_controller.dart';
import 'package:tryhard_showcase/ui/home/models/tabs.dart';
import 'package:tryhard_showcase/ui/info/views/info.dart';
import 'package:tryhard_showcase/ui/profile/overview/controllers/overview_controller.dart';
import 'package:tryhard_showcase/ui/profile/overview/views/overview.dart';
import 'package:tryhard_showcase/ui/toast/controllers/toast_controller.dart';

import 'home_wrapper.dart';

class HomeScreenDependencies extends StatefulWidget {
  const HomeScreenDependencies({
    Key? key,
    required this.authRepository,
    required this.userRepository,
    required this.toastController,
  }) : super(key: key);
  final AuthRepository authRepository;
  final UserRepository userRepository;
  final ToastController toastController;

  @override
  State<HomeScreenDependencies> createState() => _HomeScreenDependenciesState();
}

class _HomeScreenDependenciesState extends State<HomeScreenDependencies> {
  late final AuthRepository authRepository;
  late final UserRepository userRepository;

  late final ToastController toastController;

  late final HomeWrapperController homeWrapperController;
  late final ProfileOverviewController profileOverviewController;

  @override
  void initState() {
    super.initState();

    authRepository = widget.authRepository;
    userRepository = widget.userRepository;
    toastController = widget.toastController;

    profileOverviewController = RealProfileOverviewController(
      auth: authRepository,
      userRepository: userRepository,
      toastController: toastController,
    );

    const int initPage = 0;
    final List<BottomNavBarItemModel> tabs = BottomNavBarItems().tabs;
    final pages = [
      ProfileOverviewScreen(
        profileOverviewController: profileOverviewController,
      ),
      const InfoScreen(),
    ];

    homeWrapperController = RealHomeWrapperController(
      page: initPage,
      pages: pages,
      tabs: tabs,
    );
  }

  @override
  void dispose() {
    profileOverviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HomeScreenWrapper(
      homeWrapperController: homeWrapperController,
    );
  }
}
