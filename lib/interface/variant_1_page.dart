import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gtfo_rundown_roulette/interface/current_run.dart';
import 'package:gtfo_rundown_roulette/shared/shared.dart';
import 'package:provider/provider.dart';

class Variant1RootScaffold extends StatelessWidget {
  const Variant1RootScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Variant 1 \"Generic\"")),
      body: const _ContentBody(),
    );
  }
}

class _ContentBody extends StatefulWidget {
  const _ContentBody();

  @override
  State<_ContentBody> createState() => _ContentBodyState();
}

class _ContentBodyState extends State<_ContentBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          spacing: 4,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Flexible(
              child: ExpansionTile(
                visualDensity: VisualDensity.comfortable,
                maintainState: true,
                title: Text(
                  "Rules & Description",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                controlAffinity: ListTileControlAffinity.leading,
                subtitle: Text("View rules if you want to."),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: Text.rich(
                      TextSpan(
                        children: <InlineSpan>[
                          TextSpan(
                            text: "1. Randomization of Rundown and Loadout: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                "After each successful run, both the rundown and the loadout will be randomized. The randomization process can utilize a dice or any other method to determine how many times the randomization should occur.\n\n",
                          ),
                          TextSpan(
                            text: "2. Rerolling Mechanism: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                "A majority vote can be used to trigger a reroll of the loadout or rundown. This can occur either once after the initial randomization or after a failed attempt.\n\n",
                          ),
                          TextSpan(
                            text: "3. Boosters: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                "Boosters are optional and not mandatory. If a player is unable to bring a specific tier of booster(s), they are allowed to forgo bringing any boosters at all.",
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            IntrinsicWidth(
              child: Column(
                spacing: 4,
                children: <Widget>[
                  Row(
                    spacing: 4,
                    children: <Widget>[
                      Tooltip(
                        message: "Randomize Loadout Only",
                        child: FloatingActionButton(
                          onPressed: () async {
                            try {
                              Provider.of<CurrentRun>(
                                context,
                                listen: false,
                              ).value = Variant1Generator.produceFrom(
                                Preset.vanilla,
                                false,
                                true,
                                Provider.of<CurrentRun>(context, listen: false).run,
                              );
                            } catch (error) {
                              await showDialog(
                                context: context,
                                builder:
                                    (BuildContext context) => AlertDialog(
                                      actions: <Widget>[
                                        FilledButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: const Text("Ok"),
                                        ),
                                      ],
                                      title: const Text(
                                        "Oh no!",
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      content: Text(error.toString()),
                                    ),
                              );
                            }
                          },
                          child: const Icon(CommunityMaterialIcons.pistol),
                        ),
                      ),
                      Tooltip(
                        message: "Randomize Everything",
                        child: FloatingActionButton(
                          onPressed:
                              () =>
                                  Provider.of<CurrentRun>(
                                    context,
                                    listen: false,
                                  ).value = Variant1Generator.produceFrom(Preset.vanilla),
                          child: const Icon(CommunityMaterialIcons.reload),
                        ),
                      ),
                    ],
                  ),
                  Tooltip(
                    message: "Randomize Rundown Only",
                    child: FloatingActionButton(
                      onPressed: () async {
                        try {
                          Provider.of<CurrentRun>(
                            context,
                            listen: false,
                          ).value = Variant1Generator.produceFrom(
                            Preset.vanilla,
                            true,
                            false,
                            Provider.of<CurrentRun>(context, listen: false).run,
                          );
                        } catch (error) {
                          await showDialog(
                            context: context,
                            builder:
                                (BuildContext context) => AlertDialog(
                                  actions: <Widget>[
                                    FilledButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("Ok"),
                                    ),
                                  ],
                                  title: const Text(
                                    "Oh no!",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  content: Text(error.toString()),
                                ),
                          );
                        }
                      },
                      child: const Icon(CommunityMaterialIcons.account_hard_hat),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    Provider.of<CurrentRun>(context).run == null
                        ? const EdgeInsets.symmetric(horizontal: 8)
                        : EdgeInsets.zero,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color:
                        AdaptiveTheme.of(
                          context,
                        ).theme.buttonTheme.colorScheme?.onPrimary,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child:
                      Provider.of<CurrentRun>(context).run == null
                          ? const SizedBox()
                          : Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                    Provider.of<CurrentRun>(
                                      context,
                                    ).run!.mission.canonicalName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 22,
                                    ),
                                  )
                                  .animate(autoPlay: true)
                                  .fade(duration: const Duration(milliseconds: 550)),
                              const SizedBox(height: 4),
                              Text(
                                    Provider.of<CurrentRun>(
                                      context,
                                    ).run!.rundown.canonicalName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  )
                                  .animate(autoPlay: true)
                                  .fade(duration: const Duration(milliseconds: 550)),
                              const SizedBox(height: 6),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                spacing: 6,
                                children: <Widget>[
                                  Tooltip(
                                        message: "MAIN",
                                        child: Image.asset(
                                          "assets/ingame/sector_main.png",
                                          width: 48,
                                        ),
                                      )
                                      .animate(autoPlay: true)
                                      .fade(duration: const Duration(milliseconds: 400)),
                                  if (Provider.of<CurrentRun>(
                                    context,
                                  ).run!.sectors.contains(Sector.secondary))
                                    Tooltip(
                                          message: "SECONDARY",
                                          child: Image.asset(
                                            "assets/ingame/sector_secondary.png",
                                            width: 48,
                                          ),
                                        )
                                        .animate(autoPlay: true)
                                        .fade(
                                          duration: const Duration(milliseconds: 400),
                                          delay: const Duration(milliseconds: 300),
                                        ),
                                  if (Provider.of<CurrentRun>(
                                    context,
                                  ).run!.sectors.contains(Sector.overload))
                                    Tooltip(
                                          message: "OVERLOAD",
                                          child: Image.asset(
                                            "assets/ingame/sector_overload.png",
                                            width: 48,
                                          ),
                                        )
                                        .animate(autoPlay: true)
                                        .fade(
                                          duration: const Duration(milliseconds: 400),
                                          delay: const Duration(milliseconds: 480),
                                        ),
                                  if (Provider.of<CurrentRun>(
                                        context,
                                      ).run!.sectors.contains(Sector.secondary) &&
                                      Provider.of<CurrentRun>(
                                        context,
                                      ).run!.sectors.contains(Sector.overload))
                                    Tooltip(
                                          message: "PRISONER EFFICIENCY",
                                          child: Image.asset(
                                            "assets/ingame/prisoner_efficiency.png",
                                            width: 48,
                                          ),
                                        )
                                        .animate(autoPlay: true)
                                        .fade(
                                          duration: const Duration(milliseconds: 400),
                                          delay: const Duration(milliseconds: 500),
                                        ),
                                ],
                              ),
                            ],
                          ),
                ),
              ),
            ),
          ],
        ),
        const Divider(),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: _PlayerCard(
                  title: "Player 1",
                  name: "Woods",
                  bgImage: "assets/ingame/woods.png",
                  color: const Color.fromARGB(255, 116, 46, 66),
                  loadout: Provider.of<CurrentRun>(context).run?.players.player1,
                ),
              ),
              Expanded(
                child: _PlayerCard(
                  title: "Player 2",
                  name: "Dauda",
                  bgImage: "assets/ingame/dauda.png",
                  color: const Color.fromARGB(255, 32, 92, 48),
                  loadout: Provider.of<CurrentRun>(context).run?.players.player2,
                ),
              ),
              Expanded(
                child: _PlayerCard(
                  title: "Player 3",
                  name: "Hackett",
                  bgImage: "assets/ingame/hackett.png",
                  color: const Color.fromARGB(255, 22, 61, 100),
                  loadout: Provider.of<CurrentRun>(context).run?.players.player3,
                ),
              ),
              Expanded(
                child: _PlayerCard(
                  title: "Player 4",
                  name: "Bishop",
                  bgImage: "assets/ingame/bishop.png",
                  color: const Color.fromARGB(255, 76, 17, 120),
                  loadout: Provider.of<CurrentRun>(context).run?.players.player4,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class _PlayerCard extends StatefulWidget {
  final String title;
  final String name;
  final String bgImage;
  final Color color;
  final Loadout? loadout;

  const _PlayerCard({
    required this.title,
    required this.name,
    required this.bgImage,
    required this.color,
    this.loadout,
  });

  @override
  State<_PlayerCard> createState() => _PlayerCardState();
}

class _PlayerCardState extends State<_PlayerCard> with TickerProviderStateMixin {
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
                            colors: <Color>[
                              Color.fromARGB(24, 0, 0, 0),
                              Colors.transparent,
                            ],
                          ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                        },
                        blendMode: BlendMode.dstIn,
                        child: Image.asset(
                          widget.bgImage,
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
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
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
          )
          .animate()
          .fadeIn(
            delay: const Duration(milliseconds: 80) * (rnd.nextDouble() + 1.56),
            duration: const Duration(milliseconds: 320),
            curve: Curves.easeIn,
          )
          .slideY(
            begin: -0.12,
            duration: const Duration(milliseconds: 340),
            curve: Curves.easeIn,
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
