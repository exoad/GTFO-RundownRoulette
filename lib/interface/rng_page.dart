import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

class NumberGeneratorPage extends StatelessWidget {
  const NumberGeneratorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(fontFamily: "Shared Tech"),
      child: Scaffold(
        appBar: AppBar(title: const Text("Number Generator")),
        body: const Column(children: <Widget>[_GeneratorWidget()]),
      ),
    );
  }
}

class _GeneratorWidget extends StatefulWidget {
  const _GeneratorWidget();

  @override
  State<_GeneratorWidget> createState() => _GeneratorWidgetState();
}

class _GeneratorWidgetState extends State<_GeneratorWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.sizeOf(context).width * 0.04),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AdaptiveTheme.of(context).theme.colorScheme.secondaryContainer,
        ),
        padding: const EdgeInsets.all(8),
        child: const Column(children: <Widget>[Text("00"), Row(children: <Widget>[])]),
      ),
    );
  }
}
