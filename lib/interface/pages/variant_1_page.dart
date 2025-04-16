import 'dart:convert';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gtfo_rundown_roulette/interface/provider/current_run.dart';
import 'package:gtfo_rundown_roulette/interface/widgets/core/drooped_divider.dart';
import 'package:gtfo_rundown_roulette/interface/widgets/core/normal_box.dart';
import 'package:gtfo_rundown_roulette/interface/widgets/loadout_item_card.dart';
import 'package:gtfo_rundown_roulette/interface/widgets/widgets.dart';
import 'package:gtfo_rundown_roulette/main.dart';
import 'package:gtfo_rundown_roulette/public.dart';
import 'package:gtfo_rundown_roulette/shared/shared.dart';
import 'package:gtfo_rundown_roulette/interface/widgets/diagonal_trace.dart';
import 'package:gtfo_rundown_roulette/interface/widgets/player_card.dart';
import 'package:gtfo_rundown_roulette/utils/scheduler.dart';
import 'package:gtfo_rundown_roulette/utils/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

/// the page for using the variant 1 generator, the most basic generator in the randomizer
///
/// it forwards building to [_ContentBody]
class Variant1RootScaffold extends StatelessWidget {
  const Variant1RootScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: _ContentBody());
  }
}

class _ContentBody extends StatefulWidget {
  const _ContentBody();

  @override
  State<_ContentBody> createState() => _ContentBodyState();
}

