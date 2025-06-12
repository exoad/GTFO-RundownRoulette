import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:gtfo_rundown_roulette/utils/skeleton_object.dart';
import 'package:xrandom/xrandom.dart';

enum EffectLevel { low, medium, high, extreme }

class Effect {
  final String title;
  final String Function(Xrandom rng) description;
  final Widget icon;
  final bool isPositive;
  final EffectLevel level;

  static String _generatePlayers(Xrandom rng) {
    final int res = rng.nextInt(16);
    final StringBuffer buffer = StringBuffer();
    if ((res & 1) != 0) {
      buffer.write("→ Player 1\n");
    }
    if ((res & 2) != 0) {
      buffer.write("→ Player 2\n");
    }
    if ((res & 3) != 0) {
      buffer.write("→ Player 3\n");
    }
    if ((res & 4) != 0) {
      buffer.write("→ Player 4\n");
    }
    return buffer.toString();
  }

  /// the ids of the individual effects are based on their index
  static final List<Effect> builtin = <Effect>[
    Effect.negative(
      level: EffectLevel.extreme,
      title: "Tunnel Vision",
      icon: const Icon(CommunityMaterialIcons.eye_circle_outline),
      description: (Xrandom rng) {
        return "Listed players must set their FOV to the LOWEST.\nEffected players:\n${_generatePlayers(rng)}";
      },
    ),
    Effect.negative(
      level: EffectLevel.high,
      title: "Deafness",
      description: (Xrandom rng) {
        return "Listed players must mute ALL game audio.\nEffected players:\n${_generatePlayers(rng)}";
      },
      icon: const Icon(CommunityMaterialIcons.ear_hearing_off),
    ),
    Effect.negative(
      level: EffectLevel.extreme,
      title: "Unstable Cognition",
      description: (Xrandom rng) {
        return "[! THIS CAN CAUSE EYE STRAIN !]\nUse at own risk.\nAll players must set their FPS to the LOWEST.\n Effected players:\n${_generatePlayers(rng)}";
      },
      icon: const Icon(CommunityMaterialIcons.image_broken),
    ),
    Effect.positive(
      title: "Perceptual Acuity",
      description: (Xrandom rng) {
        return "All players must set their FOV to the HIGHEST.\n Effected players:\n${_generatePlayers(rng)}";
      },
      icon: const Icon(CommunityMaterialIcons.eye_plus),
      level: EffectLevel.low,
    ),
    Effect.noChange(
      title: "Contagion Susception",
      description: "Disinfection Packs & Stations CANNOT be used.",
      icon: const Icon(CommunityMaterialIcons.virus),
      level: EffectLevel.high,
      isPositive: false,  
    ),
  ];

  Effect({
    required this.title,
    required this.description,
    required this.icon,
    required this.isPositive,
    required this.level,
  });

  Effect.positive({
    required this.title,
    required this.description,
    required this.icon,
    required this.level,
  }) : isPositive = true;

  Effect.negative({
    required this.title,
    required this.description,
    required this.icon,
    required this.level,
  }) : isPositive = false;

  Effect.noChange({
    required this.title,
    required String description,
    required this.icon,
    required this.level,
    required this.isPositive,
  }) : description = ((_) => description);
}

class SkeletonEffect with SkeletonObject<Effect> {
  String? title;
  String Function(Xrandom rng)? description;
  Widget? icon;
  bool? isPositive;
  EffectLevel? level;

  @override
  Effect populate() {
    return Effect(
      level: level!,
      title: title!,
      description: description!,
      icon: icon!,
      isPositive: isPositive!,
    );
  }
}
