import 'package:flutter/material.dart';
import 'package:gtfo_rundown_roulette/interface/widgets/core/normal_box.dart';
import 'package:gtfo_rundown_roulette/public.dart';
import 'package:gtfo_rundown_roulette/shared/shared.dart';

class LoadoutItemCard extends StatelessWidget {
  final LoadoutItem item;

  const LoadoutItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(item.canonicalName, style: const TextStyle(color: PublicTheme.hiddenGray, fontFamily: "Shared Tech", fontSize: 18)),
        UINormalBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[Image.asset(item.assetPath, height: 60), const SizedBox(height: 4), Text(item.gameName, style: const TextStyle(color: PublicTheme.hiddenGray))],
          ),
        ),
      ],
    );
  }
}
