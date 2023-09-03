import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tryhard_showcase/features/home_wrapper/domain/cubit/home_cubit.dart';
import 'package:tryhard_showcase/features/home_wrapper/ui/home_wrapper.dart';

void main() {
  late final HomeWrapperCubit homeWrapperCubit;
  setUp(() {
    homeWrapperCubit = HomeWrapperCubit(homePages);
  });

  group('HomeCubit', () {
    blocTest<HomeWrapperCubit, HomeWrapperState>(
      'changing page index to 0',
      build: () => homeWrapperCubit,
      act: (cubit) => cubit.changePageTo(0),
      expect: () => <HomeWrapperState>[
        HomeWrapperState(
          page: 0,
          pages: homeWrapperCubit.state.pages,
          tabs: homeWrapperCubit.state.tabs,
        )
      ],
    );
  });
}
