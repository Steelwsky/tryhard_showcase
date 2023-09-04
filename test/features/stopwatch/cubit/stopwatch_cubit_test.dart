import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tryhard_showcase/features/stopwatch/domain/cubit/stopwatch_cubit.dart';

import '../../../storage/fake_storage.dart';

void main() {
  const int testDuration = 10;

  late StopwatchCubit stopwatchCubit;

  const channel = MethodChannel('assets_audio_player');

  setUp(() async {
    initHydratedStorage();

    stopwatchCubit = StopwatchCubit();

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (_) => Future.value(null));
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (_) => Future.value(null));
  });

  group("StopwatchCubit", () {
    test("Initial state of cubit", () {
      expect(stopwatchCubit.state, StopwatchState.initial());
    });

    blocTest("Stopwatch view switches",
        build: () => stopwatchCubit,
        act: (cubit) => cubit.switchView(),
        expect: () => <StopwatchState>[
          StopwatchState(
            currentView: StopwatchView.stopwatch,
            durationInSecs: StopwatchState.initial().durationInSecs,
            isMuted: StopwatchState.initial().isMuted,
          ),
        ]);

    blocTest("Stopwatch duration changes",
        build: () => stopwatchCubit,
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
