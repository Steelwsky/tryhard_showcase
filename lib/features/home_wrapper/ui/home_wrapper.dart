import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryhard_showcase/app/ui/styles/colors.dart';
import 'package:tryhard_showcase/features/home_wrapper/domain/cubit/home_cubit.dart';
import 'package:tryhard_showcase/features/info/ui/info.dart';
import 'package:tryhard_showcase/features/profile/ui/profile.dart';
import 'package:tryhard_showcase/features/stopwatch/ui/stopwatch.dart';

const homePages = [
  StopwatchScreen(),
  ProfileOverviewScreen(),
  InfoScreen(),
];

class HomeScreenWrapper extends StatelessWidget {
  const HomeScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeWrapperCubit(homePages),
      child: const HomeScreenWrapperView(),
    );
  }
}

class HomeScreenWrapperView extends StatelessWidget {
  const HomeScreenWrapperView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeWrapperCubit, HomeWrapperState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: state.pages[state.page],
            bottomNavigationBar: BottomNavigationBar(
              key: const PageStorageKey('bottomNavBar'),
              selectedItemColor: AppColors.buttonPrimary,
              items: [
                ...state.tabs.map(
                  (tab) => BottomNavigationBarItem(
                    label: tab.name!,
                    icon: tab.icon!,
                  ),
                ),
              ],
              currentIndex: state.page,
              onTap: (index) {
                context.read<HomeWrapperCubit>().changePageTo(index);
              },
            ),
          ),
        );
      },
    );
  }
}
