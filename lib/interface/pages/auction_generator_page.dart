import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gtfo_rundown_roulette/interface/provider/current_skeleton_run.dart';
import 'package:gtfo_rundown_roulette/interface/widgets/core/normal_box.dart';
import 'package:gtfo_rundown_roulette/public.dart';
import 'package:gtfo_rundown_roulette/shared/shared.dart';
import 'package:gtfo_rundown_roulette/utils/scheduler.dart';
import 'package:provider/provider.dart';

class AuctionGeneratorPage extends StatelessWidget {
  const AuctionGeneratorPage({super.key});

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
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[_InformationRow(), Spacer(), _PageLoader(), Spacer()],
    );
  }
}

// holds all of the page switching and other related functionalities
class _PageLoader extends StatefulWidget {
  const _PageLoader();

  @override
  State<_PageLoader> createState() => _PageLoaderState();
}

// individual pages are loaded in a very brute force manner by just modifying an index
// and looking up the appropriate page to display
class _PageLoaderState extends State<_PageLoader> with AutomaticKeepAliveClientMixin {
  int _loadedIndex = 0;
  double _opacity = 0.0;
  bool _rolling = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() => _opacity = 1.0));
  }

  @pragma("vm:prefer-inline")
  void _advanceBy(final int r) {
    _loadedIndex += r;
    _triggerPageChange();
  }

  @pragma("vm:prefer-inline")
  void _goTo(final int r) {
    _loadedIndex = r;
    _triggerPageChange();
  }

  void _triggerPageChange([void Function()? action]) {
    setState(() => _opacity = 0.0);
    if (action != null) {
      Future<void>.delayed(
        const Duration(milliseconds: 100),
        () => setState(() => _opacity = 1.0),
      ).then(
        (_) => Future<void>.delayed(const Duration(milliseconds: 100), () {
          setState(() => _rolling = true);
          Scheduler.reductiveRelay(
            action,
            rnd.nextInt(14) + 1,
            rnd.nextBool() ? 120 + rnd.nextInt(100) + 40 : 120 - (rnd.nextInt(60)),
            120,
          ).then((_) {
            if (context.mounted) {
              setState(() => _rolling = false);
            }
          });
        }),
      );
    } else {
      Future<void>.delayed(const Duration(milliseconds: 100), () => setState(() => _opacity = 1.0));
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AnimatedOpacity(
      opacity: _opacity,
      duration: const Duration(milliseconds: 300),
      child: DefaultTextStyle(
        style: const TextStyle(fontFamily: "Shared Tech", color: PublicTheme.normalWhite),
        child: switch (_loadedIndex) {
          1 => _page1,
          2 => _page2,
          _ => _page0,
        }(context),
      ),
    );
  }

  final List<Gun> _primariesPool = <Gun>[];

  @pragma("vm:prefer-inline")
  Column _page2(BuildContext context) {
    return Column(
      children: <Widget>[
        const Text(
          "Primaries",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: PublicTheme.normalWhite,
          ),
        ).animate(autoPlay: true).slideY(begin: 0.2, duration: const Duration(milliseconds: 240)),
        if (!_rolling)
          const Text(
                "Click on each item to assign it to a player",
                style: TextStyle(fontSize: 18, color: PublicTheme.loreYellow),
                textAlign: TextAlign.center,
              )
              .animate(autoPlay: true)
              .fadeIn(begin: 0.6, duration: const Duration(milliseconds: 240))
              .slideY(begin: 0.2, duration: const Duration(milliseconds: 240)),
        const SizedBox(height: 22),
        SingleChildScrollView(
          child: Wrap(
            runSpacing: 8,
            runAlignment: WrapAlignment.spaceEvenly,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            children: List<Widget>.generate(_primariesPool.length, (int i) {
              return _ItemCard(
                    menuChildrenBuilder: (BuildContext _, int j) => Text("Player ${j + 1}"),
                    display: Image.asset(_primariesPool[i].assetPath, scale: 0.94),
                    sub: Text.rich(
                      TextSpan(
                        children: <InlineSpan>[
                          TextSpan(
                            text: _primariesPool[i].canonicalName,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          TextSpan(
                            text: "\n${_primariesPool[i].gameName}",
                            style: const TextStyle(fontSize: 16, color: PublicTheme.hiddenGray),
                          ),
                        ],
                      ),
                      style: const TextStyle(
                        fontFamily: "Shared Tech",
                        color: PublicTheme.normalWhite,
                      ),
                    ),
                  )
                  .animate(autoPlay: true)
                  .fadeIn(begin: 0.8, duration: const Duration(milliseconds: 210))
                  .slideY(
                    begin: -0.34,
                    duration: const Duration(milliseconds: 330),
                    delay: const Duration(milliseconds: 80),
                  );
            }, growable: false),
          ),
        ),
      ],
    );
  }

  @pragma("vm:prefer-inline")
  Column _page1(BuildContext context) {
    return Column(
      children: <Widget>[
        const Text(
          "Rundown",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: PublicTheme.normalWhite,
          ),
        ).animate(autoPlay: true).slideY(begin: 0.2, duration: const Duration(milliseconds: 240)),
        const SizedBox(height: 22),
        Column(
          children: <Widget>[
            Text(
              Provider.of<CurrentSkeletonRun>(context).run!.mission?.canonicalName ?? "...",
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: PublicTheme.loreYellow,
              ),
            ),
            const SizedBox(height: 22),
            Text(
              Provider.of<CurrentSkeletonRun>(context).run!.rundown?.canonicalName ?? "",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
            ),
          ],
        ).animate(autoPlay: true).slideY(begin: 0.2, duration: const Duration(milliseconds: 140)),
        if (!_rolling) const SizedBox(height: 16),
        if (!_rolling)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 6,
            children: <Widget>[
              Tooltip(
                message: "MAIN",
                child: Image.asset("assets/ingame/sector_main.png", width: 64)
                    .animate(autoPlay: true)
                    .fade(
                      duration: const Duration(milliseconds: 400),
                      delay: const Duration(milliseconds: 400),
                    ),
              ),
              if (Provider.of<CurrentSkeletonRun>(context).run!.sectors!.contains(Sector.secondary))
                Tooltip(
                      message: "SECONDARY",
                      child: Image.asset("assets/ingame/sector_secondary.png", width: 64),
                    )
                    .animate(autoPlay: true)
                    .fade(
                      duration: const Duration(milliseconds: 400),
                      delay: const Duration(milliseconds: 440),
                    ),
              if (Provider.of<CurrentSkeletonRun>(context).run!.sectors!.contains(Sector.overload))
                Tooltip(
                      message: "OVERLOAD",
                      child: Image.asset("assets/ingame/sector_overload.png", width: 64),
                    )
                    .animate(autoPlay: true)
                    .fade(
                      duration: const Duration(milliseconds: 400),
                      delay: const Duration(milliseconds: 480),
                    ),
              if (Provider.of<CurrentSkeletonRun>(
                    context,
                  ).run!.sectors!.contains(Sector.secondary) &&
                  Provider.of<CurrentSkeletonRun>(context).run!.sectors!.contains(Sector.overload))
                Tooltip(
                      message: "PRISONER EFFICIENCY",
                      child: Image.asset("assets/ingame/prisoner_efficiency.png", width: 64),
                    )
                    .animate(autoPlay: true)
                    .fade(
                      duration: const Duration(milliseconds: 400),
                      delay: const Duration(milliseconds: 500),
                    ),
            ],
          ),
        if (!_rolling) const SizedBox(height: 18),
        if (!_rolling)
          UINormalBoxButton(
            onTap: () {
              _goTo(2);
              _triggerPageChange(() {
                _primariesPool.clear();
                _primariesPool.addAll(Preset.vanilla.primaries.pickMultipleWithBias(4));
                setState(() {});
              });
            },
            foregroundColor: PublicTheme.dangerRed,
            child: const Text("To Primaries"),
          ).animate(autoPlay: true).slideY(begin: 0.2, duration: const Duration(milliseconds: 140)),
      ],
    );
  }

  @pragma("vm:prefer-inline")
  Column _page0(BuildContext context) {
    return Column(
      children: <Widget>[
        const Icon(Icons.warning_amber_sharp, color: PublicTheme.loreYellow),
        const SizedBox(height: 6),
        const Text(
          "Auction",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: PublicTheme.loreYellow,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          "This is a very hands-on mode. Please make sure\nall players are in thegame lobby before proceeding.",
          style: TextStyle(fontFamily: "Shared Tech", color: PublicTheme.normalWhite),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 26),
        UINormalBoxButton(
          onTap: () {
            _goTo(1);
            Provider.of<CurrentSkeletonRun>(context, listen: false).value = SkeletonRun();
            _triggerPageChange(() {
              final Rundown rundown = Preset.vanilla.rundowns.pick();
              final Mission mission = rundown.allMissions.pick();
              Provider.of<CurrentSkeletonRun>(context, listen: false).run!
                ..mission = mission
                ..rundown = rundown
                ..sectors = mission.generate();
              setState(() {});
            });
          },
          foregroundColor: PublicTheme.dangerRed,
          child: const Text("BEGIN", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _ItemCard extends StatelessWidget {
  final Widget display;
  final Widget? sub;
  final void Function(int)? handler;
  final Widget Function(BuildContext, int) menuChildrenBuilder;

  const _ItemCard({
    required this.display,
    this.sub,
    this.handler,
    required this.menuChildrenBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final Widget child = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[display, const SizedBox(height: 12), if (sub != null) sub!],
    );
    return PopupMenuButton(
      child: UINormalBox(child: child),
      itemBuilder: (BuildContext context) => List<PopupMenuEntry<int>>.generate(
        4,
        (int i) => PopupMenuEntry<int>(
          onPressed: () => handler?.call(i),
          child: menuChildrenBuilder.call(context, i),
        ),
      ),
    );
  }
}

class _InformationRow extends StatelessWidget {
  const _InformationRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Spacer(),
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
                                        "\nThe rundown is revealed first followed by a pool of weapons that the player scan select from for each individual slot (i.e. Primary -> Special -> Tool -> Melee).\n\n",
                                    style: TextStyle(color: PublicTheme.normalWhite),
                                  ),
                                  TextSpan(
                                    text: "2. Rerolling Mechanism: ",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text:
                                        "\nA majority vote can be used to trigger a reroll of the loadout or rundown. This can occur either once after the initial randomization or after a failed attempt.\n\n",
                                    style: TextStyle(color: PublicTheme.normalWhite),
                                  ),
                                  TextSpan(
                                    text: "3. Boosters: ",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text:
                                        "\nBoosters are randomly dispersed and thus are optional. If a player is unable to bring a specific tier of booster(s), they are allowed to forgo bringing any boosters at all.",
                                    style: TextStyle(color: PublicTheme.normalWhite),
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
    );
  }
}
