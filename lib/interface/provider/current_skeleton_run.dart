import 'package:flutter/material.dart';
import 'package:gtfo_rundown_roulette/shared/generated.dart';

class CurrentSkeletonRun extends ChangeNotifier {
  static final CurrentSkeletonRun instance = CurrentSkeletonRun._();

  SkeletonRun? _value;
  
  CurrentSkeletonRun._();

  set value(SkeletonRun run) {
    _value = run;
    notifyListeners();
  }

  SkeletonRun? get run => _value;
}
