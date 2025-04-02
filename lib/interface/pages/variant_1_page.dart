import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gtfo_rundown_roulette/interface/provider/current_run.dart';
import 'package:gtfo_rundown_roulette/interface/widgets/core/normal_box.dart';
import 'package:gtfo_rundown_roulette/interface/widgets/loadout_item_card.dart';
import 'package:gtfo_rundown_roulette/interface/widgets/widgets.dart';
import 'package:gtfo_rundown_roulette/public.dart';
import 'package:gtfo_rundown_roulette/shared/shared.dart';
import 'package:gtfo_rundown_roulette/interface/widgets/diagonal_trace.dart';
import 'package:gtfo_rundown_roulette/interface/widgets/player_card.dart';
import 'package:gtfo_rundown_roulette/utils/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

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

class _ContentBodyState extends State<_ContentBody>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  Variant1Filter? filter;
  bool rerolling = false;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTextStyle(
      style: const TextStyle(fontFamily: "Shared Tech"),
      child: Column(
        children: <Widget>[
          Row(
            spacing: 4,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Flexible(
                child: ExpansionTile(
                  visualDensity: VisualDensity.comfortable,
                  maintainState: true,
                  title: Text("Rules & Description", style: TextStyle(fontWeight: FontWeight.bold)),
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
                          child: DisableableWidget(
                            disabled: rerolling,
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
                                    filter,
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
                        ),
                        Tooltip(
                          message: "Randomize Everything",
                          child: DisableableWidget(
                            disabled: rerolling,
                            child: FloatingActionButton(
                              onPressed: () {
                                setState(() => rerolling = true);
                                int times =
                                    rnd.nextBool() ? 12 + rnd.nextInt(3) + 1 : 12 - rnd.nextInt(3);
                                toastification.showCustom(
                                  autoCloseDuration: const Duration(milliseconds: 2500),
                                  animationDuration: Duration.zero,
                                  alignment: Alignment.bottomRight,
                                  builder: (BuildContext context, ToastificationItem holder) {
                                    return UINormalBox(
                                      foregroundColor: PublicTheme.dangerRed,
                                      child: Row(
                                        spacing: 6,
                                        children: <Widget>[
                                          const Icon(CommunityMaterialIcons.pirate),
                                          Text("Rerolling for $times times"),
                                        ],
                                      ),
                                    );
                                  },
                                );
                                Scheduler.reductiveRelay(
                                  () async =>
                                      Provider.of<CurrentRun>(
                                        context,
                                        listen: false,
                                      ).value = Variant1Generator.produceFrom(
                                        Preset.vanilla,
                                        true,
                                        true,
                                        null,
                                        filter,
                                      ),
                                  times,
                                  rnd.nextBool()
                                      ? 120 + rnd.nextInt(100) + 40
                                      : 120 - (rnd.nextInt(60)),
                                  120,
                                ).then((_) {
                                  if (context.mounted) {
                                    toastification.showCustom(
                                      autoCloseDuration: const Duration(milliseconds: 3500),
                                      animationDuration: Duration.zero,
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
                              },
                              child: const Icon(CommunityMaterialIcons.reload),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      spacing: 4,
                      children: <Widget>[
                        Tooltip(
                          message: "Filters",
                          child: DisableableWidget(
                            disabled: rerolling,
                            child: FloatingActionButton(
                              onPressed:
                                  () async => await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      final Variant1Filter currFilter =
                                          filter ??
                                          // ignore: prefer_const_constructors
                                          Variant1Filter(
                                            blockedMissions: <Mission>{},
                                            blockedPrimaries: <Gun>{},
                                            blockedSpecials: <Gun>{},
                                            blockedTools: <ToolItem>{},
                                            blockedMelees: <MeleeWeapon>{},
                                            blockedBoosters: <Boosters>{},
                                          );
                                      return AlertDialog(
                                        title: const Text("Apply Filters"),
                                        scrollable: true,
                                        content: IntrinsicWidth(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            spacing: 6,
                                            children: <Widget>[
                                              FloatingActionButton(
                                                onPressed:
                                                    () => Navigator.push(
                                                      context,
                                                      MaterialPageRoute<Widget>(
                                                        builder:
                                                            (BuildContext context) => Scaffold(
                                                              appBar: AppBar(
                                                                actionsPadding:
                                                                    const EdgeInsets.symmetric(
                                                                      horizontal: 8,
                                                                    ),
                                                                title: const Text(
                                                                  "Filter Rundowns",
                                                                ),
                                                                actions: <Widget>[
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      filter = currFilter;
                                                                      Navigator.pop(context);
                                                                    },
                                                                    child: const UINormalBox(
                                                                      child: Text("Apply"),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              body: ListView.builder(
                                                                scrollDirection: Axis.horizontal,
                                                                itemCount:
                                                                    Preset.vanilla.rundowns.length,
                                                                itemBuilder: (
                                                                  BuildContext context,
                                                                  int i,
                                                                ) {
                                                                  return Padding(
                                                                    padding:
                                                                        const EdgeInsets.symmetric(
                                                                          horizontal: 18,
                                                                        ),
                                                                    child: IntrinsicWidth(
                                                                      child: Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment
                                                                                .start,
                                                                        children: <Widget>[
                                                                          Builder(
                                                                            builder: (
                                                                              BuildContext context,
                                                                            ) {
                                                                              final String name =
                                                                                  Preset
                                                                                      .vanilla
                                                                                      .rundowns[i]
                                                                                      .canonicalName;

                                                                              if (!name.startsWith(
                                                                                "ALT://",
                                                                              )) {
                                                                                final List<String>
                                                                                parts = name.split(
                                                                                  "\"",
                                                                                );
                                                                                return Text(
                                                                                  "${parts[0]}\n\"${parts.sublist(1).join()}\"",
                                                                                  style: const TextStyle(
                                                                                    color:
                                                                                        PublicTheme
                                                                                            .normalWhite,
                                                                                    fontSize: 24,
                                                                                    fontFamily:
                                                                                        "Shared Tech",
                                                                                  ),
                                                                                );
                                                                              }
                                                                              final List<String>
                                                                              parts = name
                                                                                  .split("ALT://")
                                                                                  .last
                                                                                  .split("\"");
                                                                              return Text.rich(
                                                                                TextSpan(
                                                                                  children: <
                                                                                    InlineSpan
                                                                                  >[
                                                                                    const TextSpan(
                                                                                      text:
                                                                                          "ALT://",
                                                                                      style: TextStyle(
                                                                                        color:
                                                                                            PublicTheme
                                                                                                .loreYellow,
                                                                                      ),
                                                                                    ),
                                                                                    TextSpan(
                                                                                      text:
                                                                                          "${parts[0]}\n\"${parts.sublist(1).join()}\"",
                                                                                      style: const TextStyle(
                                                                                        color:
                                                                                            PublicTheme
                                                                                                .normalWhite,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                  style: const TextStyle(
                                                                                    fontSize: 24,
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
                                                                                        final List<
                                                                                          String
                                                                                        >
                                                                                        parts = Preset
                                                                                            .vanilla
                                                                                            .rundowns[i]
                                                                                            .allMissions[j]
                                                                                            .canonicalName
                                                                                            .split(
                                                                                              "\"",
                                                                                            );
                                                                                        return Padding(
                                                                                          padding: const EdgeInsets.only(
                                                                                            bottom:
                                                                                                8,
                                                                                          ),
                                                                                          child: Row(
                                                                                            spacing:
                                                                                                6,
                                                                                            children: <
                                                                                              Widget
                                                                                            >[
                                                                                              UINormalBox(
                                                                                                foregroundColor:
                                                                                                    Preset.vanilla.rundowns[i].allMissions[j].isLore
                                                                                                        ? PublicTheme.loreYellow
                                                                                                        : null,
                                                                                                thick:
                                                                                                    true,
                                                                                                child: Text(
                                                                                                  parts.first,
                                                                                                  style: const TextStyle(
                                                                                                    fontSize:
                                                                                                        18,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Text(
                                                                                                "\"${parts.sublist(1).join()}\"",
                                                                                                style: const TextStyle(
                                                                                                  fontSize:
                                                                                                      18,
                                                                                                  color:
                                                                                                      PublicTheme.hiddenGray,
                                                                                                  fontFamily:
                                                                                                      "Shared Tech",
                                                                                                ),
                                                                                              ),
                                                                                            ],
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
                                                child: const Text("Filter Missions"),
                                              ),
                                              FloatingActionButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute<Widget>(
                                                      builder:
                                                          (BuildContext context) => Scaffold(
                                                            appBar: AppBar(
                                                              title: const Text("Filter Tools"),
                                                              actions: <Widget>[
                                                                FilledButton.icon(
                                                                  onPressed: () {
                                                                    filter = currFilter;
                                                                    Navigator.pop(context);
                                                                  },
                                                                  icon: const Icon(
                                                                    Icons.input_rounded,
                                                                  ),
                                                                  label: const Text("Apply"),
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
                                                                    physics:
                                                                        const AlwaysScrollableScrollPhysics(
                                                                          parent:
                                                                              BouncingScrollPhysics(),
                                                                        ),
                                                                    child: Wrap(
                                                                      spacing: 12,
                                                                      runSpacing: 12,
                                                                      runAlignment:
                                                                          WrapAlignment.spaceEvenly,
                                                                      children: List<
                                                                        Widget
                                                                      >.generate(
                                                                        Preset
                                                                            .vanilla
                                                                            .primaries
                                                                            .length,
                                                                        (int i) {
                                                                          final Gun item =
                                                                              Preset
                                                                                  .vanilla
                                                                                  .primaries[i];
                                                                          return Tooltip(
                                                                            message:
                                                                                item.canonicalName,
                                                                            child: FilterToggleItemExtended(
                                                                              toggled:
                                                                                  !currFilter
                                                                                      .blockedPrimaries
                                                                                      .contains(
                                                                                        item,
                                                                                      ),
                                                                              consumer: (bool r) {
                                                                                if (!r &&
                                                                                    currFilter
                                                                                                .blockedPrimaries
                                                                                                .length +
                                                                                            1 ==
                                                                                        Preset
                                                                                            .vanilla
                                                                                            .primaries
                                                                                            .length) {
                                                                                  showDialog(
                                                                                    context:
                                                                                        context,
                                                                                    builder:
                                                                                        (
                                                                                          BuildContext
                                                                                          context,
                                                                                        ) => AlertDialog(
                                                                                          actions: <
                                                                                            Widget
                                                                                          >[
                                                                                            FilledButton(
                                                                                              onPressed:
                                                                                                  () => Navigator.pop(
                                                                                                    context,
                                                                                                  ),
                                                                                              child: const Text(
                                                                                                "Ok",
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                          icon: const Icon(
                                                                                            Icons
                                                                                                .error,
                                                                                          ),
                                                                                          title: const Text(
                                                                                            "At least one item needs to be unblocked!",
                                                                                          ),
                                                                                        ),
                                                                                  );
                                                                                  return false;
                                                                                } else if (!r) {
                                                                                  currFilter
                                                                                      .blockedPrimaries
                                                                                      .add(item);
                                                                                } else {
                                                                                  currFilter
                                                                                      .blockedPrimaries
                                                                                      .remove(item);
                                                                                }
                                                                                return true;
                                                                              },
                                                                              item: item,
                                                                            ),
                                                                          );
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                    ),
                                                  );
                                                },
                                                child: const Text("Filter Primary Weapons"),
                                              ),
                                              FloatingActionButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute<Widget>(
                                                      builder:
                                                          (BuildContext context) => Scaffold(
                                                            appBar: AppBar(
                                                              title: const Text(
                                                                "Filter Special Weapons",
                                                              ),
                                                              actions: <Widget>[
                                                                FilledButton.icon(
                                                                  onPressed: () {
                                                                    filter = currFilter;
                                                                    Navigator.pop(context);
                                                                  },
                                                                  icon: const Icon(
                                                                    Icons.input_rounded,
                                                                  ),
                                                                  label: const Text("Apply"),
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
                                                                      >.generate(
                                                                        Preset
                                                                            .vanilla
                                                                            .specials
                                                                            .length,
                                                                        (int i) {
                                                                          final Gun item =
                                                                              Preset
                                                                                  .vanilla
                                                                                  .specials[i];
                                                                          return Tooltip(
                                                                            message:
                                                                                item.canonicalName,
                                                                            child: FilterToggleItemExtended(
                                                                              toggled:
                                                                                  !currFilter
                                                                                      .blockedSpecials
                                                                                      .contains(
                                                                                        item,
                                                                                      ),
                                                                              consumer: (bool r) {
                                                                                if (!r &&
                                                                                    currFilter
                                                                                                .blockedSpecials
                                                                                                .length +
                                                                                            1 ==
                                                                                        Preset
                                                                                            .vanilla
                                                                                            .specials
                                                                                            .length) {
                                                                                  showDialog(
                                                                                    context:
                                                                                        context,
                                                                                    builder:
                                                                                        (
                                                                                          BuildContext
                                                                                          context,
                                                                                        ) => AlertDialog(
                                                                                          actions: <
                                                                                            Widget
                                                                                          >[
                                                                                            FilledButton(
                                                                                              onPressed:
                                                                                                  () => Navigator.pop(
                                                                                                    context,
                                                                                                  ),
                                                                                              child: const Text(
                                                                                                "Ok",
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                          icon: const Icon(
                                                                                            Icons
                                                                                                .error,
                                                                                          ),
                                                                                          title: const Text(
                                                                                            "At least one item needs to be unblocked!",
                                                                                          ),
                                                                                        ),
                                                                                  );
                                                                                  return false;
                                                                                } else if (!r) {
                                                                                  currFilter
                                                                                      .blockedSpecials
                                                                                      .add(item);
                                                                                } else {
                                                                                  currFilter
                                                                                      .blockedSpecials
                                                                                      .remove(item);
                                                                                }
                                                                                return true;
                                                                              },
                                                                              item: item,
                                                                            ),
                                                                          );
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                    ),
                                                  );
                                                },
                                                child: const Text("Filter Special Weapons"),
                                              ),
                                              FloatingActionButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute<Widget>(
                                                      builder:
                                                          (BuildContext context) => Scaffold(
                                                            appBar: AppBar(
                                                              title: const Text("Filter Tools"),
                                                              actions: <Widget>[
                                                                FilledButton.icon(
                                                                  onPressed: () {
                                                                    filter = currFilter;
                                                                    Navigator.pop(context);
                                                                  },
                                                                  icon: const Icon(
                                                                    Icons.input_rounded,
                                                                  ),
                                                                  label: const Text("Apply"),
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
                                                                          message:
                                                                              item.canonicalName,
                                                                          child: FilterToggleItemExtended(
                                                                            toggled:
                                                                                !currFilter
                                                                                    .blockedTools
                                                                                    .contains(item),
                                                                            consumer: (bool r) {
                                                                              if (!r &&
                                                                                  currFilter
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
                                                                                        actions: <
                                                                                          Widget
                                                                                        >[
                                                                                          FilledButton(
                                                                                            onPressed:
                                                                                                () => Navigator.pop(
                                                                                                  context,
                                                                                                ),
                                                                                            child: const Text(
                                                                                              "Ok",
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                        icon: const Icon(
                                                                                          Icons
                                                                                              .error,
                                                                                        ),
                                                                                        title: const Text(
                                                                                          "At least one item needs to be unblocked!",
                                                                                        ),
                                                                                      ),
                                                                                );
                                                                                return false;
                                                                              } else if (!r) {
                                                                                currFilter
                                                                                    .blockedTools
                                                                                    .add(item);
                                                                              } else {
                                                                                currFilter
                                                                                    .blockedTools
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
                                                child: const Text("Filter Tools"),
                                              ),
                                              FloatingActionButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute<Widget>(
                                                      builder:
                                                          (BuildContext context) => Scaffold(
                                                            appBar: AppBar(
                                                              title: const Text(
                                                                "Filter Melee Weapons",
                                                              ),
                                                              actions: <Widget>[
                                                                FilledButton.icon(
                                                                  onPressed: () {
                                                                    filter = currFilter;
                                                                    Navigator.pop(context);
                                                                  },
                                                                  icon: const Icon(
                                                                    Icons.input_rounded,
                                                                  ),
                                                                  label: const Text("Apply"),
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
                                                                      >.generate(
                                                                        Preset
                                                                            .vanilla
                                                                            .melees
                                                                            .length,
                                                                        (int i) {
                                                                          final MeleeWeapon item =
                                                                              Preset
                                                                                  .vanilla
                                                                                  .melees[i];
                                                                          return Tooltip(
                                                                            message:
                                                                                Preset
                                                                                    .vanilla
                                                                                    .melees[i]
                                                                                    .canonicalName,
                                                                            child: FilterToggleItemExtended(
                                                                              toggled:
                                                                                  !currFilter
                                                                                      .blockedMelees
                                                                                      .contains(
                                                                                        item,
                                                                                      ),
                                                                              consumer: (bool r) {
                                                                                if (!r &&
                                                                                    currFilter
                                                                                                .blockedMelees
                                                                                                .length +
                                                                                            1 ==
                                                                                        Preset
                                                                                            .vanilla
                                                                                            .melees
                                                                                            .length) {
                                                                                  showDialog(
                                                                                    context:
                                                                                        context,
                                                                                    builder:
                                                                                        (
                                                                                          BuildContext
                                                                                          context,
                                                                                        ) => AlertDialog(
                                                                                          actions: <
                                                                                            Widget
                                                                                          >[
                                                                                            FilledButton(
                                                                                              onPressed:
                                                                                                  () => Navigator.pop(
                                                                                                    context,
                                                                                                  ),
                                                                                              child: const Text(
                                                                                                "Ok",
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                          icon: const Icon(
                                                                                            Icons
                                                                                                .error,
                                                                                          ),
                                                                                          title: const Text(
                                                                                            "At least one item needs to be unblocked!",
                                                                                          ),
                                                                                        ),
                                                                                  );
                                                                                  return false;
                                                                                } else if (!r) {
                                                                                  currFilter
                                                                                      .blockedMelees
                                                                                      .add(item);
                                                                                } else {
                                                                                  currFilter
                                                                                      .blockedMelees
                                                                                      .remove(item);
                                                                                }
                                                                                return true;
                                                                              },
                                                                              item: item,
                                                                            ),
                                                                          );
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                    ),
                                                  );
                                                },
                                                child: const Text("Filter Melees"),
                                              ),
                                              FloatingActionButton(
                                                onPressed: () {
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
                                                                              !currFilter
                                                                                  .blockedBoosters
                                                                                  .contains(
                                                                                    Boosters.MUTED,
                                                                                  ),
                                                                          consumer:
                                                                              (bool r) =>
                                                                                  !r
                                                                                      ? currFilter
                                                                                          .blockedBoosters
                                                                                          .add(
                                                                                            Boosters
                                                                                                .MUTED,
                                                                                          )
                                                                                      : currFilter
                                                                                          .blockedBoosters
                                                                                          .remove(
                                                                                            Boosters
                                                                                                .MUTED,
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
                                                                              !currFilter
                                                                                  .blockedBoosters
                                                                                  .contains(
                                                                                    Boosters.BOLD,
                                                                                  ),
                                                                          consumer:
                                                                              (bool r) =>
                                                                                  !r
                                                                                      ? currFilter
                                                                                          .blockedBoosters
                                                                                          .add(
                                                                                            Boosters
                                                                                                .BOLD,
                                                                                          )
                                                                                      : currFilter
                                                                                          .blockedBoosters
                                                                                          .remove(
                                                                                            Boosters
                                                                                                .BOLD,
                                                                                          ),
                                                                          child: Image.asset(
                                                                            "assets/ingame/bold.png",
                                                                            width: 48,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Tooltip(
                                                                        message:
                                                                            "Aggressive Boosters",
                                                                        child: FilterToggleItem(
                                                                          toggled:
                                                                              !currFilter
                                                                                  .blockedBoosters
                                                                                  .contains(
                                                                                    Boosters
                                                                                        .AGGRESIVE,
                                                                                  ),
                                                                          consumer:
                                                                              (bool r) =>
                                                                                  !r
                                                                                      ? currFilter
                                                                                          .blockedBoosters
                                                                                          .add(
                                                                                            Boosters
                                                                                                .AGGRESIVE,
                                                                                          )
                                                                                      : currFilter
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
                                                                  FilledButton(
                                                                    onPressed: () {
                                                                      debugPrint(
                                                                        "BLOCKED_BOOSTERS = ${currFilter.blockedBoosters.toString()}",
                                                                      );
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
                                                child: const Text("Filter Boosters"),
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          FilledButton(
                                            onPressed: () => Navigator.pop(context),
                                            child: const Text("Cancel"),
                                          ),
                                          FilledButton(
                                            onPressed: () {
                                              filter = currFilter;
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
                          message: "Randomize Rundown Only",
                          child: DisableableWidget(
                            disabled: rerolling,
                            child: FloatingActionButton(
                              onPressed: () {
                                setState(() => rerolling = true);
                                int times =
                                    rnd.nextBool() ? 12 + rnd.nextInt(3) + 1 : 12 - rnd.nextInt(3);
                                toastification.showCustom(
                                  autoCloseDuration: const Duration(milliseconds: 2500),
                                  animationDuration: Duration.zero,
                                  alignment: Alignment.bottomRight,
                                  builder: (BuildContext context, ToastificationItem holder) {
                                    return UINormalBox(
                                      foregroundColor: PublicTheme.dangerRed,
                                      child: Row(
                                        spacing: 6,
                                        children: <Widget>[
                                          const Icon(CommunityMaterialIcons.pirate),
                                          Text("Rerolling for $times times"),
                                        ],
                                      ),
                                    );
                                  },
                                );
                                Scheduler.reductiveRelay(
                                  () async {
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
                                  times,
                                  rnd.nextBool()
                                      ? 120 + rnd.nextInt(100) + 40
                                      : 120 - (rnd.nextInt(60)),
                                  120,
                                ).then((_) {
                                  if (context.mounted) {
                                    toastification.showCustom(
                                      autoCloseDuration: const Duration(milliseconds: 3500),
                                      animationDuration: Duration.zero,
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
                              },
                              child: const Icon(CommunityMaterialIcons.account_hard_hat),
                            ),
                          ),
                        ),
                      ],
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
                  child: UINormalBox(
                    child:
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                          child: Provider.of<CurrentRun>(context).run == null
                              ? const SizedBox()
                              : Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    Provider.of<CurrentRun>(context).run!.mission.canonicalName,
                                    style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 22),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    Provider.of<CurrentRun>(context).run!.rundown.canonicalName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
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
                                      ),
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
                  child: PlayerCard(
                    title: "Player 1",
                    name: "Woods",
                    bgImage: "assets/ingame/woods.png",
                    color: const Color.fromARGB(255, 116, 46, 66),
                    loadout: Provider.of<CurrentRun>(context).run?.players.player1,
                  ),
                ),
                Expanded(
                  child: PlayerCard(
                    title: "Player 2",
                    name: "Dauda",
                    bgImage: "assets/ingame/dauda.png",
                    color: const Color.fromARGB(255, 32, 92, 48),
                    loadout: Provider.of<CurrentRun>(context).run?.players.player2,
                  ),
                ),
                Expanded(
                  child: PlayerCard(
                    title: "Player 3",
                    name: "Hackett",
                    bgImage: "assets/ingame/hackett.png",
                    color: const Color.fromARGB(255, 22, 61, 100),
                    loadout: Provider.of<CurrentRun>(context).run?.players.player3,
                  ),
                ),
                Expanded(
                  child: PlayerCard(
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
                    1.0, 0.0, 0.0, 0.0, 0.0, //
                    0.0, 1.0, 0.0, 0.0, 0.0, //
                    0.0, 0.0, 1.0, 0.0, 0.0, //
                    0.0, 0.0, 0.0, 1.0, 0.0, //
                  ])
                  : const ColorFilter.matrix(<double>[
                    // values from wikipedia
                    0.2126 * 0.8, 0.7152 * 0.8, 0.0722 * 0.8, 0, 0, //
                    0.2126 * 0.8, 0.7152 * 0.8, 0.0722 * 0.8, 0, 0, //
                    0.2126 * 0.8, 0.7152 * 0.8, 0.0722 * 0.8, 0, 0, //
                    0, 0, 0, 1, 0, //
                  ]),
          child: LoadoutItemCard(item: widget.item),
        ),
      ),
    );
  }
}
