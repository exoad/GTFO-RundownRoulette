import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gtfo_rundown_roulette/interface/current_run.dart';
import 'package:gtfo_rundown_roulette/shared/shared.dart';
import 'package:gtfo_rundown_roulette/widgets/diagonal_trace.dart';
import 'package:gtfo_rundown_roulette/widgets/player_card.dart';
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

class _ContentBodyState extends State<_ContentBody> with AutomaticKeepAliveClientMixin {
  Variant1Filter? filter;

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                      Tooltip(
                        message: "Randomize Everything",
                        child: FloatingActionButton(
                          onPressed:
                              () =>
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
                          child: const Icon(CommunityMaterialIcons.reload),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: 4,
                    children: <Widget>[
                      Tooltip(
                        message: "Filters",
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
                                                () async => await showDialog(
                                                  context: context,
                                                  builder:
                                                      (
                                                        BuildContext context,
                                                      ) => AlertDialog(
                                                        actions: <Widget>[
                                                          FilledButton(
                                                            onPressed:
                                                                () => Navigator.pop(
                                                                  context,
                                                                ),
                                                            child: const Text("Ok"),
                                                          ),
                                                        ],
                                                        content: const Text(
                                                          "Still a work in progress! Check back later :)",
                                                          style: TextStyle(
                                                            fontSize: 22,
                                                            fontWeight: FontWeight.bold,
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
                                                          title: const Text(
                                                            "Filter Tools",
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
                                                          padding:
                                                              const EdgeInsets.symmetric(
                                                                horizontal: 22,
                                                              ),
                                                          child: Column(
                                                            children: <Widget>[
                                                              const Text(
                                                                "Block items from being generated by the generator by unselecting them.",
                                                                style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight.bold,
                                                                ),
                                                              ),
                                                              const SizedBox(height: 10),
                                                              SingleChildScrollView(
                                                                child: Wrap(
                                                                  spacing: 12,
                                                                  runSpacing: 12,
                                                                  runAlignment:
                                                                      WrapAlignment
                                                                          .spaceEvenly,
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
                                                                          consumer: (
                                                                            bool r,
                                                                          ) {
                                                                            if (!r &&
                                                                                currFilter.blockedPrimaries.length +
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
                                                                                        Icons.error,
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
                                                                                  .add(
                                                                                    item,
                                                                                  );
                                                                            } else {
                                                                              currFilter
                                                                                  .blockedPrimaries
                                                                                  .remove(
                                                                                    item,
                                                                                  );
                                                                            }
                                                                            return true;
                                                                          },
                                                                          child: Row(
                                                                            spacing: 8,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment
                                                                                    .center,
                                                                            children: <
                                                                              Widget
                                                                            >[
                                                                              Image.asset(
                                                                                item.assetPath,
                                                                                width: 52,
                                                                              ),
                                                                              Text(
                                                                                item.canonicalName,
                                                                                style: const TextStyle(
                                                                                  fontSize:
                                                                                      20,
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
                                                          padding:
                                                              const EdgeInsets.symmetric(
                                                                horizontal: 22,
                                                              ),
                                                          child: Column(
                                                            children: <Widget>[
                                                              const Text(
                                                                "Block items from being generated by the generator by unselecting them.",
                                                                style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight.bold,
                                                                ),
                                                              ),
                                                              const SizedBox(height: 10),
                                                              SingleChildScrollView(
                                                                child: Wrap(
                                                                  spacing: 12,
                                                                  runSpacing: 12,
                                                                  runAlignment:
                                                                      WrapAlignment
                                                                          .spaceEvenly,
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
                                                                          consumer: (
                                                                            bool r,
                                                                          ) {
                                                                            if (!r &&
                                                                                currFilter.blockedSpecials.length +
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
                                                                                        Icons.error,
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
                                                                                  .add(
                                                                                    item,
                                                                                  );
                                                                            } else {
                                                                              currFilter
                                                                                  .blockedSpecials
                                                                                  .remove(
                                                                                    item,
                                                                                  );
                                                                            }
                                                                            return true;
                                                                          },
                                                                          child: Row(
                                                                            spacing: 8,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment
                                                                                    .center,
                                                                            children: <
                                                                              Widget
                                                                            >[
                                                                              Image.asset(
                                                                                item.assetPath,
                                                                                width: 52,
                                                                              ),
                                                                              Text(
                                                                                item.canonicalName,
                                                                                style: const TextStyle(
                                                                                  fontSize:
                                                                                      20,
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
                                                          title: const Text(
                                                            "Filter Tools",
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
                                                          padding:
                                                              const EdgeInsets.symmetric(
                                                                horizontal: 22,
                                                              ),
                                                          child: Column(
                                                            children: <Widget>[
                                                              const Text(
                                                                "Block items from being generated by the generator by unselecting them.",
                                                                style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight.bold,
                                                                ),
                                                              ),
                                                              const SizedBox(height: 10),
                                                              SingleChildScrollView(
                                                                child: Wrap(
                                                                  spacing: 12,
                                                                  runSpacing: 12,
                                                                  runAlignment:
                                                                      WrapAlignment
                                                                          .spaceEvenly,
                                                                  children: List<
                                                                    Widget
                                                                  >.generate(
                                                                    Preset
                                                                        .vanilla
                                                                        .tools
                                                                        .length,
                                                                    (int i) {
                                                                      final ToolItem
                                                                      item =
                                                                          Preset
                                                                              .vanilla
                                                                              .tools[i];
                                                                      return Tooltip(
                                                                        message:
                                                                            item.canonicalName,
                                                                        child: FilterToggleItemExtended(
                                                                          toggled:
                                                                              !currFilter
                                                                                  .blockedTools
                                                                                  .contains(
                                                                                    item,
                                                                                  ),
                                                                          consumer: (
                                                                            bool r,
                                                                          ) {
                                                                            if (!r &&
                                                                                currFilter.blockedTools.length +
                                                                                        1 ==
                                                                                    Preset
                                                                                        .vanilla
                                                                                        .tools
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
                                                                                        Icons.error,
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
                                                                                  .add(
                                                                                    item,
                                                                                  );
                                                                            } else {
                                                                              currFilter
                                                                                  .blockedTools
                                                                                  .remove(
                                                                                    item,
                                                                                  );
                                                                            }
                                                                            return true;
                                                                          },
                                                                          child: Row(
                                                                            spacing: 8,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment
                                                                                    .center,
                                                                            children: <
                                                                              Widget
                                                                            >[
                                                                              Image.asset(
                                                                                item.assetPath,
                                                                                width: 52,
                                                                              ),
                                                                              Text(
                                                                                item.canonicalName,
                                                                                style: const TextStyle(
                                                                                  fontSize:
                                                                                      20,
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
                                                          padding:
                                                              const EdgeInsets.symmetric(
                                                                horizontal: 22,
                                                              ),
                                                          child: Column(
                                                            children: <Widget>[
                                                              const Text(
                                                                "Block items from being generated by the generator by unselecting them.",
                                                                style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight.bold,
                                                                ),
                                                              ),
                                                              const SizedBox(height: 10),
                                                              SingleChildScrollView(
                                                                child: Wrap(
                                                                  spacing: 12,
                                                                  runSpacing: 12,
                                                                  runAlignment:
                                                                      WrapAlignment
                                                                          .spaceEvenly,
                                                                  children: List<
                                                                    Widget
                                                                  >.generate(
                                                                    Preset
                                                                        .vanilla
                                                                        .melees
                                                                        .length,
                                                                    (int i) {
                                                                      final MeleeWeapon
                                                                      item =
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
                                                                          consumer: (
                                                                            bool r,
                                                                          ) {
                                                                            if (!r &&
                                                                                currFilter.blockedMelees.length +
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
                                                                                        Icons.error,
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
                                                                                  .add(
                                                                                    item,
                                                                                  );
                                                                            } else {
                                                                              currFilter
                                                                                  .blockedMelees
                                                                                  .remove(
                                                                                    item,
                                                                                  );
                                                                            }
                                                                            return true;
                                                                          },
                                                                          child: Row(
                                                                            spacing: 8,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment
                                                                                    .center,
                                                                            children: <
                                                                              Widget
                                                                            >[
                                                                              Image.asset(
                                                                                item.assetPath,
                                                                                width: 52,
                                                                              ),
                                                                              Text(
                                                                                item.canonicalName,
                                                                                style: const TextStyle(
                                                                                  fontSize:
                                                                                      20,
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
                                                          title: const Text(
                                                            "Filter Boosters",
                                                          ),
                                                        ),
                                                        body: Padding(
                                                          padding:
                                                              const EdgeInsets.symmetric(
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
                                                                    message:
                                                                        "Muted Boosters",
                                                                    child: FilterToggleItem(
                                                                      toggled:
                                                                          !currFilter
                                                                              .blockedBoosters
                                                                              .contains(
                                                                                Boosters
                                                                                    .MUTED,
                                                                              ),
                                                                      consumer:
                                                                          (bool r) =>
                                                                              !r
                                                                                  ? currFilter
                                                                                      .blockedBoosters
                                                                                      .add(
                                                                                        Boosters.MUTED,
                                                                                      )
                                                                                  : currFilter
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
                                                                    message:
                                                                        "Bold Boosters",
                                                                    child: FilterToggleItem(
                                                                      toggled:
                                                                          !currFilter
                                                                              .blockedBoosters
                                                                              .contains(
                                                                                Boosters
                                                                                    .BOLD,
                                                                              ),
                                                                      consumer:
                                                                          (bool r) =>
                                                                              !r
                                                                                  ? currFilter
                                                                                      .blockedBoosters
                                                                                      .add(
                                                                                        Boosters.BOLD,
                                                                                      )
                                                                                  : currFilter
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
                                                                                        Boosters.AGGRESIVE,
                                                                                      )
                                                                                  : currFilter
                                                                                      .blockedBoosters
                                                                                      .remove(
                                                                                        Boosters.AGGRESIVE,
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
                    borderRadius: BorderRadius.circular(16),
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
        backgroundColor:
            toggled ? null : AdaptiveTheme.of(context).theme.colorScheme.shadow,
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
  final Widget child;

  const FilterToggleItemExtended({
    super.key,
    this.toggled = true,
    required this.consumer,
    required this.child,
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
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.24,
      child: CustomPaint(
        foregroundPainter: toggled ? null : const DiagonalTracePainter(),
        child: FilledButton(
          onPressed: () {
            setState(() => toggled = widget.consumer(!toggled) ? !toggled : toggled);
          },
          style: FilledButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            foregroundColor:
                AdaptiveTheme.of(context).theme.colorScheme.onPrimaryContainer,
            backgroundColor:
                toggled
                    ? AdaptiveTheme.of(context).theme.colorScheme.primaryContainer
                    : AdaptiveTheme.of(context).theme.colorScheme.surfaceContainerLow,
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
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
        ),
      ),
    );
  }
}
