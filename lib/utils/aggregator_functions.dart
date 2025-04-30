import 'dart:math';

import 'package:gtfo_rundown_roulette/utils/computed_consts.dart';

/// represents a mathematical function that applies a transformation to [x]
typedef NumericalAggregator = num Function(num x);

/// Overall the best for speed and porportionality
num slowOutAggregatorFunction(num i) {
  // homemade crude damping function (start fast, end slow)
  return 1 / (0.34 + exp(1 / (75.0 * (i + 1) * (i + 1))));
}

/// very quick in general with the start being very very fast
num slowOutAggregatorFunction2(num i) {
  return 1 - exp(-i); // 1 - (e^-i)
}

/// Very good for the ending part which has a very very long end.
num slowOutAggregatorFunction3(num i) {
  return e - pow(i.abs(), -SIN_E); // e-(x^(-sin(e))) ; {x>=0}
}

/// exponential decay curve
num slotMachineDecayFunction(num i, [num initialFactor = 0.8, num decayRate = 0.87]) {
  return initialFactor * pow(decayRate, i - 1);
}
