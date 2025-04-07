import 'package:flutter/material.dart';
import 'package:gtfo_rundown_roulette/interface/widgets/core/normal_box.dart';
import 'package:gtfo_rundown_roulette/interface/widgets/loadout_item_card.dart';
import 'package:gtfo_rundown_roulette/main.dart';
import 'package:gtfo_rundown_roulette/public.dart';
import 'package:gtfo_rundown_roulette/shared/shared.dart';
import 'package:gtfo_rundown_roulette/utils/shared_preferences.dart';

/// The actual player display. It is not anything special and just displays the backdrop and the loadout
/// using [LoadoutItemCard]s.
class PlayerCard extends StatefulWidget {
  /// Is the actual player name, but since there is nothing to connect the game with this app, it is left as placeholders like "Player 1" or "Player 2".
  final String title;

  /// This usually refers to the canonical name of the player position in relation to the actual in game characters like Dauda.
  final String name;

  /// The background image to use. Usually a prefab of the character's default loadout like Hackett, Bishop, Dauda, and Woods.
  final String bgImage;
  final Color color;

  /// Not required by default if no rolls has been called. If this is `null`, then no [LoadoutItemCard]s are appended.
  final Loadout? loadout;

  const PlayerCard({
    super.key,
    required this.title,
    required this.name,
    required this.bgImage,
    required this.color,
    this.loadout,
  });

  @override
  State<PlayerCard> createState() => PlayerCardState();
}

class PlayerCardState extends State<PlayerCard> with TickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      // i dont really know why i have this here or why this is even necessary ??
      animationBehavior: AnimationBehavior.preserve,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(fontFamily: "Shared Tech"),
      child: Stack(
        // here the backdrop of the bgImage is on the backside
        // the name of the player is laid out in between the back and front sides.
        // the actual information like loadout cards are on the frontside
        //
        // [background image] -> [canonical player name] -> [loadout information]
        fit: StackFit.loose,
        children: <Widget>[
          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              child: ClipRRect(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: ShaderMask(
                  shaderCallback: (Rect rect) {
                    // we use a gradient here to try and hide the abrupt ending of the images in order to give it a more natural look.
                    // the gradient is sharpest (but there are still some darkening) at the top and fades out to black/full-transparent at the bottom or near the width of the image
                    return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[Color.fromARGB(118, 0, 0, 0), Colors.transparent],
                    ).createShader(
                      Rect.fromLTRB(0, 0, rect.width, rect.height),
                    ); // this linear gradient does cause troubles with web rendering though, thats one thing to note. very harsh edges where the filter is misaligned on web. flutter and skia issue
                  },
                  blendMode: BlendMode.dstIn,
                  child: Image.asset(
                    widget.bgImage,
                    // we dont need that much quality, so we save on performance by using low filterquality which means when scaling up, there are no anti-aliasing to be done to smooth out the pixels.
                    filterQuality: FilterQuality.low,
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Transform.rotate(
                angle: 45,
                child: Opacity(
                  opacity: 0.22,
                  child: Text(
                    widget.name,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color:
                          kPrefs.getSafeBool("color_lobby")
                              ? widget.color
                              : PublicTheme.normalWhite,
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (widget.loadout != null)
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  child: IntrinsicWidth(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      spacing: 4,
                      children: <Widget>[
                        Row(
                          spacing: 6,
                          children: <Widget>[
                            Text(
                              widget.title,
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color:
                                    kPrefs.getSafeBool("color_lobby")
                                        ? widget.color
                                        : PublicTheme.normalWhite,
                              ),
                            ),
                            if (widget.loadout!.boosters.contains(Boosters.MUTED))
                              Image.asset("assets/ingame/muted.png", width: 32),
                            if (widget.loadout!.boosters.contains(Boosters.BOLD))
                              Image.asset("assets/ingame/bold.png", width: 32),
                            if (widget.loadout!.boosters.contains(Boosters.AGGRESIVE))
                              Image.asset("assets/ingame/aggressive.png", width: 32),
                          ],
                        ),
                        const SizedBox(height: 4),
                        LoadoutItemCard(
                          intrinsic: true,
                          item: widget.loadout!.primary,
                          style: const TextStyle(
                            fontFamily: "Shared Tech",
                            color: PublicTheme.normalWhite,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          backgroundColor: PublicTheme.murkyDarkGrey.withAlpha(180),
                        ),
                        LoadoutItemCard(
                          intrinsic: true,
                          item: widget.loadout!.special,
                          style: const TextStyle(
                            fontFamily: "Shared Tech",
                            color: PublicTheme.normalWhite,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          backgroundColor: PublicTheme.murkyDarkGrey.withAlpha(180),
                        ),
                        LoadoutItemCard(
                          intrinsic: true,
                          item: widget.loadout!.tool,
                          style: const TextStyle(
                            fontFamily: "Shared Tech",
                            color: PublicTheme.normalWhite,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          backgroundColor: PublicTheme.murkyDarkGrey.withAlpha(180),
                        ),
                        LoadoutItemCard(
                          intrinsic: true,
                          item: widget.loadout!.melee,
                          style: const TextStyle(
                            fontFamily: "Shared Tech",
                            color: PublicTheme.normalWhite,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          backgroundColor: PublicTheme.murkyDarkGrey.withAlpha(180),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _PlayerCardItem extends StatefulWidget {
  final List<Widget> children;

  const _PlayerCardItem(this.children);

  @override
  State<_PlayerCardItem> createState() => _PlayerCardItemState();
}

class _PlayerCardItemState extends State<_PlayerCardItem> {
  @override
  Widget build(BuildContext context) {
    return UINormalBox(
      child: Padding(
        padding: const EdgeInsets.only(top: 6, bottom: 2),
        child: Column(children: widget.children),
      ),
    );
  }
}
