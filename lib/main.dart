import 'package:flutter/material.dart';
import 'package:gtfo_rundown_roulette/interface/current_run.dart';
import 'package:gtfo_rundown_roulette/shared/shared.dart';
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
        ChangeNotifierProvider<CurrentRun>.value(value: CurrentRun.instance),
      ],
      child: const MaterialApp(debugShowCheckedModeBanner: false, home: _Manager()),
    );
  }
}

class _Manager extends StatefulWidget {
  const _Manager();

  @override
  State<_Manager> createState() => _ManagerState();
}

class _ManagerState extends State<_Manager> {
  int _selected;
  late List<Widget> dests;

  _ManagerState() : _selected = 0;

  @override
  void initState() {
    super.initState();
    dests = <Widget>[const Variant1RootScaffold()];
  }

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
          Expanded(child: dests[_selected]),
        ],
      ),
    );
  }
}

class Variant1RootScaffold extends StatelessWidget {
  const Variant1RootScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Variant 1')),
      floatingActionButton: FloatingActionButton(
        onPressed:
            () =>
                Provider.of<CurrentRun>(
                  context,
                  listen: false,
                ).value = Variant1Generator.produceFrom(Preset.vanilla),
        child: const Icon(Icons.casino_rounded),
      ),
      body: const _ContentBody(),
    );
  }
}

class _ContentBody extends StatelessWidget {
  const _ContentBody();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Selected: ${Provider.of<CurrentRun>(context).run?.mission.canonicalName}",
      ),
    );
  }
}
