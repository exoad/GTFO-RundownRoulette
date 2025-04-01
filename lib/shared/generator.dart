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

@pragma("vm:entry-point")
class Variant1FilterInvarianceError extends Error {
  final String message;

  @pragma("vm:entry-point")
  Variant1FilterInvarianceError(this.message);

  @override
  String toString() => message;
}

/// An exclusive filter for operating the [Variant1Generator]
class Variant1Filter {
  final Set<Mission> blockedMissions;
  final Set<Gun> blockedPrimaries;
  final Set<Gun> blockedSpecials;
  final Set<ToolItem> blockedTools;
  final Set<MeleeWeapon> blockedMelees;
  final Set<Boosters> blockedBoosters;

  const Variant1Filter({
    required this.blockedMissions,
    required this.blockedPrimaries,
    required this.blockedSpecials,
    required this.blockedTools,
    required this.blockedMelees,
    required this.blockedBoosters,
  });

  static const Variant1Filter unblocked = Variant1Filter(
    blockedMelees: <MeleeWeapon>{},
    blockedMissions: <Mission>{},
    blockedPrimaries: <Gun>{},
    blockedSpecials: <Gun>{},
    blockedTools: <ToolItem>{},
    blockedBoosters: <Boosters>{},
  );

  bool isValidMission(Mission mission) => !blockedMissions.contains(mission);

  bool isValidBooster(Boosters booster) => !blockedBoosters.contains(booster);

  bool isValidPrimary(Gun gun) => !blockedPrimaries.contains(gun);

  bool isValidSpecial(Gun gun) => !blockedSpecials.contains(gun);

  bool isValidTool(ToolItem tool) => !blockedTools.contains(tool);

  bool isValidMelee(MeleeWeapon melee) => !blockedMelees.contains(melee);

  List<Boosters> applyBoosters(List<Boosters> value) {
    return blockedBoosters.isEmpty
        ? value
        : value.where((Boosters gun) => !blockedBoosters.contains(gun)).toList();
  }

  List<Gun> applyPrimaryGuns(List<Gun> value) {
    if (blockedPrimaries.isEmpty) {
      return value;
    }
    if (blockedPrimaries.length == value.length) {
      throw Variant1FilterInvarianceError(
        "Filtering primaries cannot be empty! Unblock at least one weapon to continue.",
      );
    }
    return value.where((Gun gun) => !blockedPrimaries.contains(gun)).toList();
  }

  List<Gun> applySpecialGuns(List<Gun> value) {
    if (blockedSpecials.isEmpty) {
      return value;
    }
    if (blockedSpecials.length == value.length) {
      throw Variant1FilterInvarianceError(
        "Filtering specials cannot be empty! Unblock at least one weapon to continue.",
      );
    }
    return value.where((Gun gun) => !blockedSpecials.contains(gun)).toList();
  }

  List<ToolItem> applyTools(List<ToolItem> value) {
    if (blockedTools.isEmpty) {
      return value;
    }
    if (blockedTools.length == value.length) {
      throw Variant1FilterInvarianceError(
        "Filtering tools cannot be empty! Unblock at least one tool to continue.",
      );
    }
    return value.where((ToolItem tool) => !blockedTools.contains(tool)).toList();
  }

  List<MeleeWeapon> applyMelee(List<MeleeWeapon> value) {
    if (blockedMelees.isEmpty) {
      return value;
    }
    if (blockedMelees.length == value.length) {
      throw Variant1FilterInvarianceError(
        "Filtering melees cannot be empty! Unblock at least one tool to continue.",
      );
    }
    return value.where((MeleeWeapon melee) => !blockedMelees.contains(melee)).toList();
  }

  List<Mission> applyMissions(List<Mission> value) {
    if (blockedMissions.isEmpty) {
      return value;
    }
    if (blockedMissions.length == value.length) {
      throw Variant1FilterInvarianceError(
        "Filtering missions cannot be empty! Unblock at least one tool to continue.",
      );
    }
    return value.where((Mission mission) => !blockedMissions.contains(mission)).toList();
  }
}

