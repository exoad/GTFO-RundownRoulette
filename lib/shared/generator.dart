import 'package:gtfo_rundown_roulette/shared/classes_loadout.dart';
import 'package:gtfo_rundown_roulette/shared/classes_runs.dart';
import 'package:gtfo_rundown_roulette/shared/generated.dart';
import 'package:rnd/rnd.dart';

extension IterableRandomExtension<T> on Iterable<T> {
  T pick() {
    return elementAt(rnd.nextInt(length));
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
                ),
                player2: Loadout(
                  melee: MeleeWeapon.generate(),
                  tool: preset.tools.pick(),
                  primary: preset.primaries.pick(),
                  special: preset.specials.pick(),
                ),
                player3: Loadout(
                  melee: MeleeWeapon.generate(),
                  tool: preset.tools.pick(),
                  primary: preset.primaries.pick(),
                  special: preset.specials.pick(),
                ),
                player4: Loadout(
                  melee: MeleeWeapon.generate(),
                  tool: preset.tools.pick(),
                  primary: preset.primaries.pick(),
                  special: preset.specials.pick(),
                ),
              )
              : previous!.players,
    );
  }
}
