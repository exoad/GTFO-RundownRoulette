import "package:xrandom/xrandom.dart";

typedef RandomGeneration<T> = ({List<T> picked, int seed});

/// a seeded generator is a prng where it uses a seed to generate and thus the same seed will get
/// the same sequence back.
///
/// it uses [Xrandom] which is backed by a 32 bit simple xorshift. this means that when using this
/// generator, [SeededGenerator] itself will truncate to 32 bits. if [Xrandom] alone with a bit length
/// of more than 32 bits, there will be an error thrown.
class SeededGenerator {
  /// uses [DateTime]'s millisecondsSinceEpoch method to get a seed
  static int get seedFromTimeMS => DateTime.now().millisecondsSinceEpoch & 0xFFFFFFFF;

  /// picks [amountToPick] from [list] using a seed.
  ///
  /// if no seed is passed, AKA `null` is passed, then [seed] will be assigned the
  /// value of [seedFromTimeMS]
  static RandomGeneration<T> pickFrom<T>(
    final List<T> list, [
    final int amountToPick = 1, // default to picking at least one item, assertion errors elsewise
    int? seed,
  ]) {
    assert(
      amountToPick >= 1 && amountToPick < list.length,
      "Amount to randomly pick must be greater than or equal to 1 and less than list.length!",
    );
    seed =
        seed != null
            ? seed & 0xFFFFFFFF
            : seedFromTimeMS; // truncate to 32bit since the xrandom generator uses 32bit xorshift to make sure it works across both JS (which uses 53bit) and native (which is 64bit)
    return (
      picked:
          List<T>.from(list)
            ..shuffle(Xrandom(seed))
            ..take(amountToPick).toList(),
      seed: seed,
    );
  }
}
