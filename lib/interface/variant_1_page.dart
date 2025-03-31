import 'package:flutter/material.dart';
import 'package:gtfo_rundown_roulette/interface/current_run.dart';
import 'package:gtfo_rundown_roulette/shared/classes_runs.dart';
import 'package:gtfo_rundown_roulette/shared/generated.dart';
import 'package:gtfo_rundown_roulette/shared/generator.dart';
import 'package:provider/provider.dart';

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
              child:
                  Provider.of<CurrentRun>(context).run == null
                      ? const SizedBox()
                      : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            Provider.of<CurrentRun>(context).run!.mission.canonicalName,
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 22,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Tooltip(
                                message: "MAIN",
                                child: Image.asset(
                                  "assets/ingame/sector_main.png",
                                  width: 48,
                                  height: 48,
                                  cacheWidth: 48,
                                  cacheHeight: 48,
                                ),
                              ),
                              if (Provider.of<CurrentRun>(
                                context,
                              ).run!.sectors.contains(Sector.secondary))
                                Tooltip(
                                  message: "SECONDARY",
                                  child: Image.asset(
                                    "assets/ingame/sector_secondary.png",
                                    width: 48,
                                    height: 48,
                                    cacheWidth: 48,
                                    cacheHeight: 48,
                                  ),
                                ),
                              if (Provider.of<CurrentRun>(
                                context,
                              ).run!.sectors.contains(Sector.overload))
                                Tooltip(
                                  message: "OVERLOAD",
                                  child: Image.asset(
                                    "assets/ingame/sector_overload.png",
                                    width: 48,
                                    height: 48,
                                    cacheWidth: 48,
                                    cacheHeight: 48,
                                  ),
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
                                    height: 48,
                                    cacheWidth: 48,
                                    cacheHeight: 48,
                                  ),
                                ),
                            ],
                          ),
                        ],
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
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 194, 107, 149),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.construction),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 66, 194, 100),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.construction),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 52, 114, 224),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.construction),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 115, 61, 209),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.construction),
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
