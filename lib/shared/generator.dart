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
  static GeneratedRun produceFrom(Preset preset) {
    return GeneratedRun(
      mission: preset.rundowns.pick().allMissions.pick(),
      players: PlayerPool(
        player1: Loadout(melee: MeleeWeapon.generate()),
        player2: Loadout(melee: MeleeWeapon.generate()),
        player3: Loadout(melee: MeleeWeapon.generate()),
        player4: Loadout(melee: MeleeWeapon.generate()),
      ),
    );
  }
}
