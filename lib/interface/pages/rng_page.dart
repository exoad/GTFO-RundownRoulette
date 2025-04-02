import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gtfo_rundown_roulette/shared/shared.dart';
import 'package:gtfo_rundown_roulette/interface/widgets/clipbox.dart';

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

class _GeneratorWidgetState extends State<_GeneratorWidget>
    with AutomaticKeepAliveClientMixin {
  int _selected;
  int _max = 10;
  int _min = 0;
  late final TextEditingController _minController;
  late final TextEditingController _maxController;

  _GeneratorWidgetState() : _selected = 0;

  @override
  void initState() {
    super.initState();
    _minController = TextEditingController(text: _min.toString());
    _maxController = TextEditingController(text: _max.toString());
  }

  @override
  void dispose() {
    _minController.dispose();
    _maxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: EdgeInsets.all(MediaQuery.sizeOf(context).width * 0.04),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.36,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AdaptiveTheme.of(context).theme.colorScheme.secondaryContainer,
        ),
        padding: const EdgeInsets.all(22),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            ClipBox(
              background: AdaptiveTheme.of(context).theme.colorScheme.surfaceContainer,
              childPadding: const EdgeInsets.all(12),
              borderRadius: BorderRadius.circular(16),
              child: Text(
                _selected.toString(),
                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 6,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _minController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: const InputDecoration(
                      label: Text("Min"),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (String value) {
                      if (value.isNotEmpty) {
                        _min = int.parse(value);
                      }
                    },
                  ),
                ),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    controller: _maxController,
                    onChanged: (String value) {
                      if (value.isNotEmpty) {
                        _max = int.parse(value);
                      }
                    },
                    decoration: const InputDecoration(
                      label: Text("Max"),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: <Widget>[
                const Spacer(),
                ElevatedButton.icon(
                  onPressed:
                      () => setState(
                        () => _selected = rnd.nextInt((_max - _min).abs()) + _min,
                      ),
                  label: const Text("Roll"),
                  icon: const Icon(Icons.refresh),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
