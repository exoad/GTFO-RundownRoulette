import 'package:flutter/material.dart';
import 'package:gtfo_rundown_roulette/interface/widgets/core/normal_box.dart';
import 'package:gtfo_rundown_roulette/interface/widgets/loadout_item_card.dart';
import 'package:gtfo_rundown_roulette/main.dart';
import 'package:gtfo_rundown_roulette/public.dart';
import 'package:gtfo_rundown_roulette/shared/shared.dart';
import 'package:gtfo_rundown_roulette/utils/shared_preferences.dart';

class PlayerCard extends StatefulWidget {
  final String title;
  final String name;
  final String bgImage;
  final Color color;
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
      animationBehavior: AnimationBehavior.preserve,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(fontFamily: "Shared Tech"),
      child: Stack(
        fit: StackFit.loose,
        children: <Widget>[
          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              child: ClipRRect(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: ShaderMask(
                  shaderCallback: (Rect rect) {
                    return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[Color.fromARGB(118, 0, 0, 0), Colors.transparent],
                    ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                  },
                  blendMode: BlendMode.dstIn,
                  child: Image.asset(widget.bgImage, filterQuality: FilterQuality.low),
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
