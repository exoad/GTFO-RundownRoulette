import 'package:flutter/material.dart';
import 'package:gtfo_rundown_roulette/interface/widgets/core/normal_box.dart';
import 'package:gtfo_rundown_roulette/public.dart';

class Variant2Page extends StatelessWidget {
  const Variant2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(padding: EdgeInsets.all(6), child: _ContentBody());
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
          children: <Widget>[
            UINormalBoxButton(
              foregroundColor: PublicTheme.highlightOrange,
              child: const Text("USAGE INFO"),
              onTap:
                  () async => await showDialog(
                    context: context,
                    builder:
                        (BuildContext context) => AlertDialog(
                          actions: <Widget>[
                            UINormalBoxButton(
                              child: const Text("Ok"),
                              onTap: () => Navigator.pop(context),
                            ),
                          ],
                          title: const Text("Auction Style Randomizer"),
                          content: SingleChildScrollView(
                            child: SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.66,
                              child: const Padding(
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
                                            "\nPlayers select their loadout from a given pool of weapons. Rundown can be chosen to be revealed after or at the same time.\n\n",
                                      ),
                                      TextSpan(
                                        text: "2. Rerolling Mechanism: ",
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text:
                                            "\nA majority vote can be used to trigger a reroll of the loadout or rundown. This can occur either once after the initial randomization or after a failed attempt.\n\n",
                                      ),
                                      TextSpan(
                                        text: "3. Boosters: ",
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text:
                                            "\nBoosters are optional and not mandatory. If a player is unable to bring a specific tier of booster(s), they are allowed to forgo bringing any boosters at all.",
                                      ),
                                    ],
                                  ),
                                  style: TextStyle(
                                    color: PublicTheme.loreYellow,
                                    fontFamily: "Shared Tech",
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
