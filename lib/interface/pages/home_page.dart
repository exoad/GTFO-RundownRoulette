import 'package:animated_glitch/animated_glitch.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gtfo_rundown_roulette/interface/widgets/core/normal_box.dart';
import 'package:gtfo_rundown_roulette/interface/widgets/core/drooped_divider.dart';
import 'package:gtfo_rundown_roulette/interface/widgets/random_text.dart';
import 'package:gtfo_rundown_roulette/interface/widgets/split_tile.dart';
import 'package:gtfo_rundown_roulette/main.dart';
import 'package:gtfo_rundown_roulette/public.dart';
import 'package:gtfo_rundown_roulette/utils/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';

/// Home page, the thing that is shown on the front page.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTextStyle(
        style: const TextStyle(fontFamily: "Shared Tech"),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20) + const EdgeInsets.only(bottom: 80),
              child: SizedBox(
                // we confine everything to be of the same width.
                // this is so that the mission mock box is the same size as the other elements
                //
                // tldr: looks good
                width: MediaQuery.sizeOf(context).width * 0.4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // a lot of the custom spacing is done through sized boxes since the flex widget's spacing cant be dynamically changed, so this is a generous solution
                    const SizedBox(height: 48),
                    if (context
                        .mounted) // we need this so we make sure we only render this "costly" effect when this element is mounted in the widget tree.
                      RepaintBoundary(
                        child: SizedBox.square(
                          dimension: 148,
                          child: AnimatedGlitch(
                            controller: AnimatedGlitchController(
                              // frequencies have similar parameters to Title widget, but they are varied so they arent trying to refresh as similarly as possible
                              frequency: const Duration(milliseconds: 600),
                              chance: 60,
                              level: 2,
                            ),
                            child: Image.asset(
                              "assets/icon.png",
                              width: 128,
                              height: 128,
                              cacheHeight: 128,
                              cacheWidth: 128,
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(height: 20),
                    // once again, we need to check if this current element is mounted in the widget tree to determine if we should render this costly effect or not
                    if (context.mounted)
                      const RepaintBoundary(child: SizedBox(height: 64, child: _Title())),
                    const SizedBox(height: 8),
                    const Text(
                      "BUILD ${Public.build} | SIG ${Public.versionSignature} | ${Public.isRelease ? 'PUB' : 'DEV'}",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: PublicTheme.loreYellow),
                    ),
                    const SizedBox(height: 12),
                    // this is the mission mock box where we try to mock the look and feel of the mission box of the GTFO game
                    // each rundown in GTFO when you click it shows a popup of some of the information for that particular mission
                    // this here tries to replicate that look with some minor cuts.
                    //
                    // additionally there is a custom widget used for the divider known as the DroopedDivider which
                    // you can view under the 'widgets' dir. it is used to mimic the look and feel further instead of using a normal divider widget
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: PublicTheme.normalWhite, width: 2),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                      child: const Column(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 4),
                                child: Text(
                                  "://Intel_",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: "Fira Code",
                                    fontWeight: FontWeight.bold,
                                    color: PublicTheme.loreYellow,
                                  ),
                                ),
                              ),
                              SizedBox(height: 4),
                              Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Text(
                                  "Critical Pr0C3S# OffLIn&3. Prisoner disP4TcH3d t0 ?!...",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: PublicTheme.normalWhite,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                child: DroopedDivider(
                                  color: PublicTheme.normalWhite,
                                  thickness: 2,
                                  amount: 8,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 4),
                                child: Text(
                                  ":://Interrupted_Communications_",
                                  style: TextStyle(
                                    fontFamily: "Fira Code",
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: PublicTheme.loreYellow,
                                  ),
                                ),
                              ),
                              SizedBox(height: 4),
                              Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Text.rich(
                                  TextSpan(
                                    children: <InlineSpan>[
                                      TextSpan(text: ">...Wh..What!? I fucking got "),
                                      TextSpan(
                                        text: "NOTHING",
                                        style: TextStyle(
                                          fontSize: 24,
                                          color: PublicTheme.dangerRed,
                                        ),
                                      ),
                                      TextSpan(text: "...\n>...Let's just"),
                                      TextSpan(
                                        text: " get through ",
                                        style: TextStyle(
                                          fontSize: 24,
                                          color: PublicTheme.dangerRed,
                                          wordSpacing: -1,
                                        ),
                                      ),
                                      TextSpan(text: " it.\n>[primal roar]"),
                                    ],
                                  ),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: PublicTheme.normalWhite,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                child: SizedBox(
                                  child: DroopedDivider(
                                    color: PublicTheme.normalWhite,
                                    thickness: 2,
                                    amount: 8,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 4),
                                child: Text(
                                  ":://Expedition_metrics_",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: "Fira Code",
                                    fontWeight: FontWeight.bold,
                                    color: PublicTheme.loreYellow,
                                  ),
                                ),
                              ),
                              SizedBox(height: 4),
                              Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      "Drop cage target depth: ",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: PublicTheme.normalWhite,
                                        fontFamily: "Shared Tech",
                                      ),
                                    ),
                                    SizedBox(width: 6),
                                    FlashingRandomNumberWidget(
                                      length: 4,
                                      period: Duration(milliseconds: 150),
                                      style: TextStyle(
                                        color: PublicTheme.metricsYellow,
                                        fontSize: 20,
                                      ),
                                    ),
                                    SizedBox(width: 6),
                                    Text(
                                      "m",
                                      style: TextStyle(
                                        color: PublicTheme.metricsYellow,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 4),
                              Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      "Artifact Heat: ",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: PublicTheme.normalWhite,
                                        fontFamily: "Shared Tech",
                                      ),
                                    ),
                                    SizedBox(width: 6),
                                    Text(
                                      "69%",
                                      style: TextStyle(
                                        color: PublicTheme.metricsYellow,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 26),
                    const Text(
                      "A randomizer focused around making playing GTFO much more enjoyable without involving the usage of that many mods if at all.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: PublicTheme.normalWhite),
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child:
                          kIsWeb
                              ? const Text(
                                "This app is also available for Windows desktop so you can use it offline! Visit the Source Repository to download it.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: PublicTheme.hiddenGray,
                                ),
                              )
                              : Wrap(
                                alignment: WrapAlignment.center,
                                runAlignment: WrapAlignment.center,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: <Widget>[
                                  const Text(
                                    "This app is also available in your browser! Visit it at exoad.github.io/GTFO-RundownRoulette/",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: PublicTheme.hiddenGray,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  UINormalBoxButton(
                                    onTap:
                                        () async => await launchUrlString(
                                          "https://exoad.github.io/GTFO-RundownRoulette/",
                                        ),
                                    child: const Icon(Icons.open_in_browser),
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
                          message: "Configure the application",
                          child: UINormalBoxButton(
                            foregroundColor: PublicTheme.dangerRed,
                            child: const Text(
                              "SETTINGS",
                              style: TextStyle(
                                fontFamily: "Shared Tech",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap:
                                () async => await showDialog(
                                  context: context,
                                  builder: (BuildContext context) => const _SettingsMenu(),
                                ),
                          ),
                        ),
                        Tooltip(
                          message: "https://github.com/exoad/GTFO-RundownRoulette",
                          child: UINormalBoxButton(
                            onTap:
                                () async => await launchUrlString(
                                  "https://github.com/exoad/GTFO-RundownRoulette",
                                ),
                            foregroundColor: PublicTheme.loreYellow,
                            child: const Text("SOURCE CODE"),
                          ),
                        ),
                        Tooltip(
                          message: "https://discord.com/invite/gtfo",
                          child: UINormalBoxButton(
                            onTap:
                                () async =>
                                    await launchUrlString("https://discord.com/invite/gtfo"),
                            foregroundColor: PublicTheme.loreYellow,
                            child: const Text("GTFO DISCORD"),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    const UINormalBox(
                      thick: true,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        child: Column(
                          spacing: 6,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.warning_amber_rounded),
                                SizedBox(width: 6),
                                Text(
                                  "DISCLAIMER & INFORMATION",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                              ],
                            ),
                            Text(
                              "This application is an independent creation and is not affiliated with, endorsed, or sponsored by 10 Chambers or the creators of GTFO. All game assets, including but not limited to images, sounds, character names, and logos, are the property of 10 Chambers. \n\nAdditionally, this application does not collect telemetry of any kind (even analytics and crash reports!). However the web version is hosted on GitHub which may collect your internet footprints. If you do not like Microsoft, you can download the desktop build above.",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SettingsMenu extends StatefulWidget {
  const _SettingsMenu();

  @override
  State<_SettingsMenu> createState() => _SettingsMenuState();
}

class _SettingsMenuState extends State<_SettingsMenu> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Settings",
        style: TextStyle(fontSize: 20, fontFamily: "Shared Tech", fontWeight: FontWeight.bold),
      ),
      content: SplitTile(<Widget, Widget>{
        const SplitTileSingulateLabel(
          "Color Lobby",
          description: "Use colors, let players decide based on their color in the lobby.",
        ): UINormalBoxButton(
          foregroundColor:
              kPrefs.getSafeBool("color_lobby") ? PublicTheme.loreYellow : PublicTheme.hiddenGray,
          onTap: () {
            kPrefs.setBool(
              "color_lobby",
              kPrefs.getBool("color_lobby") == null ? true : !kPrefs.getBool("color_lobby")!,
            );
            setState(() {});
          },
          child:
              kPrefs.getSafeBool("color_lobby")
                  ? const Icon(Icons.circle)
                  : const Icon(Icons.circle_outlined),
        ),
        const SplitTileSingulateLabel(
          "Animated Randomizer",
          description:
              "An animation will be used for randomization.\nTurning off will make randomization instant.",
        ): UINormalBoxButton(
          foregroundColor:
              kPrefs.getSafeBool("randomization_animation")
                  ? PublicTheme.loreYellow
                  : PublicTheme.hiddenGray,
          onTap: () {
            kPrefs.setBool(
              "randomization_animation",
              kPrefs.getBool("randomization_animation") == null
                  ? true
                  : !kPrefs.getBool("randomization_animation")!,
            );
            setState(() {});
          },
          child:
              kPrefs.getSafeBool("randomization_animation")
                  ? const Icon(Icons.circle)
                  : const Icon(Icons.circle_outlined),
        ),
      }),
      actions: <Widget>[
        UINormalBoxButton(
          foregroundColor: PublicTheme.dangerRed,
          child: const Text("Ok"),
          onTap: () => Navigator.pop(context),
        ),
      ],
    );
  }
}

class _Title extends StatefulWidget {
  const _Title();

  @override
  State<_Title> createState() => _TitleState();
}

class _TitleState extends State<_Title> with SingleTickerProviderStateMixin {
  late AnimatedGlitchController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimatedGlitchController(
      frequency: const Duration(milliseconds: 600),
      chance: 60,
      level: 2,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedGlitch(
      controller: _controller,
      child:
          const Text(
            "RUNDOWN ROULETTE",
            style: TextStyle(
              fontSize: 48,
              fontFamily: "Shared Tech",
              fontWeight: FontWeight.bold,
              color: PublicTheme.loreYellow,
              overflow: TextOverflow.visible,
            ),
            softWrap: true,
            textAlign: TextAlign.center,
          ).animate(),
    );
  }
}
