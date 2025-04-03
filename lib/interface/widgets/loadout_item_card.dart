import 'package:flutter/material.dart';
import 'package:gtfo_rundown_roulette/interface/widgets/core/normal_box.dart';
import 'package:gtfo_rundown_roulette/public.dart';
import 'package:gtfo_rundown_roulette/shared/shared.dart';

class LoadoutItemCard extends StatelessWidget {
  final LoadoutItem item;
  final TextStyle? style;
  final TextStyle? gameNameStyle;
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
              Image.asset(item.assetPath, height: MediaQuery.sizeOf(context).height * 0.08),
              const SizedBox(height: 4),
              Text(
                item.gameName,
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
