import 'package:flutter/material.dart';
import 'package:gtfo_rundown_roulette/interface/provider/current_run.dart';
import 'package:gtfo_rundown_roulette/interface/provider/current_skeleton_run.dart';
import 'package:gtfo_rundown_roulette/interface/root.dart';
import 'package:gtfo_rundown_roulette/public.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:toastification/toastification.dart';

/// everything of the ui/ux part starts here
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        // add global providers here
        ChangeNotifierProvider<CurrentRun>.value(value: CurrentRun.instance),
        ChangeNotifierProvider<CurrentSkeletonRun>.value(value: CurrentSkeletonRun.instance),
      ],
      builder:
          // the toastification package is used here to provide for easy use of toasts and building custom toasts
          // anywhere in the application
          (BuildContext context, Widget? child) => ToastificationWrapper(
            child: DefaultTextStyle(
              // shared tech is a font that i scraped from online information
              // the other font gtfo uses is fira code
              style: const TextStyle(fontFamily: "Shared Tech", color: PublicTheme.normalWhite),
              // using a materialapp because it is the simplest way to start off a fully custom laf flutter app
              child: MaterialApp(
                // theming the actual application with the proper colors and styles from gtfo
                theme: ThemeData(
                  textSelectionTheme: TextSelectionThemeData(
                    cursorColor: PublicTheme.normalWhite,
                    selectionColor: PublicTheme.loreYellow.withAlpha(140),
                  ),
                  inputDecorationTheme: const InputDecorationTheme(
                    alignLabelWithHint: true,
                    focusColor: PublicTheme.normalWhite,
                    filled: true,
                    fillColor: PublicTheme.abyssBlack,
                    counterStyle: TextStyle(
                      fontFamily: "Fira Code",
                      color: PublicTheme.normalWhite,
                    ),
                    errorStyle: TextStyle(color: PublicTheme.dangerRed),
                    contentPadding: EdgeInsets.only(left: 6, top: 0, bottom: 0),
                    border: OutlineInputBorder(
                      gapPadding: 0,
                      borderSide: BorderSide(color: PublicTheme.normalWhite, width: 2),
                      borderRadius: BorderRadius.zero,
                    ),
                    enabledBorder: OutlineInputBorder(
                      gapPadding: 0,
                      borderSide: BorderSide(color: PublicTheme.normalWhite, width: 2),
                      borderRadius: BorderRadius.zero,
                    ),
                    focusedBorder: OutlineInputBorder(
                      gapPadding: 0,
                      borderSide: BorderSide(color: PublicTheme.loreYellow, width: 2),
                      borderRadius: BorderRadius.zero,
                    ),
                    disabledBorder: OutlineInputBorder(
                      gapPadding: 0,
                      borderSide: BorderSide(color: PublicTheme.hiddenGray, width: 2),
                      borderRadius: BorderRadius.zero,
                    ),
                    hintStyle: TextStyle(fontFamily: "Fira Code", color: PublicTheme.hiddenGray),
                  ),
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
                    actionsIconTheme: IconThemeData(color: PublicTheme.normalWhite),
                    iconTheme: IconThemeData(color: PublicTheme.normalWhite),
                    foregroundColor: PublicTheme.normalWhite,
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
                // Manager is for the page manager and operates the side navrail and the page display
                home: const Manager(),
              ),
            ),
          ),
    );
  }
}
