import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swim_success_test_task/src/app/config.dart';
import 'package:swim_success_test_task/src/core/network/failure.dart';
import 'package:swim_success_test_task/src/features/pace_selector/domain/usecases/post_pace_seconds_usecase.dart';

part "pace_selector_state.dart";

class PaceSelectorCubit extends Cubit<PaceSelectorState> {
  PaceSelectorCubit({
    this.debounceDuration = const Duration(milliseconds: 400),
    required this._postPaceSecondsUseCase,
  }) : super(PaceSelectorState.initial());

  final PostPaceSecondsUseCase _postPaceSecondsUseCase;
  final Duration debounceDuration;
  Timer? _debounce;

  static const int _minSeconds = 30; // fastest end -> value 0.0
  static const int _maxSeconds = 180; // slowest end -> value 1.0

  // The cutoffs between levels (elite/advanced, advanced/intermediate,
  static const List<int> levelBoundarySeconds = [60, 90, 120];

  /// Public so tick-mark placement in the UI uses the exact same formula
  /// as the slider fill itself — one conversion, not two.
  static double secondsToValue(int seconds) {
    final clamped = seconds.clamp(_minSeconds, _maxSeconds);
    return ((clamped - _minSeconds) / (_maxSeconds - _minSeconds)).clamp(
      0.0,
      1.0,
    );
  }

  static int valueToSeconds(double value) {
    final clamped = value.clamp(0.0, 1.0);
    return (_minSeconds + clamped * (_maxSeconds - _minSeconds)).round();
  }

  /// Formats seconds as M:SS — used for the slider's tick labels.
  static String formatSeconds(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void updateTime(Duration time) {
    _debounce?.cancel();
    _debounce = Timer(debounceDuration, () => _applyTime(time));
  }

  void applyTimeImmediately(Duration time) {
    _debounce?.cancel();
    _applyTime(time);
  }

  void setFromSliderValue(double value) {
    _debounce?.cancel();
    _applyTime(Duration(seconds: valueToSeconds(value)));
  }

  /// Post Pace Seconds
  Future<void> postPaceSeconds() async {
    _debounce?.cancel();

    emit(state.copyWith(submissionStatus: PaceSubmissionStatus.loading));

    try {
      await _postPaceSecondsUseCase.perform(state.time.inSeconds);
      emit(state.copyWith(submissionStatus: PaceSubmissionStatus.success));
    } on Failure catch (f) {
      emit(
        state.copyWith(
          submissionStatus: PaceSubmissionStatus.failure,
          submissionError: f.message,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          submissionStatus: PaceSubmissionStatus.failure,
          submissionError: 'Something went wrong. Please try again.',
        ),
      );
    }
  }

  void _applyTime(Duration time) {
    final seconds = time.inSeconds;
    emit(
      PaceSelectorState(
        time: time,
        sliderValue: secondsToValue(seconds),
        level: _levelFor(seconds),
      ),
    );
  }

  PaceLevel _levelFor(int seconds) {
    if (seconds <= levelBoundarySeconds[0]) return PaceLevel.elite;
    if (seconds <= levelBoundarySeconds[1]) return PaceLevel.advanced;
    if (seconds <= levelBoundarySeconds[2]) return PaceLevel.intermediate;
    return PaceLevel.beginner;
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
