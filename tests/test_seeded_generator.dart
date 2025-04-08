import "package:flutter_test/flutter_test.dart";
import "package:gtfo_rundown_roulette/utils/seeded_generator.dart";

void main() {
  group("Test1", () {
    final List<String> e = <String>[
      "alpha",
      "bravo",
      "charlie",
      "delta",
      "echo",
      "foxtrot",
      "golf",
      "hotel",
    ];
    final RandomGeneration<String> generated = SeededGenerator.pickFrom(e, 4);
    test("validity", () {
      final List<String> r2 = SeededGenerator.pickFrom(e, 4, generated.seed).picked;
      expect(r2, equals(generated.picked));
      print("\n$r2\n${generated.picked}");
    });
    test("neq", () {
      final List<String> r2 = SeededGenerator.pickFrom(e, 4).picked;
      expect(r2, isNot(equals(generated.picked)));
      print("\n$r2\n${generated.picked}");
    });
  });
}
