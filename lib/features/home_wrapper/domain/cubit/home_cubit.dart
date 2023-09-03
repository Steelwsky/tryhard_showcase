import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:tryhard_showcase/features/home_wrapper/domain/models/tabs.dart';

part 'home_cubit.freezed.dart';
part 'home_state.dart';

class HomeWrapperCubit extends Cubit<HomeWrapperState> {
  HomeWrapperCubit(List<Widget> pages)
      : super(
          HomeWrapperState(
            page: 1,
            pages: pages,
            tabs: BottomNavBarItems().tabs,
          ),
        );

  void changePageTo(int page) {
    emit(state.copyWith(page: page));
  }
}
