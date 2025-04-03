import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:gtfo_rundown_roulette/interface/pages/home_page.dart';
import 'package:gtfo_rundown_roulette/interface/pages/variant_1_page.dart';
import 'package:gtfo_rundown_roulette/interface/pages/variant_2_page.dart';
import 'package:gtfo_rundown_roulette/interface/widgets/sanctioned.dart';

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
                  label: Text("HOME"),
                ),
                const NavigationRailDestination(
                  label: Text("GENERIC"),
                  icon: Icon(Icons.star_border),
                  selectedIcon: Icon(Icons.star),
                ),
                const NavigationRailDestination(
                  icon: Icon(CommunityMaterialIcons.cash),
                  selectedIcon: Icon(CommunityMaterialIcons.cash_100),
                  label: Text("AUCTION"),
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
                  const Variant2Page().sanctioned,
                ][_selected],
          ),
        ],
      ),
    );
  }
}
