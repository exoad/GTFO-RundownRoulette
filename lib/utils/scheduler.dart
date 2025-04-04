import 'dart:async';
import 'dart:math';

import 'package:gtfo_rundown_roulette/utils/aggregator_functions.dart';

final class Scheduler {
  Scheduler._();

  /// Runs the [function] [times] amount of times with a starting delay of [baseDelay]
  /// and over time decreases it by [delayStep] until it reaches a minimum of 40ms.
  static Future<void> inductiveRelay(
    void Function() function,
    int times,
    int baseDelay,
    int delayStep,
  ) async {
    if (times <= 0) {
      return;
    }
    int currentDelay = baseDelay;
    while (times-- > 0) {
      await Future<void>.delayed(Duration(milliseconds: currentDelay));
      try {
        function();
      } catch (e) {
        rethrow;
      }
      currentDelay = max(40, currentDelay - delayStep);
    }
  }

  /// Performs the opposite of [inductiveRelay] and will increase the delay between each call.
  static Future<void> reductiveRelay(
    void Function() function,
    int times,
    int baseDelay,
    int delayStep, [
    NumericalAggregator? aggregator,
  ]) async {
    aggregator ??= slowOutAggregatorFunction;
    if (times <= 0) {
      return;
    }
    int currentDelay = baseDelay;
    for (int i = 1; i <= times; i++) {
      await Future<void>.delayed(Duration(milliseconds: currentDelay));
      try {
        function();
      } catch (e) {
        rethrow;
      }
      currentDelay = currentDelay + (delayStep * aggregator(i.toDouble())).toInt();
    }
  }

  /// Runs [function], [times] amount of times with a constant delay specified by
  /// [baseDelay].
  static Future<void> constantRelay(void Function() function, int times, int baseDelay) async {
    if (times <= 0) {
      return;
    }
    final Duration delay = Duration(milliseconds: baseDelay);
    while (times-- > 0) {
      await Future<void>.delayed(delay);
      try {
        function();
      } on Error {
        rethrow;
      }
    }
  }
}