class _ContentBodyState extends State<_ContentBody>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  /// represents the current filter being used and will be applied on the next generation call
  // ignore: prefer_const_constructors
  final Variant1Filter filter = Variant1Filter(
    blockedMissions: <Mission>{},
    blockedPrimaries: <Gun>{},
    blockedSpecials: <Gun>{},
    blockedTools: <ToolItem>{},
    blockedMelees: <MeleeWeapon>{},
    blockedBoosters: <Boosters>{},
  );

  /// whether the content body is in the process of rerolling
  /// it is here to prevent certain interactions from happening
  ///
  /// !! this is just a temporary crutch and ignorant fix and will
  /// !! be removed in the future versions
  bool rerolling = false;

  /// this is resolved from the settings on whether to use the rolling animation.
  bool rollingAnimation = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTextStyle(
      style: const TextStyle(
        fontFamily: "Shared Tech",
      ), // there will be a lot of these to make do without having a million textstyles with font family set to Shared Tech
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Column(
          children: <Widget>[
            // this part is the top row of the widgets such as the missions display box and the controls on the right side
            IntrinsicHeight(
              child: Row(
                spacing: 4,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding:
                          Provider.of<CurrentRun>(context).run == null
                              ? const EdgeInsets.symmetric(horizontal: 4)
                              : EdgeInsets.zero,
                      child: UINormalBox(
                        thick: true,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              // the mission display box which includes the mission canonical names and descriptions
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      Provider.of<CurrentRun>(context).run == null
                                          ? "???"
                                          : Provider.of<CurrentRun>(
                                            context,
                                          ).run!.mission.canonicalName,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 22,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      Provider.of<CurrentRun>(context).run == null
                                          ? "???"
                                          : Provider.of<CurrentRun>(
                                            context,
                                          ).run!.rundown.canonicalName,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // sectors
                              Flexible(
                                flex: 2,
                                child:
                                    Provider.of<CurrentRun>(context).run == null
                                        ? const SizedBox()
                                        : Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          spacing: 6,
                                          children: <Widget>[
                                            Tooltip(
                                              message: "MAIN",
                                              child: Image.asset(
                                                "assets/ingame/sector_main.png",
                                                width: 44,
                                              ),
                                            ),
                                            if (Provider.of<CurrentRun>(
                                              context,
                                            ).run!.sectors.contains(Sector.secondary))
                                              Tooltip(
                                                    message: "SECONDARY",
                                                    child: Image.asset(
                                                      "assets/ingame/sector_secondary.png",
                                                      width: 44,
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
                                                      width: 44,
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
                                                      width: 44,
                                                    ),
                                                  )
                                                  .animate(autoPlay: true)
                                                  .fade(
                                                    duration: const Duration(milliseconds: 400),
                                                    delay: const Duration(milliseconds: 500),
                                                  ),
                                          ],
                                        ),
                              ),
                              // display the seed, when the user clicks on the text, they will also copy the current seed
                              // this is just a more convenient direct way to see the seed as compared to having to
                              // use the seed tuner
                              Expanded(
                                child: Builder(
                                  builder: (BuildContext context) {
                                    final String? seedString =
                                        Provider.of<CurrentRun>(context).run?.seed.toString();
                                    return DefaultTextStyle(
                                      style: const TextStyle(fontFamily: "Shared Tech"),
                                      child: GestureDetector(
                                        onTap: () {
                                          if (seedString != null) {
                                            Clipboard.setData(ClipboardData(text: seedString)).then(
                                              (_) => toastification.showCustom(
                                                autoCloseDuration: const Duration(
                                                  milliseconds: 2000,
                                                ),
                                                animationDuration: const Duration(
                                                  milliseconds: 330,
                                                ),
                                                alignment: Alignment.bottomRight,
                                                builder: (_, __) {
                                                  return const UINormalBox(
                                                    foregroundColor: PublicTheme.loreYellow,
                                                    child: Text("Copied seed"),
                                                  );
                                                },
                                              ),
                                            );
                                          }
                                        },
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Text.rich(
                                              TextSpan(
                                                children: <InlineSpan>[
                                                  const TextSpan(
                                                    text: "Seed :\n",
                                                    style: TextStyle(
                                                      color: PublicTheme.loreYellow,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: seedString ?? "???",
                                                    style: const TextStyle(
                                                      color: PublicTheme.normalWhite,
                                                      fontFamily: "Fira Code",
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            if (filter.isBlocking)
                                              const Text(
                                                "\nInaccurate seed due to filters!",
                                                style: TextStyle(
                                                  color: PublicTheme.dangerRed,
                                                  fontFamily: "Shared Tech",
                                                  fontSize: 14,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // these are the buttons on the side that control filters and randomization
                  _modifierButtons(context),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // here are the loadout cards for the individual player slots
            //
            // !! the colors here are once again approximations from screenshots i took
            Expanded(
              child: Row(
                spacing: 8,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: PlayerCard(
                          title: "Player 1 ${kPrefs.getSafeBool("be_descriptive") ? "(HOST)" : ""}",
                          name: "Woods",
                          bgImage: "assets/ingame/woods.png",
                          color: const Color.fromARGB(255, 208, 79, 116),
                          loadout: Provider.of<CurrentRun>(context).run?.players.player1,
                        )
                        .animate()
                        .then(delay: const Duration(milliseconds: 140))
                        .fadeIn(duration: const Duration(milliseconds: 240), curve: Curves.easeIn)
                        .slideY(
                          begin: -0.03,
                          end: 0,
                          duration: const Duration(milliseconds: 360),
                          curve: Curves.easeIn,
                        ),
                  ),
                  Expanded(
                    child: PlayerCard(
                          title: "Player 2",
                          name: "Dauda",
                          bgImage: "assets/ingame/dauda.png",
                          color: const Color.fromARGB(255, 88, 224, 124),
                          loadout: Provider.of<CurrentRun>(context).run?.players.player2,
                        )
                        .animate()
                        .then(delay: const Duration(milliseconds: 220))
                        .fadeIn(
                          duration: const Duration(milliseconds: 240),
                          curve: Curves.easeIn,
                          begin: 0.6,
                        )
                        .slideY(
                          begin: -0.03,
                          end: 0,
                          duration: const Duration(milliseconds: 360),
                          curve: Curves.easeIn,
                        ),
                  ),
                  Expanded(
                    child: PlayerCard(
                          title: "Player 3",
                          name: "Hackett",
                          bgImage: "assets/ingame/hackett.png",
                          color: const Color.fromARGB(255, 77, 133, 189),
                          loadout: Provider.of<CurrentRun>(context).run?.players.player3,
                        )
                        .animate()
                        .then(delay: const Duration(milliseconds: 300))
                        .fadeIn(
                          duration: const Duration(milliseconds: 240),
                          curve: Curves.easeIn,
                          begin: 0.6,
                        )
                        .slideY(
                          begin: -0.03,
                          end: 0,
                          duration: const Duration(milliseconds: 360),
                          curve: Curves.easeIn,
                        ),
                  ),
                  Expanded(
                    child: PlayerCard(
                          title: "Player 4",
                          name: "Bishop",
                          bgImage: "assets/ingame/bishop.png",
                          color: const Color.fromARGB(255, 135, 53, 197),
                          loadout: Provider.of<CurrentRun>(context).run?.players.player4,
                        )
                        .animate()
                        .then(delay: const Duration(milliseconds: 380))
                        .fadeIn(
                          duration: const Duration(milliseconds: 240),
                          curve: Curves.easeIn,
                          begin: 0.6,
                        )
                        .slideY(
                          begin: -0.03,
                          end: 0,
                          duration: const Duration(milliseconds: 360),
                          curve: Curves.easeIn,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  /// this variable is used for the seed tuner, see [_modifierButtons]
  String? customSeed;

  IntrinsicWidth _modifierButtons(BuildContext context) {
    // ignore unstable states shit with ancestors
    return IntrinsicWidth(
      child: Column(
        spacing: 4,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 4,
              children: <Widget>[
                Tooltip(
                  // dont add reductive relay to this, it is a bitch
                  message: "Randomize Loadout Once",
                  child: DisableableWidget(
                    disabled: rerolling,
                    child: UINormalBoxButton(
                      onTap: () async {
                        try {
                          Provider.of<CurrentRun>(
                            context,
                            listen: false,
                          ).value = Variant1Generator.produceFrom(
                            Preset.vanilla,
                            false,
                            true,
                            Provider.of<CurrentRun>(context, listen: false).run,
                            filter,
                          );
                        } catch (error) {
                          await showDialog(
                            context: context,
                            builder:
                                (BuildContext context) => AlertDialog(
                                  actions: <Widget>[
                                    UINormalBoxButton(
                                      onTap: () => Navigator.pop(context),
                                      child: const Text("Ok"),
                                    ),
                                  ],
                                  title: const Text(
                                    "Oh no!",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Shared Tech",
                                      color: PublicTheme.normalWhite,
                                    ),
                                  ),
                                  content: Text(
                                    error.toString(),
                                    style: const TextStyle(
                                      color: PublicTheme.dangerRed,
                                      fontFamily: "Shared Tech",
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                          );
                        }
                      },
                      child: const Icon(CommunityMaterialIcons.pistol),
                    ),
                  ),
                ),
                Tooltip(
                  message:
                      "Randomize Everything ${kPrefs.getSafeBool("randomization_animation") ? 'Once' : ''}",
                  child: DisableableWidget(
                    disabled: rerolling,
                    child: UINormalBoxButton(
                      onTap: () {
                        if (kPrefs.getSafeBool("randomization_animation")) {
                          setState(() => rerolling = true);
                          int times =
                              rnd.nextBool() ? 12 + rnd.nextInt(3) + 1 : 12 - rnd.nextInt(3);
                          toastification.showCustom(
                            autoCloseDuration: const Duration(milliseconds: 2500),
                            animationDuration: const Duration(milliseconds: 330),
                            alignment: Alignment.bottomRight,
                            builder: (BuildContext context, ToastificationItem holder) {
                              return UINormalBox(
                                foregroundColor: PublicTheme.dangerRed,
                                child: Row(
                                  spacing: 6,
                                  children: <Widget>[
                                    const Icon(CommunityMaterialIcons.skull_scan),
                                    Text("Rerolling for $times times"),
                                  ],
                                ),
                              );
                            },
                          );
                          Scheduler.reductiveRelay(
                            () {
                              Provider.of<CurrentRun>(
                                context,
                                listen: false,
                              ).value = Variant1Generator.produceFrom(
                                Preset.vanilla,
                                true,
                                true,
                                null,
                                filter,
                              );
                            },
                            times,
                            rnd.nextBool() ? 120 + rnd.nextInt(100) + 40 : 120 - (rnd.nextInt(60)),
                            120,
                          ).then((_) {
                            if (context.mounted) {
                              toastification.showCustom(
                                autoCloseDuration: const Duration(milliseconds: 3500),
                                animationDuration: const Duration(milliseconds: 330),
                                alignment: Alignment.bottomRight,
                                builder: (BuildContext context, ToastificationItem holder) {
                                  return const UINormalBox(
                                    foregroundColor: PublicTheme.highlightOrange,
                                    child: Row(
                                      spacing: 6,
                                      children: <Widget>[
                                        Icon(CommunityMaterialIcons.exclamation_thick),
                                        Text("Reroll done."),
                                      ],
                                    ),
                                  );
                                },
                              );
                              setState(() => rerolling = false);
                            }
                          });
                        } else {
                          Provider.of<CurrentRun>(
                            context,
                            listen: false,
                          ).value = Variant1Generator.produceFrom(
                            Preset.vanilla,
                            true,
                            true,
                            null,
                            filter,
                          );
                        }
                      },
                      child: const Icon(CommunityMaterialIcons.reload),
                    ),
                  ),
                ),
                UINormalBoxButton(
                  foregroundColor: PublicTheme.highlightOrange,
                  child: const Center(child: Text("USAGE INFO")),
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
                              title: const Text("Generic Randomizer"),
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
                                                "After each successful run, both the rundown and the loadout should be randomized.\n\n",
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
                                                "Boosters are not mandatory. If a player is unable to bring a specific tier of booster(s), they must forgo taking ANY boosters.",
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
          ),
          IntrinsicHeight(
            child: Row(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Tooltip(
                  message: "Filters",
                  child: DisableableWidget(
                    disabled: rerolling,
                    child: UINormalBoxButton(
                      foregroundColor: PublicTheme.loreYellow,
                      onTap:
                          () async => await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                scrollable: true,
                                title: const Text("Apply Filters"),
                                content: IntrinsicWidth(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    spacing: 6,
                                    children: <Widget>[
                                      UINormalBoxButton(
                                        onTap:
                                            () => Navigator.push(
                                              context,
                                              MaterialPageRoute<Widget>(
                                                builder:
                                                    (BuildContext context) => Scaffold(
                                                      appBar: AppBar(
                                                        actionsPadding: const EdgeInsets.symmetric(
                                                          horizontal: 8,
                                                        ),
                                                        title: const Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment.start,
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: <Widget>[
                                                            Text("Filter Rundowns"),
                                                            SizedBox(height: 6),
                                                            Text(
                                                              "Scroll horizontally by holding [SHIFT]",
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                color: PublicTheme.dangerRed,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        actions: <Widget>[
                                                          UINormalBoxButton(
                                                            onTap: () {
                                                              setState(() {});
                                                              Navigator.pop(context);
                                                            },
                                                            child: const Row(
                                                              spacing: 4,
                                                              children: <Widget>[
                                                                Icon(Icons.input_sharp),
                                                                Text("Apply"),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      body: ListView.builder(
                                                        scrollDirection: Axis.horizontal,
                                                        itemCount: Preset.vanilla.rundowns.length,
                                                        itemBuilder: (BuildContext context, int i) {
                                                          return Padding(
                                                            padding: const EdgeInsets.symmetric(
                                                              horizontal: 18,
                                                            ),
                                                            child: IntrinsicWidth(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment.start,
                                                                children: <Widget>[
                                                                  Builder(
                                                                    builder: (
                                                                      BuildContext context,
                                                                    ) {
                                                                      final String name =
                                                                          Preset
                                                                              .vanilla
                                                                              .rundowns[i]
                                                                              .canonicalName
                                                                              .toUpperCase();

                                                                      if (!name.startsWith(
                                                                        "ALT://",
                                                                      )) {
                                                                        final List<String> parts =
                                                                            name.split("\"");
                                                                        return Text(
                                                                          "${parts[0]}\n\"${parts.sublist(1).join()}\"",
                                                                          style: const TextStyle(
                                                                            color:
                                                                                PublicTheme
                                                                                    .normalWhite,
                                                                            fontSize: 20,
                                                                            fontFamily:
                                                                                "Shared Tech",
                                                                          ),
                                                                        );
                                                                      }
                                                                      final List<String> parts =
                                                                          name
                                                                              .split("ALT://")
                                                                              .last
                                                                              .split("\"");
                                                                      return Text.rich(
                                                                        TextSpan(
                                                                          children: <InlineSpan>[
                                                                            const TextSpan(
                                                                              text: "ALT://",
                                                                              style: TextStyle(
                                                                                color:
                                                                                    PublicTheme
                                                                                        .loreYellow,
                                                                              ),
                                                                            ),
                                                                            TextSpan(
                                                                              text:
                                                                                  "${parts[0]}\nTITLE: \"${parts.sublist(1).join()}\"",
                                                                              style: const TextStyle(
                                                                                color:
                                                                                    PublicTheme
                                                                                        .normalWhite,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                          style: const TextStyle(
                                                                            fontSize: 20,
                                                                            fontFamily:
                                                                                "Shared Tech",
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                                  Expanded(
                                                                    child: SingleChildScrollView(
                                                                      child: IntrinsicWidth(
                                                                        child: Padding(
                                                                          padding:
                                                                              const EdgeInsets.only(
                                                                                bottom: 30,
                                                                                right: 30,
                                                                              ),
                                                                          child: Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment
                                                                                    .stretch,
                                                                            children: List<
                                                                              Widget
                                                                            >.generate(
                                                                              Preset
                                                                                  .vanilla
                                                                                  .rundowns[i]
                                                                                  .allMissions
                                                                                  .length,
                                                                              (int j) {
                                                                                final List<String>
                                                                                parts = Preset
                                                                                    .vanilla
                                                                                    .rundowns[i]
                                                                                    .allMissions[j]
                                                                                    .canonicalName
                                                                                    .split("\"");
                                                                                return Padding(
                                                                                  padding:
                                                                                      const EdgeInsets.only(
                                                                                        bottom: 8,
                                                                                      ),
                                                                                  child: DisableableWidget(
                                                                                    disabled:
                                                                                        !filter.isValidMission(
                                                                                          Preset
                                                                                              .vanilla
                                                                                              .rundowns[i]
                                                                                              .allMissions[j],
                                                                                        ),
                                                                                    child: Row(
                                                                                      spacing: 6,
                                                                                      children: <
                                                                                        Widget
                                                                                      >[
                                                                                        UINormalBoxButton(
                                                                                          padding:
                                                                                              const EdgeInsets.only(
                                                                                                left:
                                                                                                    2,
                                                                                              ),
                                                                                          onTap: () {
                                                                                            final Mission
                                                                                            toBlock =
                                                                                                Preset.vanilla.rundowns[i].allMissions[j];

                                                                                            if (filter.isValidMission(
                                                                                              toBlock,
                                                                                            )) {
                                                                                              filter.blockedMissions.add(
                                                                                                toBlock,
                                                                                              );
                                                                                            } else {
                                                                                              filter.blockedMissions.remove(
                                                                                                toBlock,
                                                                                              );
                                                                                            }
                                                                                            setState(
                                                                                              () {},
                                                                                            );
                                                                                            debugPrint(
                                                                                              "BLOCKED_MISSION_ENACT:  ${toBlock.canonicalName}",
                                                                                            );
                                                                                          },
                                                                                          foregroundColor:
                                                                                              Preset.vanilla.rundowns[i].allMissions[j].isLore
                                                                                                  ? PublicTheme.loreYellow
                                                                                                  : null,
                                                                                          thick:
                                                                                              true,
                                                                                          child: Text(
                                                                                            parts
                                                                                                .first,
                                                                                            style: const TextStyle(
                                                                                              fontSize:
                                                                                                  26,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        Text(
                                                                                          "\"${parts.sublist(1).join()}\""
                                                                                              .toUpperCase(),
                                                                                          style: const TextStyle(
                                                                                            fontSize:
                                                                                                20,
                                                                                            color:
                                                                                                PublicTheme.hiddenGray,
                                                                                            fontFamily:
                                                                                                "Shared Tech",
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              },
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                              ),
                                            ),
                                        foregroundColor: PublicTheme.loreYellow,
                                        child: const Text("Filter Missions"),
                                      ),
                                      UINormalBoxButton(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute<Widget>(
                                              builder:
                                                  (BuildContext context) => Scaffold(
                                                    appBar: AppBar(
                                                      title: const Text("Filter Tools"),
                                                      actions: <Widget>[
                                                        UINormalBoxButton(
                                                          onTap: () {
                                                            setState(() {});
                                                            Navigator.pop(context);
                                                          },
                                                          child: const Row(
                                                            spacing: 4,
                                                            children: <Widget>[
                                                              Icon(Icons.input_sharp),
                                                              Text("Apply"),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    body: Padding(
                                                      padding: const EdgeInsets.symmetric(
                                                        horizontal: 22,
                                                      ),
                                                      child: Column(
                                                        children: <Widget>[
                                                          const Text(
                                                            "Block items from being generated by the generator by unselecting them.",
                                                            style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              fontFamily: "Shared Tech",
                                                              color: PublicTheme.loreYellow,
                                                            ),
                                                          ),
                                                          const SizedBox(height: 10),
                                                          SingleChildScrollView(
                                                            physics:
                                                                const AlwaysScrollableScrollPhysics(
                                                                  parent: BouncingScrollPhysics(),
                                                                ),
                                                            child: Wrap(
                                                              spacing: 12,
                                                              runSpacing: 12,
                                                              runAlignment:
                                                                  WrapAlignment.spaceEvenly,
                                                              children: List<
                                                                Widget
                                                              >.generate(Preset.vanilla.primaries.length, (
                                                                int i,
                                                              ) {
                                                                final Gun item =
                                                                    Preset.vanilla.primaries[i];
                                                                return Tooltip(
                                                                  message: item.canonicalName,
                                                                  child: FilterToggleItemExtended(
                                                                    toggled:
                                                                        !filter.blockedPrimaries
                                                                            .contains(item),
                                                                    consumer: (bool r) {
                                                                      if (!r &&
                                                                          filter
                                                                                      .blockedPrimaries
                                                                                      .length +
                                                                                  1 ==
                                                                              Preset
                                                                                  .vanilla
                                                                                  .primaries
                                                                                  .length) {
                                                                        showDialog(
                                                                          context: context,
                                                                          builder:
                                                                              (
                                                                                BuildContext
                                                                                context,
                                                                              ) => AlertDialog(
                                                                                actions: <Widget>[
                                                                                  UINormalBoxButton(
                                                                                    onTap:
                                                                                        () => Navigator.pop(
                                                                                          context,
                                                                                        ),
                                                                                    child:
                                                                                        const Text(
                                                                                          "Ok",
                                                                                        ),
                                                                                  ),
                                                                                ],
                                                                                icon: const Icon(
                                                                                  Icons.error,
                                                                                ),
                                                                                title: const Text(
                                                                                  "At least one item needs to be unblocked!",
                                                                                ),
                                                                              ),
                                                                        );
                                                                        return false;
                                                                      } else if (!r) {
                                                                        filter.blockedPrimaries.add(
                                                                          item,
                                                                        );
                                                                      } else {
                                                                        filter.blockedPrimaries
                                                                            .remove(item);
                                                                      }
                                                                      return true;
                                                                    },
                                                                    item: item,
                                                                  ),
                                                                );
                                                              }),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                            ),
                                          );
                                        },
                                        foregroundColor: PublicTheme.loreYellow,

                                        child: const Text("Filter Primary Weapons"),
                                      ),
                                      UINormalBoxButton(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute<Widget>(
                                              builder:
                                                  (BuildContext context) => Scaffold(
                                                    appBar: AppBar(
                                                      title: const Text("Filter Special Weapons"),
                                                      actions: <Widget>[
                                                        UINormalBoxButton(
                                                          onTap: () {
                                                            setState(() {});

                                                            Navigator.pop(context);
                                                          },
                                                          child: const Row(
                                                            spacing: 4,
                                                            children: <Widget>[
                                                              Icon(Icons.input_sharp),
                                                              Text("Apply"),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    body: Padding(
                                                      padding: const EdgeInsets.symmetric(
                                                        horizontal: 22,
                                                      ),
                                                      child: Column(
                                                        children: <Widget>[
                                                          const Text(
                                                            "Block items from being generated by the generator by unselecting them.",
                                                            style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              fontFamily: "Shared Tech",
                                                              color: PublicTheme.loreYellow,
                                                            ),
                                                          ),
                                                          const SizedBox(height: 10),
                                                          SingleChildScrollView(
                                                            child: Wrap(
                                                              spacing: 12,
                                                              runSpacing: 12,
                                                              runAlignment:
                                                                  WrapAlignment.spaceEvenly,
                                                              children: List<
                                                                Widget
                                                              >.generate(Preset.vanilla.specials.length, (
                                                                int i,
                                                              ) {
                                                                final Gun item =
                                                                    Preset.vanilla.specials[i];
                                                                return Tooltip(
                                                                  message: item.canonicalName,
                                                                  child: FilterToggleItemExtended(
                                                                    toggled:
                                                                        !filter.blockedSpecials
                                                                            .contains(item),
                                                                    consumer: (bool r) {
                                                                      if (!r &&
                                                                          filter
                                                                                      .blockedSpecials
                                                                                      .length +
                                                                                  1 ==
                                                                              Preset
                                                                                  .vanilla
                                                                                  .specials
                                                                                  .length) {
                                                                        showDialog(
                                                                          context: context,
                                                                          builder:
                                                                              (
                                                                                BuildContext
                                                                                context,
                                                                              ) => AlertDialog(
                                                                                actions: <Widget>[
                                                                                  FilledButton(
                                                                                    onPressed:
                                                                                        () => Navigator.pop(
                                                                                          context,
                                                                                        ),
                                                                                    child:
                                                                                        const Text(
                                                                                          "Ok",
                                                                                        ),
                                                                                  ),
                                                                                ],
                                                                                icon: const Icon(
                                                                                  Icons.error,
                                                                                ),
                                                                                title: const Text(
                                                                                  "At least one item needs to be unblocked!",
                                                                                ),
                                                                              ),
                                                                        );
                                                                        return false;
                                                                      } else if (!r) {
                                                                        filter.blockedSpecials.add(
                                                                          item,
                                                                        );
                                                                      } else {
                                                                        filter.blockedSpecials
                                                                            .remove(item);
                                                                      }
                                                                      return true;
                                                                    },
                                                                    item: item,
                                                                  ),
                                                                );
                                                              }),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                            ),
                                          );
                                        },
                                        foregroundColor: PublicTheme.loreYellow,

                                        child: const Text("Filter Special Weapons"),
                                      ),
                                      UINormalBoxButton(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute<Widget>(
                                              builder:
                                                  (BuildContext context) => Scaffold(
                                                    appBar: AppBar(
                                                      title: const Text("Filter Tools"),
                                                      actions: <Widget>[
                                                        UINormalBoxButton(
                                                          onTap: () {
                                                            setState(() {});
                                                            Navigator.pop(context);
                                                          },
                                                          child: const Row(
                                                            spacing: 4,
                                                            children: <Widget>[
                                                              Icon(Icons.input_sharp),
                                                              Text("Apply"),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    body: Padding(
                                                      padding: const EdgeInsets.symmetric(
                                                        horizontal: 22,
                                                      ),
                                                      child: Column(
                                                        children: <Widget>[
                                                          const Text(
                                                            "Block items from being generated by the generator by unselecting them.",
                                                            style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                          const SizedBox(height: 10),
                                                          SingleChildScrollView(
                                                            child: Wrap(
                                                              spacing: 12,
                                                              runSpacing: 12,
                                                              runAlignment:
                                                                  WrapAlignment.spaceEvenly,
                                                              children: List<
                                                                Widget
                                                              >.generate(Preset.vanilla.tools.length, (
                                                                int i,
                                                              ) {
                                                                final ToolItem item =
                                                                    Preset.vanilla.tools[i];
                                                                return Tooltip(
                                                                  message: item.canonicalName,
                                                                  child: FilterToggleItemExtended(
                                                                    toggled:
                                                                        !filter.blockedTools
                                                                            .contains(item),
                                                                    consumer: (bool r) {
                                                                      if (!r &&
                                                                          filter
                                                                                      .blockedTools
                                                                                      .length +
                                                                                  1 ==
                                                                              Preset
                                                                                  .vanilla
                                                                                  .tools
                                                                                  .length) {
                                                                        showDialog(
                                                                          context: context,
                                                                          builder:
                                                                              (
                                                                                BuildContext
                                                                                context,
                                                                              ) => AlertDialog(
                                                                                actions: <Widget>[
                                                                                  UINormalBoxButton(
                                                                                    onTap:
                                                                                        () => Navigator.pop(
                                                                                          context,
                                                                                        ),
                                                                                    child:
                                                                                        const Text(
                                                                                          "Ok",
                                                                                        ),
                                                                                  ),
                                                                                ],
                                                                                icon: const Icon(
                                                                                  Icons.error,
                                                                                ),
                                                                                title: const Text(
                                                                                  "At least one item needs to be unblocked!",
                                                                                ),
                                                                              ),
                                                                        );
                                                                        return false;
                                                                      } else if (!r) {
                                                                        filter.blockedTools.add(
                                                                          item,
                                                                        );
                                                                      } else {
                                                                        filter.blockedTools.remove(
                                                                          item,
                                                                        );
                                                                      }
                                                                      return true;
                                                                    },
                                                                    item: item,
                                                                  ),
                                                                );
                                                              }),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                            ),
                                          );
                                        },
                                        foregroundColor: PublicTheme.loreYellow,

                                        child: const Text("Filter Tools"),
                                      ),
                                      UINormalBoxButton(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute<Widget>(
                                              builder:
                                                  (BuildContext context) => Scaffold(
                                                    appBar: AppBar(
                                                      title: const Text("Filter Melee Weapons"),
                                                      actions: <Widget>[
                                                        UINormalBoxButton(
                                                          onTap: () {
                                                            setState(() {});
                                                            Navigator.pop(context);
                                                          },
                                                          child: const Row(
                                                            spacing: 4,
                                                            children: <Widget>[
                                                              Icon(Icons.input_sharp),
                                                              Text("Apply"),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    body: Padding(
                                                      padding: const EdgeInsets.symmetric(
                                                        horizontal: 22,
                                                      ),
                                                      child: Column(
                                                        children: <Widget>[
                                                          const Text(
                                                            "Block items from being generated by the generator by unselecting them.",
                                                            style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                          const SizedBox(height: 10),
                                                          SingleChildScrollView(
                                                            child: Wrap(
                                                              spacing: 12,
                                                              runSpacing: 12,
                                                              runAlignment:
                                                                  WrapAlignment.spaceEvenly,
                                                              children: List<
                                                                Widget
                                                              >.generate(Preset.vanilla.melees.length, (
                                                                int i,
                                                              ) {
                                                                final MeleeWeapon item =
                                                                    Preset.vanilla.melees[i];
                                                                return Tooltip(
                                                                  message:
                                                                      Preset
                                                                          .vanilla
                                                                          .melees[i]
                                                                          .canonicalName,
                                                                  child: FilterToggleItemExtended(
                                                                    toggled:
                                                                        !filter.blockedMelees
                                                                            .contains(item),
                                                                    consumer: (bool r) {
                                                                      if (!r &&
                                                                          filter
                                                                                      .blockedMelees
                                                                                      .length +
                                                                                  1 ==
                                                                              Preset
                                                                                  .vanilla
                                                                                  .melees
                                                                                  .length) {
                                                                        showDialog(
                                                                          context: context,
                                                                          builder:
                                                                              (
                                                                                BuildContext
                                                                                context,
                                                                              ) => AlertDialog(
                                                                                actions: <Widget>[
                                                                                  UINormalBoxButton(
                                                                                    onTap:
                                                                                        () => Navigator.pop(
                                                                                          context,
                                                                                        ),
                                                                                    child:
                                                                                        const Text(
                                                                                          "Ok",
                                                                                        ),
                                                                                  ),
                                                                                ],
                                                                                icon: const Icon(
                                                                                  Icons.error,
                                                                                ),
                                                                                title: const Text(
                                                                                  "At least one item needs to be unblocked!",
                                                                                ),
                                                                              ),
                                                                        );
                                                                        return false;
                                                                      } else if (!r) {
                                                                        filter.blockedMelees.add(
                                                                          item,
                                                                        );
                                                                      } else {
                                                                        filter.blockedMelees.remove(
                                                                          item,
                                                                        );
                                                                      }
                                                                      return true;
                                                                    },
                                                                    item: item,
                                                                  ),
                                                                );
                                                              }),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                            ),
                                          );
                                        },
                                        foregroundColor: PublicTheme.loreYellow,
                                        child: const Text("Filter Melees"),
                                      ),
                                      UINormalBoxButton(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute<Widget>(
                                              builder:
                                                  (BuildContext context) => Scaffold(
                                                    appBar: AppBar(
                                                      title: const Text("Filter Boosters"),
                                                    ),
                                                    body: Padding(
                                                      padding: const EdgeInsets.symmetric(
                                                        horizontal: 22,
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                        spacing: 8,
                                                        children: <Widget>[
                                                          const Text(
                                                            "Unselect the boosters you want to block from being generated.",
                                                          ),
                                                          const SizedBox(height: 8),
                                                          Row(
                                                            spacing: 8,
                                                            children: <Widget>[
                                                              Tooltip(
                                                                message: "Muted Boosters",
                                                                child: FilterToggleItem(
                                                                  toggled:
                                                                      !filter.blockedBoosters
                                                                          .contains(Boosters.MUTED),
                                                                  consumer:
                                                                      (bool r) =>
                                                                          !r
                                                                              ? filter
                                                                                  .blockedBoosters
                                                                                  .add(
                                                                                    Boosters.MUTED,
                                                                                  )
                                                                              : filter
                                                                                  .blockedBoosters
                                                                                  .remove(
                                                                                    Boosters.MUTED,
                                                                                  ),
                                                                  child: Image.asset(
                                                                    "assets/ingame/muted.png",
                                                                    width: 48,
                                                                  ),
                                                                ),
                                                              ),
                                                              Tooltip(
                                                                message: "Bold Boosters",
                                                                child: FilterToggleItem(
                                                                  toggled:
                                                                      !filter.blockedBoosters
                                                                          .contains(Boosters.BOLD),
                                                                  consumer:
                                                                      (bool r) =>
                                                                          !r
                                                                              ? filter
                                                                                  .blockedBoosters
                                                                                  .add(
                                                                                    Boosters.BOLD,
                                                                                  )
                                                                              : filter
                                                                                  .blockedBoosters
                                                                                  .remove(
                                                                                    Boosters.BOLD,
                                                                                  ),
                                                                  child: Image.asset(
                                                                    "assets/ingame/bold.png",
                                                                    width: 48,
                                                                  ),
                                                                ),
                                                              ),
                                                              Tooltip(
                                                                message: "Aggressive Boosters",
                                                                child: FilterToggleItem(
                                                                  toggled:
                                                                      !filter.blockedBoosters
                                                                          .contains(
                                                                            Boosters.AGGRESIVE,
                                                                          ),
                                                                  consumer:
                                                                      (bool r) =>
                                                                          !r
                                                                              ? filter
                                                                                  .blockedBoosters
                                                                                  .add(
                                                                                    Boosters
                                                                                        .AGGRESIVE,
                                                                                  )
                                                                              : filter
                                                                                  .blockedBoosters
                                                                                  .remove(
                                                                                    Boosters
                                                                                        .AGGRESIVE,
                                                                                  ),
                                                                  child: Image.asset(
                                                                    "assets/ingame/aggressive.png",
                                                                    width: 48,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(height: 14),
                                                          UINormalBoxButton(
                                                            onTap: () {
                                                              debugPrint(
                                                                "BLOCKED_BOOSTERS = ${filter.blockedBoosters.toString()}",
                                                              );
                                                              setState(() {});
                                                              Navigator.pop(context);
                                                            },
                                                            child: const Text("OK"),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                            ),
                                          );
                                        },
                                        foregroundColor: PublicTheme.loreYellow,

                                        child: const Text("Filter Boosters"),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  DisableableWidget(
                                    // if there is nothing being blocked, we tell the user thru this visual
                                    disabled: !filter.isBlocking,
                                    child: UINormalBoxButton(
                                      onTap: () {
                                        setState(() {
                                          filter.clear();
                                        });
                                        toastification.showCustom(
                                          autoCloseDuration: const Duration(milliseconds: 1400),
                                          animationDuration: const Duration(milliseconds: 330),
                                          alignment: Alignment.bottomRight,
                                          builder: (_, __) {
                                            return const UINormalBox(
                                              foregroundColor: PublicTheme.dangerRed,
                                              child: Text("Filters Cleared!"),
                                            );
                                          },
                                        );
                                      },
                                      foregroundColor: PublicTheme.dangerRed,
                                      child: const Text("Reset Filters"),
                                    ),
                                  ),
                                  UINormalBoxButton(
                                    onTap: () {
                                      setState(() {});
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Ok"),
                                  ),
                                ],
                              );
                            },
                          ),
                      child: const Icon(CommunityMaterialIcons.filter),
                    ),
                  ),
                ),
                Tooltip(
                  message: "Randomize Rundown Once",
                  child: DisableableWidget(
                    disabled: rerolling,
                    child: UINormalBoxButton(
                      onTap: () async {
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
                                    UINormalBoxButton(
                                      onTap: () => Navigator.pop(context),
                                      child: const Text("Ok"),
                                    ),
                                  ],
                                  title: const Text(
                                    "Oh no!",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Shared Tech",
                                      color: PublicTheme.normalWhite,
                                    ),
                                  ),
                                  content: Text(
                                    error.toString(),
                                    style: const TextStyle(
                                      color: PublicTheme.dangerRed,
                                      fontFamily: "Shared Tech",
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                          );
                        }
                      },
                      child: const Icon(CommunityMaterialIcons.account_hard_hat),
                    ),
                  ),
                ),
                UINormalBoxButton(
                  foregroundColor: PublicTheme.fumingGreen,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        final String? seedString =
                            Provider.of<CurrentRun>(context).run?.seed.toString();
                        return AlertDialog(
                          content: DefaultTextStyle(
                            style: const TextStyle(fontFamily: "Shared Tech"),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                if (seedString != null)
                                  Text.rich(
                                    TextSpan(
                                      children: <InlineSpan>[
                                        const TextSpan(
                                          text: "Current Seed:\n",
                                          style: TextStyle(
                                            color: PublicTheme.loreYellow,
                                            fontSize: 18,
                                          ),
                                        ),
                                        TextSpan(
                                          text: seedString,
                                          style: const TextStyle(
                                            color: PublicTheme.normalWhite,
                                            fontFamily: "Fira Code",
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                if (seedString != null)
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    child: DroopedDivider(
                                      amount: 6,
                                      color: PublicTheme.normalWhite,
                                      thickness: 2,
                                    ),
                                  ),
                                const Text(
                                  "Input Custom Seed\n",
                                  style: TextStyle(color: PublicTheme.loreYellow, fontSize: 18),
                                ),
                                UINormalBoxInput(
                                  onChanged: (String str) {
                                    customSeed = str.isEmpty ? null : str;
                                  },
                                  title: "Seed value",
                                ),
                                Row(
                                  // another hack to get the alignment to work better :)
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    DisableableWidget(
                                      disabled: rerolling,
                                      child: UINormalBoxButton(
                                        child: const Text("REGENERATE"),
                                        onTap: () {
                                          if (customSeed != null) {
                                            debugPrint("Regenerating with seed: $customSeed");
                                            // if null it means the string was typed with non numeric characters
                                            final int seed =
                                                int.tryParse(customSeed!) ??
                                                sha512256
                                                        .convert(utf8.encode(customSeed!))
                                                        .bytes
                                                        .reduce((int a, int b) => a + b) &
                                                    0xFFFFFFFF;
                                            debugPrint("Computed Seed value: $seed");
                                            Provider.of<CurrentRun>(
                                              context,
                                              listen: false,
                                            ).value = Variant1Generator.produceFrom(
                                              Preset.vanilla,
                                              true,
                                              true,
                                              null,
                                              filter,
                                              seed,
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            if (seedString != null)
                              UINormalBoxButton(
                                child: const Text("COPY SEED"),
                                onTap: () {
                                  Clipboard.setData(ClipboardData(text: seedString)).then(
                                    (_) => toastification.showCustom(
                                      autoCloseDuration: const Duration(milliseconds: 2000),
                                      animationDuration: const Duration(milliseconds: 330),
                                      alignment: Alignment.bottomRight,
                                      builder: (_, __) {
                                        return const UINormalBox(
                                          foregroundColor: PublicTheme.loreYellow,
                                          child: Text("Copied seed"),
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                            UINormalBoxButton(
                              foregroundColor: PublicTheme.dangerRed,
                              onTap: () => Navigator.pop(context),
                              child: const Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Center(
                    child: Text("SEED TUNER"),
                  ), // instead of using the word "View" i had to use "tuner" because to match the length of the previous button of "USAGE INFO" is 9 letters in order to match the same length, a hack tbh
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class FilterToggleItem extends StatefulWidget {
  final bool toggled;
  final void Function(bool) consumer;
  final Widget child;

  const FilterToggleItem({
    super.key,
    this.toggled = true,
    required this.consumer,
    required this.child,
  });

  @override
  State<FilterToggleItem> createState() => _FilterToggleItemState();
}

class _FilterToggleItemState extends State<FilterToggleItem> {
  late bool toggled;

  @override
  void initState() {
    super.initState();
    toggled = widget.toggled;
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: toggled ? null : const DiagonalTracePainter(),
      child: FloatingActionButton(
        isExtended: true,
        backgroundColor: PublicTheme.dangerRed,
        onPressed: () {
          setState(() => toggled = !toggled);
          widget.consumer(toggled);
        },
        child: ColorFiltered(
          colorFilter:
              toggled
                  ? const ColorFilter.matrix(<double>[
                    1.0, 0.0, 0.0, 0.0, 0.0, //
                    0.0, 1.0, 0.0, 0.0, 0.0, //
                    0.0, 0.0, 1.0, 0.0, 0.0, //
                    0.0, 0.0, 0.0, 1.0, 0.0, //
                  ])
                  : const ColorFilter.matrix(<double>[
                    // values from wikipedia
                    0.2126, 0.7152, 0.0722, 0, 0, //
                    0.2126, 0.7152, 0.0722, 0, 0, //
                    0.2126, 0.7152, 0.0722, 0, 0, //
                    0, 0, 0, 1, 0, //
                  ]),
          child: widget.child,
        ),
      ),
    );
  }
}

class FilterToggleItemExtended extends StatefulWidget {
  final bool toggled;
  final bool Function(bool) consumer;
  final LoadoutItem item;

  const FilterToggleItemExtended({
    super.key,
    this.toggled = true,
    required this.consumer,
    required this.item,
  });

  @override
  State<FilterToggleItemExtended> createState() => _FilterToggleItemStateExtended();
}

class _FilterToggleItemStateExtended extends State<FilterToggleItemExtended> {
  late bool toggled;

  @override
  void initState() {
    super.initState();
    toggled = widget.toggled;
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: toggled ? null : const DiagonalTracePainter(),
      child: GestureDetector(
        onTap: () {
          setState(() => toggled = widget.consumer(!toggled) ? !toggled : toggled);
        },
        child: ColorFiltered(
          colorFilter:
              toggled
                  ? const ColorFilter.matrix(<double>[
                    // normalized filter (ie displays normal colors)
                    1.0, 0.0, 0.0, 0.0, 0.0, //
                    0.0, 1.0, 0.0, 0.0, 0.0, //
                    0.0, 0.0, 1.0, 0.0, 0.0, //
                    0.0, 0.0, 0.0, 1.0, 0.0, //
                  ])
                  : const ColorFilter.matrix(<double>[
                    0.1, 0.3, 0.02, 0, 0, //
                    0.1, 0.3, 0.02, 0, 0, //
                    0.1, 0.3, 0.02, 0, 0, //
                    0, 0, 0, 1, 0, //
                  ]),
          child: LoadoutItemCard(item: widget.item),
        ),
      ),
    );
  }
}
