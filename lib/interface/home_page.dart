import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:gtfo_rundown_roulette/interface/laf.dart';
import 'package:gtfo_rundown_roulette/public.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
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
                      AdaptiveTheme.of(context).brightness == Brightness.light
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
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  "Build ${Public.build} | Signature ${Public.versionSignature}",
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
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child:
                      kIsWeb
                          ? const Text(
                            "This app is also available for Windows desktop so you can use it offline! Visit the Source Repository to download it.",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                          : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text(
                                "This app is also available in your browser! Visit it at exoad.github.io/GTFO-RundownRoulette/",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(width: 4),
                              IconButton.filled(
                                visualDensity: VisualDensity.compact,
                                onPressed:
                                    () async => await launchUrlString(
                                      "https://exoad.github.io/GTFO-RundownRoulette/",
                                    ),
                                icon: const Icon(Icons.open_in_browser),
                              ),
                            ],
                          ),
                ),
                const SizedBox(height: 24),
                Wrap(
                  runAlignment: WrapAlignment.center,
                  alignment: WrapAlignment.center,
                  spacing: 10,
                  runSpacing: 10,
                  children: <Widget>[
                    Tooltip(
                      message: "https://github.com/exoad/GTFO-RundownRoulette",
                      child: FilledButton.icon(
                        label: const Text("Source Repository"),
                        icon: const Icon(Icons.code),
                        onPressed:
                            () async => await launchUrlString(
                              "https://github.com/exoad/GTFO-RundownRoulette",
                            ),
                      ),
                    ),
                    Tooltip(
                      message: "https://discord.com/invite/gtfo",
                      child: FilledButton.icon(
                        label: const Text("GTFO Discord"),
                        icon: const Icon(Icons.discord),
                        onPressed:
                            () async =>
                                await launchUrlString("https://discord.com/invite/gtfo"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          AdaptiveTheme.of(context).theme.colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                          style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                  child: Divider(),
                ),
                const Icon(Icons.settings, size: 32),
                const Text(
                  "Settings",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 16),
                _SettingsWidget(
                  leading: "Theme Mode",
                  trailing: Switch(
                    value: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark,
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
                                  pickerColor: Provider.of<Laf>(context).seedColor,
                                  onColorChanged: (Color color) {
                                    Provider.of<Laf>(context, listen: false).seedColor =
                                        color;
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
