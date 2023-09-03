import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tryhard_showcase/features/stopwatch/domain/cubit/stopwatch_cubit.dart';

import '../../../storage/fake_storage.dart';

void main() {
  const int testDuration = 10;

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    initHydratedStorage();
  });

  // TODO return to tests later. Tests crash when starting all together.
  // Running 1 by 1 completes successfully.
  group("StopwatchCubit", () {
    test("Initial state of cubit", () {
      expect(StopwatchCubit().state, StopwatchState.initial());
    });

    blocTest("Stopwatch view switches",
        build: () => StopwatchCubit()..openAudioAsset(),
        act: (cubit) => cubit.switchView(),
        expect: () => <StopwatchState>[
              StopwatchState(
                currentView: StopwatchView.stopwatch,
                durationInSecs: StopwatchState.initial().durationInSecs,
                isMuted: StopwatchState.initial().isMuted,
              ),
            ]);

    blocTest("Stopwatch duration changes",
        build: () => StopwatchCubit()..openAudioAsset(),
        act: (cubit) => cubit.setDuration(testDuration),
        expect: () => <StopwatchState>[
              StopwatchState(
                durationInSecs: testDuration,
                currentView: StopwatchState.initial().currentView,
                isMuted: StopwatchState.initial().isMuted,
              ),
            ]);
  });
}
