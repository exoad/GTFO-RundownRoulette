import 'package:animated_glitch/animated_glitch.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gtfo_rundown_roulette/interface/widgets/core/normal_box.dart';
import 'package:gtfo_rundown_roulette/public.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTextStyle(
        style: const TextStyle(fontFamily: "Shared Tech"),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20) + const EdgeInsets.only(bottom: 80),
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 48),
                  Image.asset("assets/icon.png"),
                  const SizedBox(height: 48, child: _Title()),
                  const SizedBox(height: 8),
                  const Text(
                    "Build ${Public.build} | Signature ${Public.versionSignature}",
                    style: TextStyle(fontStyle: FontStyle.italic, color: PublicTheme.loreYellow),
                  ),
                  const SizedBox(height: 12),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      "A randomizer focused around making playing GTFO much more enjoyable without involving the usage of that many mods if at all.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: PublicTheme.normalWhite),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child:
                        kIsWeb
                            ? const Text(
                              "This app is also available for Windows desktop so you can use it offline! Visit the Source Repository to download it.",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: PublicTheme.hiddenGray,
                              ),
                            )
                            : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Text(
                                  "This app is also available in your browser! Visit it at exoad.github.io/GTFO-RundownRoulette/",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 4),
                                GestureDetector(
                                  onTap:
                                      () async => await launchUrlString(
                                        "https://exoad.github.io/GTFO-RundownRoulette/",
                                      ),
                                  child: const UINormalBox(child: Icon(Icons.open_in_browser)),
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
                        child: GestureDetector(
                          onTap:
                              () async => await launchUrlString(
                                "https://github.com/exoad/GTFO-RundownRoulette",
                              ),
                          child: const UINormalBox(
                            foregroundColor: PublicTheme.loreYellow,
                            child: Text("Source Repository"),
                          ),
                        ),
                      ),
                      Tooltip(
                        message: "https://discord.com/invite/gtfo",
                        child: GestureDetector(
                          onTap:
                              () async => await launchUrlString("https://discord.com/invite/gtfo"),
                          child: const UINormalBox(
                            foregroundColor: PublicTheme.loreYellow,
                            child: Text("GTFO Discord"),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: UINormalBox(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        child: Column(
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
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                    child: Divider(),
                  ),
                  const Icon(Icons.settings, size: 32),
                ],
              ),
            ),
          ),
        ),
      ),
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
      frequency: const Duration(milliseconds: 700),
      chance: 80,
      level: 2,
      distortionShift: const DistortionShift(count: 4, delay: Duration(milliseconds: 100)),
      colorChannelShift: const ColorChannelShift(
        colors: <Color>[Colors.red, Colors.blue, Colors.white],
      ),
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
            "GTFO Rundown Roulette",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: PublicTheme.loreYellow,
            ),
            textAlign: TextAlign.center,
          ).animate(),
    );
  }
}
