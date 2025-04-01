import 'package:flutter/material.dart';
import 'package:gtfo_rundown_roulette/shared/generated.dart';

class CurrentRun with ChangeNotifier {
  static final CurrentRun instance = CurrentRun._();

  GeneratedRun? _value;
  CurrentRun._();

  set value(GeneratedRun run) {
    _value = run;
    notifyListeners();
  }

  GeneratedRun? get run => _value;
}
