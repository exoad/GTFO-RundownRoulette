import 'dart:io';

import 'package:gtfo_rundown_roulette/shared/generated.dart';
import 'package:gtfo_rundown_roulette/utils/seeded_generator.dart';

const int count = 1_000_000;

void main() {
  final Map<String, int> total = <String, int>{};
  final DateTime startTime = DateTime.now();
  for (int i = 0; i < count; i++) {
    final String mission =
        SeededGenerator.pickFrom(Preset.vanilla.allMissions).picked.first.canonicalName;
    total[mission] = (total[mission] ?? 0) + 1;
  }
  final int elapsed = DateTime.now().difference(startTime).inMilliseconds;
  final List<MapEntry<String, int>> sortedEntries =
      total.entries.toList()
        ..sort((MapEntry<String, int> a, MapEntry<String, int> b) => a.value.compareTo(b.value));
  for (MapEntry<String, int> entry in sortedEntries) {
    print("${entry.key} : ${entry.value / count}");
  }
  print("\n\nTook: ${elapsed}ms");
  exit(0); // ignore any vm service disposed messages
}
