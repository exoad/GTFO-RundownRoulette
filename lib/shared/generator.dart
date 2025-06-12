import 'dart:math';

import 'package:gtfo_rundown_roulette/shared/shared.dart';
import 'package:gtfo_rundown_roulette/utils/seeded_generator.dart';
import 'package:xrandom/xrandom.dart';

extension IterableRandomExtension<T> on List<T> {
  T pick([int? seed]) {
    final Xrandom rng = seed != null ? Xrandom(seed) : Xrandom(Random().nextInt(0xFFFFFFFF));
    return SeededGenerator.pickFrom(this, 1, rng.nextInt(0xFFFFFFFF)).picked.first;
  }

  /// goes through `this` list and adds it to a resulting list if a rolling
  /// [seed] is rolled to be `true`.
  ///
  /// the resulting list ranges from nothing to all elements in the array both of
  /// which are equally rare (prng)
  List<T> pickMultiple([int? seed]) {
    final List<T> res = <T>[];
    // Use the provided seed, or a new truly random one if not provided.
    final Xrandom rng = seed != null ? Xrandom(seed) : Xrandom(Random().nextInt(0xFFFFFFFF));
    for (int i = 0; i < length; i++) {
      if (rng.nextBool()) {
        res.add(this[i]);
      }
    }
    return res;
  }

  List<T> pickUntil(int maxLength, [int? seed]) {
    final List<T> res = <T>[];
    final Xrandom rng = seed != null ? Xrandom(seed) : Xrandom(Random().nextInt(0xFFFFFFFF));
    final int effectiveMaxLength = min(maxLength, length);
    for (int i = 0; i < length; i++) {
      if (res.length >= effectiveMaxLength) {
        break;
      }
      if (rng.nextBool()) {
        res.add(this[i]);
      }
    }
    return res;
  }

  List<T> pickMultipleWithBias(int minLength, [bool allowDuplicates = false]) {
    if (isEmpty || minLength <= 0) {
      return <T>[];
    }
    final Random random = Random();
    late int subsetSize;
    if (length <= minLength) {
      subsetSize = length;
    } else {
      final double randomNumber = random.nextDouble();
      subsetSize = switch (randomNumber) {
        < 0.1331 => minLength,
        < 0.3291 => minLength + 1,
        < 0.4313 when length > minLength + 1 => minLength + 2,
        _ => minLength + random.nextInt(length - minLength + 1),
      };
      subsetSize = min(subsetSize, length);
    }
    if (allowDuplicates) {
      final List<T> result = <T>[];
      for (int i = 0; i < subsetSize; i++) {
        result.add(this[random.nextInt(length)]);
      }
      return result;
    }
    return (List<T>.from(this)..shuffle(random)).take(subsetSize).toList();
  }
}

@pragma("vm:entry-point")
class FilterInvarianceError extends Error {
  final String message;
  @pragma("vm:entry-point")
  FilterInvarianceError(this.message);
  @override
  String toString() => message;
}

class GeneratorFilter {
  final Set<Mission> blockedMissions;
  final Set<Gun> blockedPrimaries;
  final Set<Gun> blockedSpecials;
  final Set<ToolItem> blockedTools;
  final Set<MeleeWeapon> blockedMelees;
  final Set<Boosters> blockedBoosters;

  const GeneratorFilter({
    required this.blockedMissions,
    required this.blockedPrimaries,
    required this.blockedSpecials,
    required this.blockedTools,
    required this.blockedMelees,
    required this.blockedBoosters,
  });

  static const GeneratorFilter unblocked = GeneratorFilter(
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

  bool get isBlocking =>
      blockedBoosters.isNotEmpty ||
      blockedMissions.isNotEmpty ||
      blockedPrimaries.isNotEmpty ||
      blockedSpecials.isNotEmpty ||
      blockedTools.isNotEmpty ||
      blockedMelees.isNotEmpty;

  void clear() {
    blockedMelees.clear();
    blockedBoosters.clear();
    blockedMissions.clear();
    blockedPrimaries.clear();
    blockedSpecials.clear();
    blockedTools.clear();
  }

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
      throw FilterInvarianceError(
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
      throw FilterInvarianceError(
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
      throw FilterInvarianceError(
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
      throw FilterInvarianceError(
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
      throw FilterInvarianceError(
        "Filtering missions cannot result in an empty list! Unblock at least one mission to continue.",
      );
    }
    return filtered;
  }
}

class RunGenerator {
  static GeneratedRun produceFrom(
    Preset preset, [
    bool rollRundown = true,
    bool rollWeapons = true,
    GeneratedRun? previous,
    GeneratorFilter? filter,
    int? seed,
  ]) {
    if ((!rollRundown || !rollWeapons) && previous == null) {
      throw ArgumentError(
        "Cannot not roll without providing a basis of the previous generated run!",
      );
    }
    final int effectiveSeed = seed ?? Random().nextInt(0xFFFFFFFF);
    final Xrandom runRandom = Xrandom(effectiveSeed);
    Rundown? rundown;
    Mission? mission;
    List<Sector>? sectors;
    final GeneratorFilter effectiveFilter = filter ?? GeneratorFilter.unblocked;
    if (rollRundown) {
      List<Rundown> availableRundowns = preset.rundowns;
      rundown = availableRundowns.pick(runRandom.nextInt(0xFFFFFFFF));
      List<Mission> availableMissions = effectiveFilter.applyMissions(rundown.allMissions);
      if (availableMissions.isEmpty) {
        throw FilterInvarianceError(
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
    Loadout createLoadout() {
      final int loadoutBaseSeed = runRandom.nextInt(0xFFFFFFFF);
      return Loadout(
        melee: availableMelees.pick(loadoutBaseSeed),
        tool: availableTools.pick(loadoutBaseSeed + 1),
        primary: availablePrimaries.pick(loadoutBaseSeed + 2),
        special: availableSpecials.pick(loadoutBaseSeed + 3),
        boosters: availableBoosters.pickMultiple(loadoutBaseSeed + 4),
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
                player1: createLoadout(),
                player2: createLoadout(),
                player3: createLoadout(),
                player4: createLoadout(),
              )
              : previous!.players,
    );
  }
}
