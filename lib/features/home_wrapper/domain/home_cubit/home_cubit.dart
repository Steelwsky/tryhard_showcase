import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:tryhard_showcase/features/home_wrapper/domain/models/tabs.dart';
import 'package:tryhard_showcase/features/info/ui/info.dart';
import 'package:tryhard_showcase/features/profile/ui/profile.dart';

part 'home_cubit.freezed.dart';

part 'home_state.dart';

class HomeWrapperCubit extends Cubit<HomeWrapperState> {
  HomeWrapperCubit()
      : super(
          HomeWrapperState(
            page: 0,
            pages: const [
              ProfileOverviewScreen(),
              InfoScreen(),
            ],
            tabs: BottomNavBarItems().tabs,
          ),
        );

  void changePageTo(int page) {
    emit(state.copyWith(page: page));
  }
}
