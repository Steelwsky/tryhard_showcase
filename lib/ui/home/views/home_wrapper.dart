import 'package:flutter/material.dart';
import 'package:tryhard_showcase/ui/home/controllers/home_controller.dart';
import 'package:tryhard_showcase/ui/home/models/home_viewmodel.dart';
import 'package:tryhard_showcase/ui/styles/colors.dart';

class HomeScreenWrapper extends StatelessWidget {
  const HomeScreenWrapper({
    Key? key,
    required this.homeWrapperController,
  }) : super(key: key);

  final HomeWrapperController homeWrapperController;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<HomeWrapperViewModel>(
        valueListenable: homeWrapperController.viewModel,
        builder: (context, viewModel, __) {
          return Scaffold(
            body: viewModel.pages[viewModel.page],
            bottomNavigationBar: BottomNavigationBar(
                key: const PageStorageKey('bottomNavBar'),
                selectedItemColor: AppColors.buttonPrimary,
                items: [
                  ...viewModel.tabs.map(
                    (tab) => BottomNavigationBarItem(
                      label: tab.name!,
                      icon: tab.icon!,
                    ),
                  ),
                ],
                currentIndex: viewModel.page,
                onTap: (index) {
                  homeWrapperController.changePage(index);
                }),
          );
        });
  }
}
