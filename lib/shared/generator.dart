import 'package:gtfo_rundown_roulette/shared/shared.dart';
import 'package:gtfo_rundown_roulette/utils/seeded_generator.dart';
import 'package:xrandom/xrandom.dart';

extension IterableRandomExtension<T> on List<T> {
  T pick([int? seed]) {
    return SeededGenerator.pickFrom(this, 1, seed).picked.first;
  }

  List<T> pickMultiple([int? seed]) {
    final List<T> res = <T>[];
    final Xrandom rng = Xrandom(seed);
    for (int i = 0; i < length; i++) {
      if (rng.nextBool()) {
        res.add(this[i]);
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
        : value.where((Boosters booster) => !blockedBoosters.contains(booster)).toList();
  }

  List<Gun> applyPrimaryGuns(List<Gun> value) {
    if (blockedPrimaries.isEmpty) {
      return value;
    }
    final List<Gun> filtered = value.where((Gun gun) => !blockedPrimaries.contains(gun)).toList();
    if (filtered.isEmpty && value.isNotEmpty) {
      throw Variant1FilterInvarianceError(
        "Filtering primaries cannot result in an empty list! Unblock at least one weapon to continue.",
      );
    }
    return filtered;
  }

  List<Gun> applySpecialGuns(List<Gun> value) {
    if (blockedSpecials.isEmpty) {
      return value;
    }
    final List<Gun> filtered = value.where((Gun gun) => !blockedSpecials.contains(gun)).toList();
    if (filtered.isEmpty && value.isNotEmpty) {
      throw Variant1FilterInvarianceError(
        "Filtering specials cannot result in an empty list! Unblock at least one weapon to continue.",
      );
    }
    return filtered;
  }

  List<ToolItem> applyTools(List<ToolItem> value) {
    if (blockedTools.isEmpty) {
      return value;
    }
    final List<ToolItem> filtered =
        value.where((ToolItem tool) => !blockedTools.contains(tool)).toList();
    if (filtered.isEmpty && value.isNotEmpty) {
      throw Variant1FilterInvarianceError(
        "Filtering tools cannot result in an empty list! Unblock at least one tool to continue.",
      );
    }
    return filtered;
  }

  List<MeleeWeapon> applyMelee(List<MeleeWeapon> value) {
    if (blockedMelees.isEmpty) {
      return value;
    }
    final List<MeleeWeapon> filtered =
        value.where((MeleeWeapon melee) => !blockedMelees.contains(melee)).toList();
    if (filtered.isEmpty && value.isNotEmpty) {
      throw Variant1FilterInvarianceError(
        "Filtering melees cannot result in an empty list! Unblock at least one melee weapon to continue.",
      );
    }
    return filtered;
  }

  List<Mission> applyMissions(List<Mission> value) {
    if (blockedMissions.isEmpty) {
      return value;
    }
    final List<Mission> filtered =
        value.where((Mission mission) => !blockedMissions.contains(mission)).toList();
    if (filtered.isEmpty && value.isNotEmpty) {
      throw Variant1FilterInvarianceError(
        "Filtering missions cannot result in an empty list! Unblock at least one mission to continue.",
      );
    }
    return filtered;
  }
}

class Variant1Generator {
  static GeneratedRun produceFrom(
    Preset preset, [
    bool rollRundown = true,
    bool rollWeapons = true,
    GeneratedRun? previous,
    Variant1Filter? filter,
    int? seed,
  ]) {
    if ((!rollRundown || !rollWeapons) && previous == null) {
      throw ArgumentError(
        "Cannot not roll without providing a basis of the previous generated run!",
      );
    }
    final int effectiveSeed = (seed ?? SeededGenerator.seedFromTimeMS) & 0xFFFFFFFF;
    final Xrandom runRandom = Xrandom(effectiveSeed);
    Rundown? rundown;
    Mission? mission;
    List<Sector>? sectors;
    final Variant1Filter effectiveFilter = filter ?? Variant1Filter.unblocked;
    if (rollRundown) {
      List<Rundown> availableRundowns = preset.rundowns;
      rundown = availableRundowns.pick(runRandom.nextInt(0xFFFFFFFF));
      List<Mission> availableMissions = effectiveFilter.applyMissions(rundown.allMissions);
      if (availableMissions.isEmpty) {
        throw Variant1FilterInvarianceError(
          "Filtering missions for rundown ${rundown.canonicalName} resulted in an empty list! Unblock at least one mission for this rundown.",
        );
      }
      mission = availableMissions.pick(runRandom.nextInt(0xFFFFFFFF));
      sectors = mission.generate();
    } else {
      rundown = previous!.rundown;
      mission = previous.mission;
      sectors = previous.sectors;
    }
    final List<MeleeWeapon> availableMelees = effectiveFilter.applyMelee(MeleeWeapon.weapons);
    final List<ToolItem> availableTools = effectiveFilter.applyTools(preset.tools);
    final List<Gun> availablePrimaries = effectiveFilter.applyPrimaryGuns(preset.primaries);
    final List<Gun> availableSpecials = effectiveFilter.applySpecialGuns(preset.specials);
    final List<Boosters> availableBoosters = effectiveFilter.applyBoosters(Boosters.values);
    Loadout createLoadout(int loadoutSeed) {
      final int loadoutEffectiveSeed = loadoutSeed & 0xFFFFFFFF;
      return Loadout(
        melee: availableMelees.pick(loadoutEffectiveSeed),
        tool: availableTools.pick(loadoutEffectiveSeed),
        primary: availablePrimaries.pick(loadoutEffectiveSeed),
        special: availableSpecials.pick(loadoutEffectiveSeed),
        boosters: availableBoosters.pickMultiple(loadoutEffectiveSeed),
      );
    }

    return GeneratedRun(
      effectiveSeed,
      rundown: rundown,
      mission: mission,
      sectors: sectors,
      players:
          rollWeapons
              ? PlayerPool(
                player1: createLoadout(runRandom.nextInt(0xFFFFFFFF)),
                player2: createLoadout(runRandom.nextInt(0xFFFFFFFF)),
                player3: createLoadout(runRandom.nextInt(0xFFFFFFFF)),
                player4: createLoadout(runRandom.nextInt(0xFFFFFFFF)),
              )
              : previous!.players,
    );
  }
}
