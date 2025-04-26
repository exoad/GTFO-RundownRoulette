import 'package:equatable/equatable.dart';
import 'package:gtfo_rundown_roulette/shared/shared.dart';
import 'package:gtfo_rundown_roulette/utils/skeleton_object.dart';

typedef Rundowns = List<Rundown>;

class PlayerPool {
  final Loadout player1;
  final Loadout player2;
  final Loadout player3;
  final Loadout player4;

  PlayerPool({
    required this.player1,
    required this.player2,
    required this.player3,
    required this.player4,
  });
}

final class SkeletonPlayerPool with SkeletonObject<PlayerPool> {
  final SkeletonLoadout player1;
  final SkeletonLoadout player2;
  final SkeletonLoadout player3;
  final SkeletonLoadout player4;

  SkeletonPlayerPool()
    : player1 = SkeletonLoadout(),
      player2 = SkeletonLoadout(),
      player3 = SkeletonLoadout(),
      player4 = SkeletonLoadout();

  @override
  PlayerPool populate() {
    return PlayerPool(
      player1: player1.populate(),
      player2: player2.populate(),
      player3: player3.populate(),
      player4: player4.populate(),
    );
  }
}

enum Sector {
  main,
  secondary,
  overload;

  List<Sector> random() {
    final List<Sector> res = <Sector>[main];
    if (rnd.nextBool()) {
      res.add(secondary);
      if (rnd.nextBool()) {
        res.add(overload);
      }
    }
    return res;
  }
}

class Mission with EquatableMixin {
  final String canonicalName;
  final String tier;
  final int number;
  final bool isLore;
  final List<Sector> sectors;

  const Mission({
    required this.canonicalName,
    required this.tier,
    required this.number,
    this.isLore = false,
  }) : sectors = const <Sector>[Sector.main];

  const Mission.prisonerEfficiency({
    required this.canonicalName,
    required this.tier,
    this.isLore = false,
    required this.number,
  }) : sectors = const <Sector>[Sector.main, Sector.secondary, Sector.overload];

  const Mission.secondary({
    required this.canonicalName,
    required this.tier,
    required this.number,
    this.isLore = false,
  }) : sectors = const <Sector>[Sector.main, Sector.secondary];

  bool get hasPrisonerEfficiency => sectors.length == 3;

  List<Sector> generate() {
    final List<Sector> res = <Sector>[];
    if (sectors.contains(Sector.secondary) && rnd.nextBool()) {
      res.add(Sector.secondary);
    }
    if (sectors.contains(Sector.overload) && rnd.nextBool()) {
      res.add(Sector.overload);
    }
    return res;
  }

  @override
  List<Object?> get props => <Object?>[canonicalName, tier, number]..addAll(sectors);
}

class Rundown with EquatableMixin {
  final String canonicalName;
  final Map<String, List<Mission>> _missions;

  Rundown(this.canonicalName, Iterable<Mission> missions) : _missions = <String, List<Mission>>{} {
    for (Mission mission in missions) {
      String tier = mission.tier.toUpperCase();
      if (!_missions.containsKey(tier)) {
        _missions[tier] = <Mission>[mission];
      } else {
        _missions[tier]!.add(mission);
      }
    }
  }

  List<Mission> get allMissions => _missions.values.fold(
    List<Mission>.empty(growable: true),
    (List<Mission> c, List<Mission> m) => c..addAll(m),
  );

  List<Mission> findByTier(String tier) => _missions[tier.toUpperCase()]!;

  List<Mission>? tryFindByTier(String tier) => _missions[tier.toUpperCase()];

  @override
  List<Object?> get props => <Object?>[canonicalName, _missions];
}
