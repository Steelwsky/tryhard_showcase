import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryhard_showcase/app/ui/styles/colors.dart';
import 'package:tryhard_showcase/features/stopwatch/domain/cubit/stopwatch_cubit.dart';

import 'timer/timer.dart';

class StopwatchScreen extends StatelessWidget {
  const StopwatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StopwatchCubit()..openAudioAsset(),
      child: const _StopwatchView(),
    );
  }
}

class _StopwatchView extends StatelessWidget {
  const _StopwatchView();

  @override
  Widget build(BuildContext context) {
    final currentView =
        context.select((StopwatchCubit cubit) => cubit.state.currentView);
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Spacer(
            flex: 3,
          ),
          currentView == StopwatchView.settings
              ? const _SetupForm()
              : const _StopwatchForm(),
          const Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }
}

class _SetupForm extends StatelessWidget {
  const _SetupForm();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        _TimeSetupWidget(),
        SizedBox(
          height: 48,
        ),
        _StartButton(),
      ],
    );
  }
}

class _StopwatchForm extends StatelessWidget {
  const _StopwatchForm();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        _StopwatchWidget(),
        SizedBox(
          height: 48,
        ),
        _SettingsButton(),
        _MuteButton(),
      ],
    );
  }
}

class _TimeSetupWidget extends StatelessWidget {
  const _TimeSetupWidget();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: MediaQuery.of(context).size.width / 1.4,
        width: MediaQuery.of(context).size.width / 1.4,
        child: CupertinoTheme(
          data: const CupertinoThemeData(
            primaryColor: AppColors.primary,
            barBackgroundColor: AppColors.backgroundPrimary,
            scaffoldBackgroundColor: AppColors.backgroundPrimary,
            primaryContrastingColor: AppColors.secondary,
            brightness: Brightness.dark,
            textTheme: CupertinoTextThemeData(
              pickerTextStyle: TextStyle(
                fontSize: 24,
                fontFamily: 'SairaSemiCondensed',
              ),
            ),
          ),
          child: CupertinoTimerPicker(
            key: UniqueKey(),
            alignment: Alignment.center,
            initialTimerDuration: Duration(
              seconds: context.read<StopwatchCubit>().state.durationInSecs,
            ),
            onTimerDurationChanged: (duration) =>
                context.read<StopwatchCubit>().setDuration(duration.inSeconds),
            backgroundColor: AppColors.backgroundPrimary,
            minuteInterval: 1,
            secondInterval: 5,
            mode: CupertinoTimerPickerMode.ms,
          ),
        ),
      ),
    );
  }
}

class _StopwatchWidget extends StatelessWidget {
  const _StopwatchWidget();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onDoubleTap: context.read<StopwatchCubit>().restart,
      onTap: context.read<StopwatchCubit>().onStopwatchTap,
      child: CircularCountDownTimer(
        duration: context.read<StopwatchCubit>().state.durationInSecs,
        initialDuration: 0,
        controller: context.read<StopwatchCubit>().countDownController,
        width: MediaQuery.of(context).size.width / 1.4,
        height: MediaQuery.of(context).size.width / 1.4,
        ringColor: AppColors.backgroundSecondary,
        ringGradient: null,
        fillColor: AppColors.primary,
        fillGradient: null,
        backgroundColor: AppColors.backgroundPrimary,
        strokeWidth: 16.0,
        strokeCap: StrokeCap.butt,
        textStyle: const TextStyle(
          fontSize: 72.0,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        textFormat: CountdownTextFormat.mmss,
        isReverse: true,
        isReverseAnimation: true,
        isTimerTextShown: true,
        autoStart: true,
        onComplete: context.read<StopwatchCubit>().onComplete,
      ),
    );
  }
}

class _StartButton extends StatelessWidget {
  const _StartButton();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 86,
          width: 86,
          child: Center(
            child: InkWell(
              onTap: context.read<StopwatchCubit>().switchView,
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  border: Border.all(
                    width: 3,
                    color: AppColors.backgroundPrimary,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 0),
                      blurRadius: 1,
                      spreadRadius: 3,
                      color: AppColors.primary,
                    ),
                  ],
                  color: AppColors.primary,
                ),
                child: const Center(
                  child: Text(
                    'Start',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 60,
        ),
      ],
    );
  }
}

class _SettingsButton extends StatelessWidget {
  const _SettingsButton();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 86,
          width: 86,
          child: Center(
            child: InkWell(
              onTap: context.read<StopwatchCubit>().switchView,
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    border: Border.all(
                        width: 3, color: AppColors.backgroundPrimary),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 1,
                        spreadRadius: 3,
                        color: AppColors.backgroundSecondary,
                      ),
                    ],
                    color: AppColors.backgroundSecondary),
                child: const Center(
                  child: Text(
                    'Change',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _MuteButton extends StatelessWidget {
  const _MuteButton();

  @override
  Widget build(BuildContext context) {
    final muteState =
        context.select((StopwatchCubit cubit) => cubit.state.isMuted);
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: SizedBox(
        height: 44,
        width: 44,
        child: Center(
          child: InkWell(
            onTap: context.read<StopwatchCubit>().setMute,
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  border:
                      Border.all(width: 3, color: AppColors.backgroundPrimary),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 0),
                      blurRadius: 1,
                      spreadRadius: 3,
                      color: AppColors.backgroundSecondary,
                    ),
                  ],
                  color: AppColors.backgroundSecondary),
              child: Center(
                child: muteState
                    ? const Icon(
                        Icons.music_off,
                        color: AppColors.backgroundPrimary,
                      )
                    : const Icon(
                        Icons.music_note,
                        color: AppColors.white,
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
