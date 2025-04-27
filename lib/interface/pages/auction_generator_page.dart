import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gtfo_rundown_roulette/interface/provider/current_run.dart';
import 'package:gtfo_rundown_roulette/interface/provider/current_skeleton_run.dart';
import 'package:gtfo_rundown_roulette/interface/widgets/conditional_widget.dart';
import 'package:gtfo_rundown_roulette/interface/widgets/core/normal_box.dart';
import 'package:gtfo_rundown_roulette/interface/widgets/diagonal_text.dart';
import 'package:gtfo_rundown_roulette/interface/widgets/player_card.dart';
import 'package:gtfo_rundown_roulette/main.dart';
import 'package:gtfo_rundown_roulette/public.dart';
import 'package:gtfo_rundown_roulette/shared/shared.dart';
import 'package:gtfo_rundown_roulette/utils/scheduler.dart';
import 'package:gtfo_rundown_roulette/utils/shared_preferences.dart';
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

class _ContentBodyState extends State<_ContentBody> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[_InformationRow(), Expanded(child: _PageLoader())],
    );
  }

  @override
  bool get wantKeepAlive => true;
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
  void _goTo(final int r) {
    _loadedIndex = r;
    _triggerPageChange();
  }

  void _triggerPageChange([void Function()? action]) {
    setState(() => _opacity = 0.0);
    if (context.mounted) {
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
        Future<void>.delayed(
          const Duration(milliseconds: 100),
          () => setState(() => _opacity = 1.0),
        );
      }
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
          3 => _page3,
          4 => _page4,
          5 => _page5,
          _ => _page0,
        }(context),
      ),
    );
  }

  @pragma("vm:prefer-inline")
  Widget _page5(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              UINormalBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      Provider.of<CurrentRun>(context).run == null
                          ? "???"
                          : Provider.of<CurrentRun>(context).run!.mission.canonicalName,
                      style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 22),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      Provider.of<CurrentRun>(context).run == null
                          ? "???"
                          : Provider.of<CurrentRun>(context).run!.rundown.canonicalName,
                      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Expanded(
          child: Row(
            spacing: 8,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: PlayerCard(
                  title: "Player 1",
                  name: "Woods",
                  bgImage: "assets/ingame/woods.png",
                  color: const Color.fromARGB(255, 208, 79, 116),
                  loadout: Provider.of<CurrentRun>(context).run?.players.player1,
                ),
              ),
              Expanded(
                child: PlayerCard(
                  title: "Player 2",
                  name: "Dauda",
                  bgImage: "assets/ingame/dauda.png",
                  color: const Color.fromARGB(255, 88, 224, 124),
                  loadout: Provider.of<CurrentRun>(context).run?.players.player2,
                ),
              ),
              Expanded(
                child: PlayerCard(
                  title: "Player 3",
                  name: "Hackett",
                  bgImage: "assets/ingame/hackett.png",
                  color: const Color.fromARGB(255, 77, 133, 189),
                  loadout: Provider.of<CurrentRun>(context).run?.players.player3,
                ),
              ),
              Expanded(
                child: PlayerCard(
                  title: "Player 4",
                  name: "Bishop",
                  bgImage: "assets/ingame/bishop.png",
                  color: const Color.fromARGB(255, 135, 53, 197),
                  loadout: Provider.of<CurrentRun>(context).run?.players.player4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  final List<ToolItem> _toolsPool = <ToolItem>[];
  @pragma("vm:prefer-inline")
  Column _page4(BuildContext context) {
    final bool isBuilt =
        Provider.of<CurrentSkeletonRun>(context, listen: false).run!.players.player4.tool != null &&
        Provider.of<CurrentSkeletonRun>(context, listen: false).run!.players.player3.tool != null &&
        Provider.of<CurrentSkeletonRun>(context, listen: false).run!.players.player2.tool != null &&
        Provider.of<CurrentSkeletonRun>(context, listen: false).run!.players.player1.tool != null;
    return Column(
      children: <Widget>[
        const Text(
          "Tools",
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
        if (isBuilt) const SizedBox(height: 22),
        if (isBuilt)
          UINormalBoxButton(
            onTap: () {
              _toolsPool.clear();
              _primariesPool.clear();
              _specialsPool.clear();
              _goTo(5);
              Provider.of<CurrentSkeletonRun>(context, listen: false).run!.players.player1
                ..melee = Preset.vanilla.melees.pick()
                ..boosters = Boosters.values.pickMultiple();
              Provider.of<CurrentSkeletonRun>(context, listen: false).run!.players.player2
                ..melee = Preset.vanilla.melees.pick()
                ..boosters = Boosters.values.pickMultiple();
              Provider.of<CurrentSkeletonRun>(context, listen: false).run!.players.player3
                ..melee = Preset.vanilla.melees.pick()
                ..boosters = Boosters.values.pickMultiple();
              Provider.of<CurrentSkeletonRun>(context, listen: false).run!.players.player4
                ..melee = Preset.vanilla.melees.pick()
                ..boosters = Boosters.values.pickMultiple();
              Provider.of<CurrentRun>(context, listen: false).value =
                  Provider.of<CurrentSkeletonRun>(context, listen: false).run!.populate();
              _triggerPageChange(() => setState(() {}));
            },
            foregroundColor: PublicTheme.dangerRed,
            child: const Text("To Final Review"),
          ),
        const SizedBox(height: 22),
        ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            scrollbars: true,
            multitouchDragStrategy: MultitouchDragStrategy.sumAllPointers,
          ),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Wrap(
              runSpacing: 8,
              runAlignment: WrapAlignment.spaceEvenly,
              spacing: 8,
              children: List<Widget>.generate(_toolsPool.length, (int i) {
                return ConditionalWidget(
                  second: (BuildContext context, Widget normal) {
                    if (Provider.of<CurrentSkeletonRun>(
                          context,
                          listen: false,
                        ).run!.players.player1.tool ==
                        _toolsPool[i]) {
                      return DiagonalText(
                        text: "PLAYER 1",
                        style: const TextStyle(
                          color: Color.fromARGB(255, 208, 79, 116),
                          fontFamily: "Shared Tech",
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                        ),
                        child: normal,
                      );
                    } else if (Provider.of<CurrentSkeletonRun>(
                          context,
                          listen: false,
                        ).run!.players.player2.tool ==
                        _toolsPool[i]) {
                      return DiagonalText(
                        text: "PLAYER 2",
                        style: const TextStyle(
                          color: Color.fromARGB(255, 88, 224, 124),
                          fontFamily: "Shared Tech",
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                        ),
                        child: normal,
                      );
                    } else if (Provider.of<CurrentSkeletonRun>(
                          context,
                          listen: false,
                        ).run!.players.player3.tool ==
                        _toolsPool[i]) {
                      return DiagonalText(
                        text: "PLAYER 3",
                        style: const TextStyle(
                          color: Color.fromARGB(255, 77, 133, 189),
                          fontFamily: "Shared Tech",
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                        ),
                        child: normal,
                      );
                    } else if (Provider.of<CurrentSkeletonRun>(
                          context,
                          listen: false,
                        ).run!.players.player4.tool ==
                        _toolsPool[i]) {
                      return DiagonalText(
                        text: "PLAYER 4",
                        style: const TextStyle(
                          color: Color.fromARGB(255, 135, 53, 197),
                          fontFamily: "Shared Tech",
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                        ),
                        child: normal,
                      );
                    }
                    return null;
                  },
                  normal: _ItemCard(
                        handler: (int k) {
                          debugPrint("GOT $i");
                          if (k == 0) {
                            Provider.of<CurrentSkeletonRun>(context, listen: false)
                                .run!
                                .players
                                .player1
                                .tool = _toolsPool[i];
                            setState(() {});
                            debugPrint("Player 1 TOOL = ${_toolsPool[i]}");
                          } else if (k == 1) {
                            Provider.of<CurrentSkeletonRun>(context, listen: false)
                                .run!
                                .players
                                .player2
                                .tool = _toolsPool[i];
                            debugPrint("Player 2 TOOL = ${_toolsPool[i]}");
                            setState(() {});
                          } else if (k == 2) {
                            Provider.of<CurrentSkeletonRun>(context, listen: false)
                                .run!
                                .players
                                .player3
                                .tool = _toolsPool[i];
                            setState(() {});
                            debugPrint("Player 3 TOOL = ${_toolsPool[i]}");
                          } else if (k == 3) {
                            Provider.of<CurrentSkeletonRun>(context, listen: false)
                                .run!
                                .players
                                .player4
                                .tool = _toolsPool[i];
                            setState(() {});
                            debugPrint("Player 4 TOOL = ${_toolsPool[i]}");
                          }
                        },
                        menuChildrenBuilder:
                            (BuildContext _, int j) => UINormalBox(
                              backgroundColor:
                                  kPrefs.getSafeBool("color_lobby")
                                      ? switch (j) {
                                        1 => const Color.fromARGB(179, 88, 224, 124),
                                        2 => const Color.fromARGB(211, 77, 133, 189),
                                        3 => const Color.fromARGB(195, 135, 53, 197),
                                        _ => const Color.fromARGB(206, 208, 79, 116),
                                      }
                                      : PublicTheme.murkyDarkGrey,
                              child: Text(
                                "Player ${j + 1}",
                                style: const TextStyle(
                                  fontFamily: "Shared Tech",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                        display: Image.asset(
                          _toolsPool[i].assetPath,
                          scale: 0.94,
                          filterQuality: FilterQuality.low,
                        ),
                        sub: Text.rich(
                          TextSpan(
                            children: <InlineSpan>[
                              TextSpan(
                                text: _toolsPool[i].canonicalName,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              TextSpan(
                                text: "\n${_toolsPool[i].gameName}",
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
                      ),
                );
              }, growable: false),
            ),
          ),
        ),
      ],
    );
  }

  final List<Gun> _specialsPool = <Gun>[];
  @pragma("vm:prefer-inline")
  Column _page3(BuildContext context) {
    final bool isBuilt =
        Provider.of<CurrentSkeletonRun>(context, listen: false).run!.players.player4.special !=
            null &&
        Provider.of<CurrentSkeletonRun>(context, listen: false).run!.players.player3.special !=
            null &&
        Provider.of<CurrentSkeletonRun>(context, listen: false).run!.players.player2.special !=
            null &&
        Provider.of<CurrentSkeletonRun>(context, listen: false).run!.players.player1.special !=
            null;
    return Column(
      children: <Widget>[
        const Text(
          "Specials",
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
        if (isBuilt) const SizedBox(height: 22),
        if (isBuilt)
          UINormalBoxButton(
            onTap: () {
              _goTo(4);
              _triggerPageChange(() {
                _toolsPool.clear();
                _toolsPool.addAll(
                  Preset.vanilla.tools.pickMultipleWithBias(6),
                ); // tools have a lot of duplicates
                setState(() {});
              });
            },
            foregroundColor: PublicTheme.dangerRed,
            child: const Text("To Tools"),
          ),
        const SizedBox(height: 22),
        ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            scrollbars: true,
            multitouchDragStrategy: MultitouchDragStrategy.sumAllPointers,
          ),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Wrap(
              runSpacing: 8,
              runAlignment: WrapAlignment.spaceEvenly,
              spacing: 8,
              children: List<Widget>.generate(_specialsPool.length, (int i) {
                return ConditionalWidget(
                  second: (BuildContext context, Widget normal) {
                    if (Provider.of<CurrentSkeletonRun>(
                          context,
                          listen: false,
                        ).run!.players.player1.special ==
                        _specialsPool[i]) {
                      return DiagonalText(
                        text: "PLAYER 1",
                        style: const TextStyle(
                          color: Color.fromARGB(255, 208, 79, 116),
                          fontFamily: "Shared Tech",
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                        ),
                        child: normal,
                      );
                    } else if (Provider.of<CurrentSkeletonRun>(
                          context,
                          listen: false,
                        ).run!.players.player2.special ==
                        _specialsPool[i]) {
                      return DiagonalText(
                        text: "PLAYER 2",
                        style: const TextStyle(
                          color: Color.fromARGB(255, 88, 224, 124),
                          fontFamily: "Shared Tech",
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                        ),
                        child: normal,
                      );
                    } else if (Provider.of<CurrentSkeletonRun>(
                          context,
                          listen: false,
                        ).run!.players.player3.special ==
                        _specialsPool[i]) {
                      return DiagonalText(
                        text: "PLAYER 3",
                        style: const TextStyle(
                          color: Color.fromARGB(255, 77, 133, 189),
                          fontFamily: "Shared Tech",
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                        ),
                        child: normal,
                      );
                    } else if (Provider.of<CurrentSkeletonRun>(
                          context,
                          listen: false,
                        ).run!.players.player4.special ==
                        _specialsPool[i]) {
                      return DiagonalText(
                        text: "PLAYER 4",
                        style: const TextStyle(
                          color: Color.fromARGB(255, 135, 53, 197),
                          fontFamily: "Shared Tech",
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                        ),
                        child: normal,
                      );
                    }
                    return null;
                  },
                  normal: _ItemCard(
                        handler: (int k) {
                          debugPrint("GOT $i");
                          if (k == 0) {
                            Provider.of<CurrentSkeletonRun>(context, listen: false)
                                .run!
                                .players
                                .player1
                                .special = _specialsPool[i];
                            setState(() {});
                            debugPrint("Player 1 SPECIAL = ${_specialsPool[i]}");
                          } else if (k == 1) {
                            Provider.of<CurrentSkeletonRun>(context, listen: false)
                                .run!
                                .players
                                .player2
                                .special = _specialsPool[i];
                            debugPrint("Player 2 SPECIAL = ${_specialsPool[i]}");
                            setState(() {});
                          } else if (k == 2) {
                            Provider.of<CurrentSkeletonRun>(context, listen: false)
                                .run!
                                .players
                                .player3
                                .special = _specialsPool[i];
                            setState(() {});
                            debugPrint("Player 3 SPECIAL = ${_specialsPool[i]}");
                          } else if (k == 3) {
                            Provider.of<CurrentSkeletonRun>(context, listen: false)
                                .run!
                                .players
                                .player4
                                .special = _specialsPool[i];
                            setState(() {});
                            debugPrint("Player 4 SPECIAL = ${_specialsPool[i]}");
                          }
                        },
                        menuChildrenBuilder:
                            (BuildContext _, int j) => UINormalBox(
                              backgroundColor:
                                  kPrefs.getSafeBool("color_lobby")
                                      ? switch (j) {
                                        1 => const Color.fromARGB(179, 88, 224, 124),
                                        2 => const Color.fromARGB(211, 77, 133, 189),
                                        3 => const Color.fromARGB(195, 135, 53, 197),
                                        _ => const Color.fromARGB(206, 208, 79, 116),
                                      }
                                      : PublicTheme.murkyDarkGrey,
                              child: Text(
                                "Player ${j + 1}",
                                style: const TextStyle(
                                  fontFamily: "Shared Tech",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                        display: Image.asset(
                          _specialsPool[i].assetPath,
                          scale: 0.94,
                          filterQuality: FilterQuality.low,
                        ),
                        sub: Text.rich(
                          TextSpan(
                            children: <InlineSpan>[
                              TextSpan(
                                text: _specialsPool[i].canonicalName,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              TextSpan(
                                text: "\n${_specialsPool[i].gameName}",
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
                      ),
                );
              }, growable: false),
            ),
          ),
        ),
      ],
    );
  }

  final List<Gun> _primariesPool = <Gun>[];
  @pragma("vm:prefer-inline")
  Column _page2(BuildContext context) {
    final bool isBuilt =
        Provider.of<CurrentSkeletonRun>(context, listen: false).run!.players.player4.primary !=
            null &&
        Provider.of<CurrentSkeletonRun>(context, listen: false).run!.players.player3.primary !=
            null &&
        Provider.of<CurrentSkeletonRun>(context, listen: false).run!.players.player2.primary !=
            null &&
        Provider.of<CurrentSkeletonRun>(context, listen: false).run!.players.player1.primary !=
            null;
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
        if (isBuilt) const SizedBox(height: 22),
        if (isBuilt)
          UINormalBoxButton(
            onTap: () {
              _goTo(3);
              _triggerPageChange(() {
                _specialsPool.clear();
                _specialsPool.addAll(Preset.vanilla.specials.pickMultipleWithBias(4));
                setState(() {});
              });
            },
            foregroundColor: PublicTheme.dangerRed,
            child: const Text("To Specials"),
          ),
        const SizedBox(height: 22),
        ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            scrollbars: true,
            multitouchDragStrategy: MultitouchDragStrategy.sumAllPointers,
          ),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Wrap(
              runSpacing: 8,
              runAlignment: WrapAlignment.spaceEvenly,
              spacing: 8,
              children: List<Widget>.generate(_primariesPool.length, (int i) {
                return ConditionalWidget(
                  second: (BuildContext context, Widget normal) {
                    if (Provider.of<CurrentSkeletonRun>(
                          context,
                          listen: false,
                        ).run!.players.player1.primary ==
                        _primariesPool[i]) {
                      return DiagonalText(
                        text: "PLAYER 1",
                        style: const TextStyle(
                          color: Color.fromARGB(255, 208, 79, 116),
                          fontFamily: "Shared Tech",
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                        ),
                        child: normal,
                      );
                    } else if (Provider.of<CurrentSkeletonRun>(
                          context,
                          listen: false,
                        ).run!.players.player2.primary ==
                        _primariesPool[i]) {
                      return DiagonalText(
                        text: "PLAYER 2",
                        style: const TextStyle(
                          color: Color.fromARGB(255, 88, 224, 124),
                          fontFamily: "Shared Tech",
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                        ),
                        child: normal,
                      );
                    } else if (Provider.of<CurrentSkeletonRun>(
                          context,
                          listen: false,
                        ).run!.players.player3.primary ==
                        _primariesPool[i]) {
                      return DiagonalText(
                        text: "PLAYER 3",
                        style: const TextStyle(
                          color: Color.fromARGB(255, 77, 133, 189),
                          fontFamily: "Shared Tech",
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                        ),
                        child: normal,
                      );
                    } else if (Provider.of<CurrentSkeletonRun>(
                          context,
                          listen: false,
                        ).run!.players.player4.primary ==
                        _primariesPool[i]) {
                      return DiagonalText(
                        text: "PLAYER 4",
                        style: const TextStyle(
                          color: Color.fromARGB(255, 135, 53, 197),
                          fontFamily: "Shared Tech",
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                        ),
                        child: normal,
                      );
                    }
                    return null;
                  },
                  normal: _ItemCard(
                        handler: (int k) {
                          debugPrint("GOT $i");
                          if (k == 0) {
                            Provider.of<CurrentSkeletonRun>(context, listen: false)
                                .run!
                                .players
                                .player1
                                .primary = _primariesPool[i];
                            setState(() {});
                            debugPrint("Player 1 PRIMARY = ${_primariesPool[i]}");
                          } else if (k == 1) {
                            Provider.of<CurrentSkeletonRun>(context, listen: false)
                                .run!
                                .players
                                .player2
                                .primary = _primariesPool[i];
                            debugPrint("Player 2 PRIMARY = ${_primariesPool[i]}");
                            setState(() {});
                          } else if (k == 2) {
                            Provider.of<CurrentSkeletonRun>(context, listen: false)
                                .run!
                                .players
                                .player3
                                .primary = _primariesPool[i];
                            setState(() {});
                            debugPrint("Player 3 PRIMARY = ${_primariesPool[i]}");
                          } else if (k == 3) {
                            Provider.of<CurrentSkeletonRun>(context, listen: false)
                                .run!
                                .players
                                .player4
                                .primary = _primariesPool[i];
                            setState(() {});
                            debugPrint("Player 4 PRIMARY = ${_primariesPool[i]}");
                          }
                        },
                        menuChildrenBuilder:
                            (BuildContext _, int j) => UINormalBox(
                              backgroundColor:
                                  kPrefs.getSafeBool("color_lobby")
                                      ? switch (j) {
                                        1 => const Color.fromARGB(179, 88, 224, 124),
                                        2 => const Color.fromARGB(211, 77, 133, 189),
                                        3 => const Color.fromARGB(195, 135, 53, 197),
                                        _ => const Color.fromARGB(206, 208, 79, 116),
                                      }
                                      : PublicTheme.murkyDarkGrey,
                              child: Text(
                                "Player ${j + 1}",
                                style: const TextStyle(
                                  fontFamily: "Shared Tech",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                        display: Image.asset(
                          _primariesPool[i].assetPath,
                          scale: 0.94,
                          filterQuality: FilterQuality.low,
                        ),
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
                      ),
                );
              }, growable: false),
            ),
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
    return PopupMenuButton<int>(
      tooltip: "Assign to player",
      requestFocus: true,
      onSelected: handler,
      padding: EdgeInsets.zero,
      itemBuilder:
          (BuildContext context) => List<PopupMenuEntry<int>>.generate(
            4,
            (int i) => PopupMenuItem<int>(value: i, child: menuChildrenBuilder.call(context, i)),
          ),
      child: UINormalBox(child: child),
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
