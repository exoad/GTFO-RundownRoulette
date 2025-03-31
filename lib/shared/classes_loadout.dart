import "package:equatable/equatable.dart";
import "package:rnd/rnd.dart";

typedef Melees = List<MeleeWeapon>;
typedef PrimaryGuns = List<Gun>;
typedef SpecialGuns = List<Gun>;
typedef Tools = List<ToolItem>;

class Loadout {
  final MeleeWeapon melee;
  final ToolItem tool;

  const Loadout({required this.melee, required this.tool});
}

sealed class LoadoutItem with EquatableMixin {
  final String assetPath;
  final String canonicalName;

  const LoadoutItem({required this.assetPath, required this.canonicalName});

  @override
  List<Object?> get props => <Object?>[assetPath, canonicalName];
}

final class MeleeWeapon extends LoadoutItem {
  const MeleeWeapon._({required super.assetPath, required super.canonicalName});

  factory MeleeWeapon.generate() => switch (rnd.nextInt(4)) {
    0 => const MeleeWeapon.knife(),
    2 => const MeleeWeapon.bat(),
    3 => const MeleeWeapon.spear(),
    _ => const MeleeWeapon.hammer(),
  };

  const MeleeWeapon.knife()
    : this._(assetPath: "assets/ingame/knife.png", canonicalName: "Knife");

  const MeleeWeapon.hammer()
    : this._(assetPath: "assets/ingame/hammer.png", canonicalName: "Sledgehammer");

  const MeleeWeapon.bat()
    : this._(assetPath: "assets/ingame/bat.png", canonicalName: "Bat");
  const MeleeWeapon.spear()
    : this._(assetPath: "assets/ingame/spear.png", canonicalName: "Spear");
}

enum GunFiremode { semi_auto, burst, auto }

final class Gun extends LoadoutItem with EquatableMixin {
  final GunFiremode firemode;
  final bool isSpecial;
  final bool isHEL;

  const Gun({
    required super.assetPath,
    required super.canonicalName,
    this.firemode = GunFiremode.semi_auto,
    required this.isHEL,
    required this.isSpecial,
  });

  bool get isPrimary => !isSpecial;

  @override
  List<Object?> get props => super.props..addAll(<Object?>[firemode, isSpecial, isHEL]);
}

final class ToolItem extends LoadoutItem {
  const ToolItem({required super.assetPath, required super.canonicalName});
}

enum Boosters { MUTED, AGGRESIVE, BOLD }
