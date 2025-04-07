import 'package:flutter/material.dart';
import 'package:gtfo_rundown_roulette/interface/provider/current_run.dart';
import 'package:gtfo_rundown_roulette/interface/root.dart';
import 'package:gtfo_rundown_roulette/public.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:toastification/toastification.dart';

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
                  dialogTheme: const DialogTheme(
                    titleTextStyle: TextStyle(
                      color: PublicTheme.normalWhite,
                      fontFamily: "Shared Tech",
                      fontSize: 18,
                    ),
                    insetPadding: EdgeInsets.zero,
                    actionsPadding: EdgeInsets.all(10),
                    backgroundColor: PublicTheme.murkyDarkGrey,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: PublicTheme.normalWhite, width: 2),
                    ),
                  ),
                  appBarTheme: const AppBarTheme(
                    backgroundColor: PublicTheme.abyssBlack,
                    titleTextStyle: TextStyle(
                      color: PublicTheme.normalWhite,
                      fontFamily: "Shared Tech",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  expansionTileTheme: ExpansionTileThemeData(
                    collapsedShape: const Border(
                      left: BorderSide(color: PublicTheme.hiddenGray, width: 5),
                      bottom: BorderSide(color: PublicTheme.hiddenGray, width: 2),
                      top: BorderSide(color: PublicTheme.hiddenGray, width: 2),
                      right: BorderSide(color: PublicTheme.hiddenGray, width: 2),
                    ),
                    iconColor: PublicTheme.normalWhite,
                    collapsedIconColor: PublicTheme.hiddenGray,
                    collapsedTextColor: PublicTheme.hiddenGray,
                    expandedAlignment: Alignment.center,
                    backgroundColor: PublicTheme.murkyDarkGrey,
                    collapsedBackgroundColor: PublicTheme.abyssBlack,
                    textColor: PublicTheme.normalWhite,
                    expansionAnimationStyle: AnimationStyle(
                      duration: const Duration(milliseconds: 80),
                    ),
                    shape: const Border(
                      left: BorderSide(color: PublicTheme.normalWhite, width: 5),
                      bottom: BorderSide(color: PublicTheme.normalWhite, width: 2),
                      top: BorderSide(color: PublicTheme.normalWhite, width: 2),
                      right: BorderSide(color: PublicTheme.normalWhite, width: 2),
                    ),
                  ),
                  splashFactory: NoSplash.splashFactory,
                  dividerTheme: const DividerThemeData(color: Colors.transparent),
                  listTileTheme: const ListTileThemeData(dense: true),
                  dividerColor: Colors.transparent,
                  scaffoldBackgroundColor: PublicTheme.abyssBlack,
                  navigationRailTheme: const NavigationRailThemeData(
                    backgroundColor: PublicTheme.abyssBlack,
                    elevation: 0,
                    indicatorColor: PublicTheme.abyssBlack,
                    selectedLabelTextStyle: TextStyle(
                      color: PublicTheme.highlightOrange,
                      fontFamily: "Shared Tech",
                    ),
                    unselectedLabelTextStyle: TextStyle(
                      color: PublicTheme.normalWhite,
                      fontFamily: "Shared Tech",
                    ),
                    labelType: NavigationRailLabelType.all,
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
