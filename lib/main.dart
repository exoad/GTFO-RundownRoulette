import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:gtfo_rundown_roulette/interface/current_run.dart';
import 'package:gtfo_rundown_roulette/interface/home_page.dart';
import 'package:gtfo_rundown_roulette/interface/laf.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider<Laf>(create: (BuildContext _) => Laf()),
        ChangeNotifierProvider<CurrentRun>.value(value: CurrentRun.instance),
      ],
      builder:
          (BuildContext context, Widget? child) => AdaptiveTheme(
            light: ThemeData(
              useMaterial3: true,
              brightness: Brightness.light,
              colorSchemeSeed: Provider.of<Laf>(context).seedColor,
            ),
            dark: ThemeData(
              useMaterial3: true,
              brightness: Brightness.dark,
              colorSchemeSeed: Provider.of<Laf>(context).seedColor,
            ),
            initial: AdaptiveThemeMode.dark,
            builder:
                (ThemeData data, ThemeData darkTheme) => MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: data,
                  darkTheme: darkTheme,
                  home: const Manager(),
                ),
          ),
    );
  }
}

