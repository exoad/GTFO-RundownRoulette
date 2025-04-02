import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:gtfo_rundown_roulette/interface/pages/home_page.dart';
import 'package:gtfo_rundown_roulette/interface/pages/rng_page.dart';
import 'package:gtfo_rundown_roulette/interface/pages/variant_1_page.dart';

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
                const NavigationRailDestination(
                  icon: Icon(Icons.rocket_launch_rounded),
                  label: Text("RNG"),
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
                  const HomePage(),
                  const Variant1RootScaffold(),
                  const NumberGeneratorPage(),
                ][_selected],
          ),
        ],
      ),
    );
  }
}
