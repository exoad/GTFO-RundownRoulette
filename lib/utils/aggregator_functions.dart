import 'dart:math';

typedef NumericalAggregator = num Function(num x);

/// Overall the best for speed and porportionality
num slowOutAggregatorFunction(num i) {
  // homemade crude damping function (start fast, end slow)
  return 1 / (0.2 + exp(1 / (75.0 * (i + 1) * (i + 1))));
}

/// very quick in general with the start being very very fast
num slowOutAggregatorFunction2(num i) {
  return 1 - exp(-i); // 1 - (e^-i)
}

const double SIN_E = 0.4107812905;

/// Very good for the ending part which has a very very long end.
num slowOutAggregatorFunction3(num i) {
  return e - pow(i.abs(), -SIN_E); // e-(x^(-sin(e))) ; {x>=0}
}
