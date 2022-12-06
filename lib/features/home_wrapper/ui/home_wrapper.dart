import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryhard_showcase/app/ui/styles/colors.dart';
import 'package:tryhard_showcase/features/home_wrapper/domain/home_cubit/home_cubit.dart';

class HomeScreenWrapper extends StatelessWidget {
  const HomeScreenWrapper({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeWrapperCubit, HomeWrapperState>(
      builder: (context, state) {
        return Scaffold(
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
              }),
        );
      },
    );
  }
}
