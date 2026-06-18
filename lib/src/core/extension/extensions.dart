import 'dart:core';

import 'package:flutter/material.dart';

extension ListExtension<T> on List<T>? {
  List<T> orEmpty() {
    return this ?? [];
  }

  bool isNullOrEmpty() {
    return (this ?? []).isEmpty;
  }

  T? firstOrNull() {
    return (this.isNullOrEmpty()) ? null : this?.first;
  }

  T? random() {
    return (this.isNullOrEmpty()) ? null : (this?..shuffle()).firstOrNull();
  }
}

extension MapExtension<K, T> on Map<K, T>? {
  Map<K, T> orEmpty() {
    return this ?? {};
  }

  bool isNullOrEmpty() {
    return (this ?? {}).isEmpty;
  }

  bool isEmpty() {
    return this != null && this!.isEmpty;
  }
}

extension StringExtensions on String? {
  bool isNullOrEmpty() {
    return (this ?? "").isEmpty;
  }

  String orEmpty() {
    return this ?? "";
  }

  String orValue(String value) {
    return this ?? value;
  }

  int toNumber() {
    return int.tryParse(orEmpty().replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
  }

  DateTime toDateTime() {
    return DateTime.tryParse(orEmpty()) ?? DateTime.now();
  }
}

extension DoubleExtensions on double? {
  double orZero() {
    return this ?? 0.0;
  }

  double toPrecision(int n) => double.parse(orZero().toStringAsFixed(n));
}

extension IntExtensions on int? {
  int orZero() {
    return this ?? 0;
  }

  int orValue(int value) {
    return this ?? value;
  }
}

extension NumExtensions on num? {
  num orZero() {
    return this ?? 0;
  }

  num orValue(num value) {
    return this ?? value;
  }
}

extension BoolExtensions on bool? {
  bool orFalse() {
    return this ?? false;
  }

  bool orTrue() {
    return this ?? true;
  }

  bool isTrue() {
    return this == true;
  }

  bool isFalse() {
    return this == false;
  }

  bool orValue(bool value) {
    return this ?? value;
  }
}

extension DurationExtension on Duration {
  String formatDuration() {
    if (isNegative || this == Duration.zero) {
      return '00:00';
    }
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(inMinutes.remainder(60));
    final seconds = twoDigits(inSeconds.remainder(60));
    debugPrint('Formatting duration: $this -> $minutes:$seconds');
    return '$minutes:$seconds';
  }
}
