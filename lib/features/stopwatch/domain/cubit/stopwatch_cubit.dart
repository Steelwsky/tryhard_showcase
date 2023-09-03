import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:tryhard_showcase/features/stopwatch/ui/timer/timer.dart';

part 'stopwatch_cubit.freezed.dart';
part 'stopwatch_cubit.g.dart';
part 'stopwatch_state.dart';

class StopwatchCubit extends HydratedCubit<StopwatchState> {
  StopwatchCubit() : super(StopwatchState.initial()) {
    countDownController = CountDownController();
    assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
  }

  late final AssetsAudioPlayer assetsAudioPlayer;
  late final CountDownController countDownController;

  void openAudioAsset() => assetsAudioPlayer.open(
        Audio('assets/whistle.mp3'),
        autoStart: false,
      );

  void setDuration(int duration) {
    emit(state.copyWith(durationInSecs: duration));
  }

  void switchView() {
    final newView = state.currentView == StopwatchView.stopwatch
        ? StopwatchView.settings
        : StopwatchView.stopwatch;

    emit(state.copyWith(currentView: newView));
  }

  void onComplete() {
    !state.isMuted ? assetsAudioPlayer.play() : null;
  }

  void onStopwatchTap() {
    if (countDownController.isPaused) {
      countDownController.resume();
    } else if (countDownController.isStarted) {
      countDownController.pause();
    } else {
      countDownController.start();
    }
  }

  void restart() {
    countDownController.restart();
  }

  void setMute() {
    emit(state.copyWith(isMuted: !state.isMuted));
  }

  @override
  Future<void> close() {
    assetsAudioPlayer.dispose();
    return super.close();
  }

  @override
  StopwatchState? fromJson(Map<String, dynamic> json) {
    final state = StopwatchState.fromJson(json);
    return state;
  }

  @override
  Map<String, dynamic>? toJson(StopwatchState state) {
    final forSaveState = StopwatchState(
      currentView: StopwatchView.settings,
      isMuted: state.isMuted,
      durationInSecs: state.durationInSecs,
    );
    return forSaveState.toJson();
  }
}
