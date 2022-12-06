import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tryhard_showcase/features/home_wrapper/domain/home_cubit/home_cubit.dart';

void main() {
  late final HomeWrapperCubit homeWrapperCubit;
  setUp(() {
    homeWrapperCubit = HomeWrapperCubit();
  });

  group('HomeCubit', () {
    blocTest<HomeWrapperCubit, HomeWrapperState>(
      'changing page',
      build: () => homeWrapperCubit,
      act: (cubit) => cubit.changePageTo(1),
      expect: () => <HomeWrapperState>[
        HomeWrapperState(
          page: 1,
          pages: homeWrapperCubit.state.pages,
          tabs: homeWrapperCubit.state.tabs,
        )
      ],
    );
  });
}
