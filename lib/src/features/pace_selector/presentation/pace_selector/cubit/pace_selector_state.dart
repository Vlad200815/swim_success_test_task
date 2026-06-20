part of 'pace_selector_cubit.dart';

enum PaceSubmissionStatus { initial, loading, success, failure }

class PaceSelectorState {
  final Duration time;
  final double sliderValue;
  final PaceLevel level;
  final PaceSubmissionStatus submissionStatus;
  final String? submissionError;

  const PaceSelectorState({
    required this.time,
    required this.sliderValue,
    required this.level,
    this.submissionStatus = PaceSubmissionStatus.initial,
    this.submissionError,
  });

  PaceSelectorState copyWith({
    Duration? time,
    double? sliderValue,
    PaceLevel? level,
    PaceSubmissionStatus? submissionStatus,
    String? submissionError,
  }) {
    return PaceSelectorState(
      time: time ?? this.time,
      sliderValue: sliderValue ?? this.sliderValue,
      level: level ?? this.level,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      submissionError: submissionError,
    );
  }

  factory PaceSelectorState.initial() => const PaceSelectorState(
    time: Duration(seconds: PaceSelectorCubit._maxSeconds),
    sliderValue: 1,
    level: PaceLevel.beginner,
  );
}
