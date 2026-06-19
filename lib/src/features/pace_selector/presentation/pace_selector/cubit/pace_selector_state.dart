part of 'pace_selector_cubit.dart';

class PaceSelectorState {
  final Duration time;
  final double sliderValue;
  final PaceLevel level;

  const PaceSelectorState({
    required this.time,
    required this.sliderValue,
    required this.level,
  });

  factory PaceSelectorState.initial() => const PaceSelectorState(
    time: Duration(seconds: PaceSelectorCubit._maxSeconds),
    sliderValue: 1,
    level: PaceLevel.beginner,
  );
}
