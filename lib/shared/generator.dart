import 'package:gtfo_rundown_roulette/shared/shared.dart';

extension IterableRandomExtension<T> on Iterable<T> {
  T pick() {
    return elementAt(rnd.nextInt(length));
  }

  List<T> pickMultiple() {
    final List<T> res = <T>[];
    for (T item in this) {
      if (rnd.nextBool()) {
        res.add(item);
      }
    }
    return res;
  }
}

class Variant1Generator {
  static GeneratedRun produceFrom(
    Preset preset, [
    bool rollRundown = true,
    bool rollWeapons = true,
    GeneratedRun? previous,
  ]) {
    if ((!rollRundown || !rollWeapons) && previous == null) {
      throw ArgumentError(
        "Cannot not roll without providing a basis of the previous generated run!",
      );
    }
    final Rundown rundown = preset.rundowns.pick();
    final Mission mission = rundown.allMissions.pick();
    return GeneratedRun(
      rundown: rollRundown ? rundown : previous!.rundown,
      mission: rollRundown ? mission : previous!.mission,
      sectors: rollRundown ? mission.generate() : previous!.sectors,
      players:
          rollWeapons
              ? PlayerPool(
                player1: Loadout(
                  melee: MeleeWeapon.generate(),
                  tool: preset.tools.pick(),
                  primary: preset.primaries.pick(),
                  special: preset.specials.pick(),
                  boosters: Boosters.values.pickMultiple(),
                ),
                player2: Loadout(
                  melee: MeleeWeapon.generate(),
                  tool: preset.tools.pick(),
                  primary: preset.primaries.pick(),
                  special: preset.specials.pick(),
                  boosters: Boosters.values.pickMultiple(),
                ),
                player3: Loadout(
                  melee: MeleeWeapon.generate(),
                  tool: preset.tools.pick(),
                  primary: preset.primaries.pick(),
                  special: preset.specials.pick(),
                  boosters: Boosters.values.pickMultiple(),
                ),
                player4: Loadout(
                  melee: MeleeWeapon.generate(),
                  tool: preset.tools.pick(),
                  primary: preset.primaries.pick(),
                  special: preset.specials.pick(),
                  boosters: Boosters.values.pickMultiple(),
                ),
              )
              : previous!.players,
    );
  }
}
