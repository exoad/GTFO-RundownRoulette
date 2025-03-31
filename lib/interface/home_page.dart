import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:gtfo_rundown_roulette/interface/laf.dart';
import 'package:gtfo_rundown_roulette/interface/variant_1_page.dart';
import 'package:gtfo_rundown_roulette/public.dart';
import 'package:provider/provider.dart';

class Manager extends StatefulWidget {
  const Manager({super.key});

  @override
  State<Manager> createState() => _ManagerState();
}

class _ManagerState extends State<Manager> {
  int _selected;

  _ManagerState() : _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: NavigationRail(
              labelType: NavigationRailLabelType.all,
              destinations: <NavigationRailDestination>[
                const NavigationRailDestination(
                  icon: Icon(CommunityMaterialIcons.cube_outline),
                  selectedIcon: Icon(CommunityMaterialIcons.cube),
                  label: Text("Home"),
                ),
                const NavigationRailDestination(
                  label: Text("Generic"),
                  icon: Icon(Icons.star_outline_rounded),
                  selectedIcon: Icon(Icons.star_rounded),
                ),
              ],
              useIndicator: true,
              selectedIndex: _selected,
              onDestinationSelected: (int index) => setState(() => _selected = index),
            ),
          ),
          const VerticalDivider(width: 1, thickness: 1),
          Expanded(
            child:
                <Widget>[
                  Scaffold(
                    body: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 20) +
                            const EdgeInsets.only(bottom: 80),
                        child: SizedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const SizedBox(height: 48),
                              ColorFiltered(
                                colorFilter:
                                    AdaptiveTheme.of(context).brightness ==
                                            Brightness.light
                                        ? const ColorFilter.matrix(<double>[
                                          -1.0, 0.0, 0.0, 0.0, 255.0, //
                                          0.0, -1.0, 0.0, 0.0, 255.0, //
                                          0.0, 0.0, -1.0, 0.0, 255.0, //
                                          0.0, 0.0, 0.0, 1.0, 0.0, //
                                        ])
                                        : const ColorFilter.matrix(<double>[
                                          1.0, 0.0, 0.0, 0.0, 0.0, //
                                          0.0, 1.0, 0.0, 0.0, 0.0, //
                                          0.0, 0.0, 1.0, 0.0, 0.0, //
                                          0.0, 0.0, 0.0, 1.0, 0.0, //
                                        ]),
                                child: Image.asset("assets/icon.png"),
                              ),
                              const Text(
                                "GTFO Rundown Roulette",
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                "Build ${Public.build}",
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                              const SizedBox(height: 12),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 40),
                                child: Text(
                                  "A randomizer focused around making playing GTFO much more enjoyable without involving the usage of that many mods if at all.",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(height: 24),
                              Wrap(
                                runAlignment: WrapAlignment.center,
                                alignment: WrapAlignment.center,
                                spacing: 10,
                                runSpacing: 10,
                                children: <Widget>[
                                  FilledButton.icon(
                                    label: const Text("Source Code"),
                                    icon: const Icon(Icons.code),
                                    onPressed: () {},
                                  ),
                                  FilledButton.icon(
                                    label: const Text("GTFO Discord"),
                                    icon: const Icon(Icons.discord),
                                    onPressed: () {},
                                  ),
                                  FilledButton.icon(
                                    label: const Text("GTFO Wiki"),
                                    icon: const Icon(Icons.menu_book),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                              const SizedBox(height: 18),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 40),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color:
                                        AdaptiveTheme.of(
                                          context,
                                        ).theme.colorScheme.secondaryContainer,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  child: const Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(Icons.warning_amber_rounded),
                                          SizedBox(width: 6),
                                          Text(
                                            "Disclaimer",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic,
                                              fontSize: 12,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                        ],
                                      ),
                                      Text(
                                        "This application is an independent creation and is not affiliated with, endorsed, or sponsored by 10 Chambers or the creators of GTFO. All game assets, including but not limited to images, sounds, character names, and logos, are the property of 10 Chambers.",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 16,
                                  horizontal: 40,
                                ),
                                child: Divider(),
                              ),
                              const Icon(Icons.settings, size: 32),
                              const Text(
                                "Settings",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 16),
                              _SettingsWidget(
                                leading: "Theme Mode",
                                trailing: Switch(
                                  value:
                                      AdaptiveTheme.of(context).mode ==
                                      AdaptiveThemeMode.dark,
                                  onChanged:
                                      (bool v) =>
                                          v
                                              ? AdaptiveTheme.of(context).setDark()
                                              : AdaptiveTheme.of(context).setLight(),
                                ),
                              ),
                              const SizedBox(height: 8),
                              _SettingsWidget(
                                leading: "Theme Seed Color",
                                trailing: FilledButton(
                                  child: const Icon(Icons.color_lens_rounded),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder:
                                          (BuildContext context) => AlertDialog(
                                            title: const Text("Color Picker"),
                                            content: SingleChildScrollView(
                                              child: BlockPicker(
                                                pickerColor:
                                                    Provider.of<Laf>(context).seedColor,
                                                onColorChanged: (Color color) {
                                                  Provider.of<Laf>(context, listen: false)
                                                      .seedColor = color;
                                                  AdaptiveTheme.of(context).setTheme(
                                                    light: ThemeData(
                                                      useMaterial3: true,
                                                      brightness: Brightness.light,
                                                      colorSchemeSeed: color,
                                                    ),
                                                    dark: ThemeData(
                                                      useMaterial3: true,
                                                      brightness: Brightness.dark,
                                                      colorSchemeSeed: color,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            actions: <Widget>[
                                              FilledButton(
                                                child: const Text("Ok"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
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
                  const Variant1RootScaffold(),
                ][_selected],
          ),
        ],
      ),
    );
  }
}

class _SettingsWidget extends StatelessWidget {
  final Widget trailing;
  final String leading;

  const _SettingsWidget({required this.leading, required this.trailing});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(leading, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
        const SizedBox(width: 24),
        trailing,
      ],
    );
  }
}
