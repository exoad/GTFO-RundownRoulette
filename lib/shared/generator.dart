import 'dart:math';

import 'package:gtfo_rundown_roulette/shared/shared.dart';
import 'package:gtfo_rundown_roulette/utils/seeded_generator.dart';
import 'package:xrandom/xrandom.dart';

extension IterableRandomExtension<T> on List<T> {
  /// selects an element from `this` list
  T pick([int? seed]) {
    return SeededGenerator.pickFrom(this, 1, seed).picked.first;
  }

  /// goes through `this` list and adds it to a resulting list if a rolling
  /// [seed] is rolled to be `true`.
  ///
  /// the resulting list ranges from nothing to all elements in the array both of
  /// which are equally rare (prng)
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
        // pattern matching is nice
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
/// literally just another wrapper thrown by anything within the variant 1 generation process
///
/// it contains a single value [message] that will be printed out for the error
///
/// see: [Error] and [GeneratorFilter]
class FilterInvarianceError extends Error {
  /// description of the thing that went wrong or a help message
  final String message;
  @pragma("vm:entry-point")
  FilterInvarianceError(this.message);
  @override
  String toString() => message;
}

/// a filter is a data class that holds what items to prevent the generator from picking
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

  /// the default value where everything is available for the generator to choose from
  static const GeneratorFilter unblocked = GeneratorFilter(
    blockedMelees: <MeleeWeapon>{},
    blockedMissions: <Mission>{},
    blockedPrimaries: <Gun>{},
    blockedSpecials: <Gun>{},
    blockedTools: <ToolItem>{},
    blockedBoosters: <Boosters>{},
  );

  // == these functions here check if a value is not blocked ==
  // == basically asking is "x" blocked ?                    ==

  bool isValidMission(Mission mission) => !blockedMissions.contains(mission);
  bool isValidBooster(Boosters booster) => !blockedBoosters.contains(booster);
  bool isValidPrimary(Gun gun) => !blockedPrimaries.contains(gun);
  bool isValidSpecial(Gun gun) => !blockedSpecials.contains(gun);
  bool isValidTool(ToolItem tool) => !blockedTools.contains(tool);
  bool isValidMelee(MeleeWeapon melee) => !blockedMelees.contains(melee);

  /// checks if this filter is blocking anything
  bool get isBlocking =>
      blockedBoosters.isNotEmpty ||
      blockedMissions.isNotEmpty ||
      blockedPrimaries.isNotEmpty ||
      blockedSpecials.isNotEmpty ||
      blockedTools.isNotEmpty ||
      blockedMelees.isNotEmpty;

  /// removes all items being blocked
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

  /// applies a filter for primary guns
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

  /// applies a filter for special weapons
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

  /// applies a filter for tools
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

  /// applies a filter for melee weapons
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

  /// applies a filter for missions
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

/// the variant 1 is just a simple randomizer that can use a filter to decide which items to randomly
/// choose and which to ignore. it is the most generic randomizer for choose rundowns and loadouts
///
/// the [RunGenerator.produceFrom] is the defacto function to use.
class RunGenerator {
  /// if [seed] is not provided, then one is generated using [SeededGenerator.seedFromTimeMS] and truncated
  /// to 32 bits to work for the generator.
  ///
  /// [filter] see [GeneratorFilter] on its usage and how to block certain items.
  ///
  /// [rollRundowns] and [rollWeapons] decides on whether [previous]'s values should be preserved. this means that
  /// [previous] needs to be provided (ie not null) in order to be effective. if [previous] is not provided, then
  /// [rollWeapons] and [rollRundown] should either all be `true` or left alone.
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
    // this is the hollistic seed that we use for everything to make sure everything stays the same
    //
    // if we didnt do it this way, the generator would produce seeding for each loadout with a unique seed
    // additionally, we also need to consider seeding the seeds differently for each loadout because if we use
    // the effectiveSeed exactly, the loadouts will all be the same. to see this, look at the nested function createLoadout below
    final int effectiveSeed = (seed ?? SeededGenerator.seedFromTimeMS) & 0xFFFFFFFF;
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
    // this nested function is crucial in making sure all of the weapons are picked independently from each
    // other, if not all the loadouts will have the same seed AND the same weapons.
    //
    // the goal of this function is to get the same seed BUT different weapons
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
