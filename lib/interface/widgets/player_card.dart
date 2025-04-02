import 'package:flutter/material.dart';
import 'package:gtfo_rundown_roulette/shared/shared.dart';

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
      child: Container(
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          fit: StackFit.loose,
          children: <Widget>[
            Positioned.fill(
              child: Align(
                alignment: Alignment.topCenter,
                child: ClipRRect(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(8),
                    topLeft: Radius.circular(8),
                  ),
                  child: ShaderMask(
                    shaderCallback: (Rect rect) {
                      return const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[Color.fromARGB(24, 0, 0, 0), Colors.transparent],
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
                      style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w800),
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
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
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
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
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
                        _PlayerCardItem(<Widget>[
                          Text(
                            widget.loadout!.primary.canonicalName,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.loadout!.primary.gameName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Image.asset(
                            height: MediaQuery.sizeOf(context).height * 0.08,
                            widget.loadout!.primary.assetPath,
                          ),
                        ]),
                        _PlayerCardItem(<Widget>[
                          Text(
                            widget.loadout!.special.canonicalName,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.loadout!.special.gameName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Image.asset(
                            height: MediaQuery.sizeOf(context).height * 0.08,
                            widget.loadout!.special.assetPath,
                          ),
                        ]),
                        _PlayerCardItem(<Widget>[
                          Text(
                            widget.loadout!.tool.canonicalName,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Image.asset(
                            height: MediaQuery.sizeOf(context).height * 0.08,
                            widget.loadout!.tool.assetPath,
                          ),
                        ]),
                        _PlayerCardItem(<Widget>[
                          Text(
                            widget.loadout!.melee.canonicalName,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Image.asset(
                            height: MediaQuery.sizeOf(context).height * 0.08,
                            widget.loadout!.melee.assetPath,
                          ),
                        ]),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _PlayerCardItem extends StatelessWidget {
  final List<Widget> children;

  const _PlayerCardItem(this.children);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(40),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.only(top: 6, bottom: 2),
      child: Column(children: children),
    );
  }
}
