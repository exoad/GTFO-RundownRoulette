import 'package:flutter/material.dart';
import 'package:gtfo_rundown_roulette/interface/provider/current_run.dart';
import 'package:gtfo_rundown_roulette/interface/root.dart';
import 'package:gtfo_rundown_roulette/public.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:toastification/toastification.dart';

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
        ChangeNotifierProvider<CurrentRun>.value(value: CurrentRun.instance),
      ],
      builder:
          (BuildContext context, Widget? child) => ToastificationWrapper(
            child: DefaultTextStyle(
              style: const TextStyle(fontFamily: "Shared Tech", color: PublicTheme.normalWhite),
              child: MaterialApp(
                theme: ThemeData(
                  scaffoldBackgroundColor: PublicTheme.abyssBlack,
                  navigationRailTheme: const NavigationRailThemeData(
                    backgroundColor: PublicTheme.abyssBlack,
                    elevation: 0,
                    indicatorColor: PublicTheme.abyssBlack,
                    selectedLabelTextStyle: TextStyle(color: PublicTheme.highlightOrange),
                    unselectedLabelTextStyle: TextStyle(color: PublicTheme.normalWhite),
                    selectedIconTheme: IconThemeData(color: PublicTheme.highlightOrange),
                    unselectedIconTheme: IconThemeData(color: PublicTheme.normalWhite),
                    indicatorShape: Border(
                      left: BorderSide(color: PublicTheme.highlightOrange, width: 5),
                      bottom: BorderSide(color: PublicTheme.highlightOrange, width: 2),
                      top: BorderSide(color: PublicTheme.highlightOrange, width: 2),
                      right: BorderSide(color: PublicTheme.highlightOrange, width: 2),
                    ),
                  ),
                ),

                debugShowCheckedModeBanner: false,
                home: const Manager(),
              ),
            ),
          ),
    );
  }
}
