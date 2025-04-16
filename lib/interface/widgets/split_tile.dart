import 'package:flutter/material.dart';
import 'package:gtfo_rundown_roulette/public.dart';

/// a split tile basically is just a scrolling page with the following layout:
///
/// {label}                < ~~~ spacer ~~~ >         |child|
/// {description}          < ~~~ spacer ~~~ >         |child|
///
/// it is used for the settings dialog in the home page
///
/// a common left side component thus is the [SplitTileSingulateLabel] which
/// provides the exact layout above
class SplitTile extends StatelessWidget {
  final Map<Widget, Widget> children;

  const SplitTile(this.children, {super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: IntrinsicWidth(
        child: Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            for (MapEntry<Widget, Widget> entry in children.entries)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: 12,
                children: <Widget>[entry.key, entry.value],
              ),
          ],
        ),
      ),
    );
  }
}

class SplitTileSingulateLabel extends StatelessWidget {
  final String text;
  final String? description;

  const SplitTileSingulateLabel(this.text, {super.key, this.description});

  @override
  Widget build(BuildContext context) {
    final Widget title = Text(
      text,
      style: const TextStyle(
        fontFamily: "Shared Tech",
        fontSize: 18,
        color: PublicTheme.normalWhite,
      ),
    );
    return description == null
        ? title
        : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            title,
            const SizedBox(height: 4),
            Text(
              description!,
              style: const TextStyle(
                fontSize: 14,
                fontFamily: "Shared Tech",
                color: PublicTheme.normalWhite,
              ),
            ),
          ],
        );
  }
}
