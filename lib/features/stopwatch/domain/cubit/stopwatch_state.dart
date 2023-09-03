part of 'stopwatch_cubit.dart';

@freezed
class StopwatchState with _$StopwatchState {
  const factory StopwatchState({
    required StopwatchView currentView,
    required bool isMuted,
    required int durationInSecs,
  }) = _StopwatchState;

  factory StopwatchState.initial() {
    return const StopwatchState(
      currentView: StopwatchView.settings,
      durationInSecs: 60,
      isMuted: false,
    );
  }

  factory StopwatchState.fromJson(Map<String, dynamic> json) => _$StopwatchStateFromJson(json);
}

enum StopwatchView {
  stopwatch,
  settings,
}
