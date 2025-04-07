import 'package:flutter/material.dart';
import 'package:gtfo_rundown_roulette/interface/widgets/core/normal_box.dart';
import 'package:gtfo_rundown_roulette/public.dart';
import 'package:gtfo_rundown_roulette/shared/shared.dart';

/// Represents the loadout item which is a single card that is recreated to match the actual look
/// and feel within the official game.
///
/// It is not exact though.
class LoadoutItemCard extends StatelessWidget {
  final LoadoutItem item;
  final TextStyle? style;
  final TextStyle? gameNameStyle;

  /// This is for determining whether this loadout card is used in a [Column]. If it is, then it means all loadout cards will have the same width in the [Column] by using an [IntrinsicWidth]
  final bool intrinsic;
  final Color? backgroundColor;

  const LoadoutItemCard({
    super.key,
    required this.item,
    this.style,
    this.backgroundColor,
    this.gameNameStyle,
    this.intrinsic = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget child = Column(
      crossAxisAlignment: intrinsic ? CrossAxisAlignment.stretch : CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          item.canonicalName,
          style:
              style ??
              const TextStyle(
                color: PublicTheme.hiddenGray,
                fontFamily: "Shared Tech",
                fontSize: 18,
              ),
        ),
        UINormalBox(
          backgroundColor: backgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // the height here is just guessed and does not represent the real laf from the game
              Image.asset(item.assetPath, height: MediaQuery.sizeOf(context).height * 0.08),
              const SizedBox(height: 4),
              Text(
                item.gameName, // most of the time gameNameStyle is never supplied and the default laf is used which is recreated from the game's looks.
                style: gameNameStyle ?? const TextStyle(color: PublicTheme.hiddenGray),
              ),
            ],
          ),
        ),
      ],
    );
    return intrinsic ? IntrinsicWidth(child: child) : child;
  }
}
