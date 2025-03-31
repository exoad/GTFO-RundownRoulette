import 'dart:ui';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gtfo_rundown_roulette/interface/current_run.dart';
import 'package:gtfo_rundown_roulette/shared/classes_runs.dart';
import 'package:gtfo_rundown_roulette/shared/generated.dart';
import 'package:gtfo_rundown_roulette/shared/generator.dart';
import 'package:gtfo_rundown_roulette/shared/shared.dart';
import 'package:provider/provider.dart';
import 'package:rnd/rnd.dart';

class Variant1RootScaffold extends StatelessWidget {
  const Variant1RootScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Variant 1 \"Generic\"")),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.replay_rounded),
        onPressed:
            () =>
                Provider.of<CurrentRun>(
                  context,
                  listen: false,
                ).value = Variant1Generator.produceFrom(Preset.vanilla),
      ),
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
        const Padding(padding: EdgeInsets.only(bottom: 10), child: Divider()),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 8,
            children: <Widget>[
              const SizedBox(),
              Expanded(
                child: _PlayerCard(
                  name: "Woods",
                  bgImage: "assets/ingame/woods.png",
                  color: const Color.fromARGB(255, 223, 88, 126),
                  loadout: Provider.of<CurrentRun>(context).run?.players.player1,
                ),
              ),
              Expanded(
                child: _PlayerCard(
                  name: "Dauda",
                  bgImage: "assets/ingame/dauda.png",
                  color: const Color.fromARGB(255, 66, 194, 100),
                  loadout: Provider.of<CurrentRun>(context).run?.players.player2,
                ),
              ),
              Expanded(
                child: _PlayerCard(
                  name: "Hackett",
                  bgImage: "assets/ingame/hackett.png",
                  color: const Color.fromARGB(255, 36, 108, 180),
                  loadout: Provider.of<CurrentRun>(context).run?.players.player3,
                ),
              ),
              Expanded(
                child: _PlayerCard(
                  name: "Bishop",
                  bgImage: "assets/ingame/bishop.png",
                  color: const Color.fromARGB(255, 134, 33, 212),
                  loadout: Provider.of<CurrentRun>(context).run?.players.player4,
                ),
              ),
              const SizedBox(),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class _PlayerCard extends StatelessWidget {
  final String name;
  final String bgImage;
  final Color color;
  final Loadout? loadout;

  const _PlayerCard({
    required this.name,
    required this.bgImage,
    required this.color,
    this.loadout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
          child: Stack(
            children: <Widget>[
              ClipRRect(
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
                      colors: <Color>[Color.fromARGB(104, 0, 0, 0), Colors.transparent],
                    ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                  },
                  blendMode: BlendMode.dstIn,
                  child: Image.asset(bgImage, filterQuality: FilterQuality.low),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Transform.rotate(
                  angle: 45,
                  child: Opacity(
                    opacity: 0.36,
                    child: Text(
                      name,
                      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
              ),
              if (loadout != null)
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: <Widget>[
                        Text.rich(
                          TextSpan(
                            children: <InlineSpan>[
                              const TextSpan(
                                text: "Melee: ",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                              TextSpan(
                                text: loadout!.melee.canonicalName,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Image.asset(
                          height: MediaQuery.sizeOf(context).height * 0.12,
                          loadout!.melee.assetPath,
                        ),
                        const SizedBox(height: 10),
                        Text.rich(
                          TextSpan(
                            children: <InlineSpan>[
                              const TextSpan(
                                text: "Tool: ",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                              TextSpan(
                                text: loadout!.tool.canonicalName,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Image.asset(
                          width: MediaQuery.sizeOf(context).height * 0.18,
                          loadout!.tool.assetPath,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        )
        .animate(autoPlay: true)
        .fadeIn(
          delay: const Duration(milliseconds: 80) * (rnd.nextDouble() + 1.56),
          duration: const Duration(milliseconds: 320),
          curve: Curves.easeIn,
        )
        .slideY(
          begin: -0.12,
          duration: const Duration(milliseconds: 340),
          curve: Curves.easeIn,
        );
  }
}