class Variant1Generator {
  static GeneratedRun produceFrom(
    // used positional arguments here, so uhhh kinda hard to migrate to named ! wellllll, just gonna keep adding on it :) sucks to suck eh ?
    Preset preset, [
    bool rollRundown = true,
    bool rollWeapons = true,
    GeneratedRun? previous,
    Variant1Filter? filter,
  ]) {
    if ((!rollRundown || !rollWeapons) && previous == null) {
      throw ArgumentError(
        "Cannot not roll without providing a basis of the previous generated run!",
      );
    }
    Rundown? rundown;
    Mission? mission;
    if (rollRundown) {
      rundown = preset.rundowns.pick();
      mission = rundown.allMissions.pick();
      if (filter != null) {
        while (!filter.isValidMission(mission!)) {
          // a very very very very very insanely small chance this could run for some time :)
          // im too lazy to make this better if it works...
          rundown = preset.rundowns.pick();
          mission = rundown.allMissions.pick();
        }
      }
    }
    return GeneratedRun(
      rundown: rollRundown ? rundown! : previous!.rundown,
      mission: rollRundown ? mission! : previous!.mission,
      sectors: rollRundown ? mission!.generate() : previous!.sectors,
      players:
          rollWeapons
              ? PlayerPool(
                player1: Loadout(
                  melee:
                      (filter ?? Variant1Filter.unblocked)
                          .applyMelee(MeleeWeapon.weapons)
                          .pick(),
                  tool:
                      (filter ?? Variant1Filter.unblocked)
                          .applyTools(preset.tools)
                          .pick(),
                  primary:
                      (filter ?? Variant1Filter.unblocked)
                          .applyPrimaryGuns(preset.primaries)
                          .pick(),
                  special:
                      (filter ?? Variant1Filter.unblocked)
                          .applySpecialGuns(preset.specials)
                          .pick(),
                  boosters:
                      (filter ?? Variant1Filter.unblocked)
                          .applyBoosters(Boosters.values)
                          .pickMultiple(),
                ),
                player2: Loadout(
                  melee:
                      (filter ?? Variant1Filter.unblocked)
                          .applyMelee(MeleeWeapon.weapons)
                          .pick(),
                  tool:
                      (filter ?? Variant1Filter.unblocked)
                          .applyTools(preset.tools)
                          .pick(),
                  primary:
                      (filter ?? Variant1Filter.unblocked)
                          .applyPrimaryGuns(preset.primaries)
                          .pick(),
                  special:
                      (filter ?? Variant1Filter.unblocked)
                          .applySpecialGuns(preset.specials)
                          .pick(),
                  boosters:
                      (filter ?? Variant1Filter.unblocked)
                          .applyBoosters(Boosters.values)
                          .pickMultiple(),
                ),
                player3: Loadout(
                  melee:
                      (filter ?? Variant1Filter.unblocked)
                          .applyMelee(MeleeWeapon.weapons)
                          .pick(),
                  tool:
                      (filter ?? Variant1Filter.unblocked)
                          .applyTools(preset.tools)
                          .pick(),
                  primary:
                      (filter ?? Variant1Filter.unblocked)
                          .applyPrimaryGuns(preset.primaries)
                          .pick(),
                  special:
                      (filter ?? Variant1Filter.unblocked)
                          .applySpecialGuns(preset.specials)
                          .pick(),
                  boosters:
                      (filter ?? Variant1Filter.unblocked)
                          .applyBoosters(Boosters.values)
                          .pickMultiple(),
                ),
                player4: Loadout(
                  melee:
                      (filter ?? Variant1Filter.unblocked)
                          .applyMelee(MeleeWeapon.weapons)
                          .pick(),
                  tool:
                      (filter ?? Variant1Filter.unblocked)
                          .applyTools(preset.tools)
                          .pick(),
                  primary:
                      (filter ?? Variant1Filter.unblocked)
                          .applyPrimaryGuns(preset.primaries)
                          .pick(),
                  special:
                      (filter ?? Variant1Filter.unblocked)
                          .applySpecialGuns(preset.specials)
                          .pick(),
                  boosters:
                      (filter ?? Variant1Filter.unblocked)
                          .applyBoosters(Boosters.values)
                          .pickMultiple(),
                ),
              )
              : previous!.players,
    );
  }
}
