import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class FlashingRandomTextWidget extends StatefulWidget {
  final int length;
  final Duration period;
  final TextStyle style;
  final String? selection;
  const FlashingRandomTextWidget({
    super.key,
    required this.length,
    this.selection,
    this.period = const Duration(milliseconds: 50),
    required this.style,
  });

  @override
  State<FlashingRandomTextWidget> createState() => _FlashingRandomTextWidgetState();
}

class FlashingRandomNumberWidget extends StatefulWidget {
  final int length;
  final Duration period;
  final TextStyle style;
  const FlashingRandomNumberWidget({
    super.key,
    required this.length,
    this.period = const Duration(milliseconds: 50),
    required this.style,
  });

  @override
  State<FlashingRandomNumberWidget> createState() => _FlashingRandomNumberWidgetState();
}

const String _numbers = '0123456789';

class _FlashingRandomNumberWidgetState extends State<FlashingRandomNumberWidget> {
  late Timer _timer;
  String _randomString = '';

  static final Random _rnd = Random();

  @override
  void initState() {
    super.initState();
    _randomString = String.fromCharCodes(
      Iterable<int>.generate(
        widget.length,
        (_) => _numbers.codeUnitAt(_rnd.nextInt(_numbers.length)),
      ),
    );
    _timer = Timer.periodic(
      widget.period,
      (_) => setState(
        () =>
            _randomString = String.fromCharCodes(
              Iterable<int>.generate(
                widget.length,
                (_) => _numbers.codeUnitAt(_rnd.nextInt(_numbers.length)),
              ),
            ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(_randomString, style: widget.style));
  }
}

const String _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#\$%^&*()';

class _FlashingRandomTextWidgetState extends State<FlashingRandomTextWidget> {
  late Timer _timer;
  late final String _selection;
  String _randomString = '';

  static final Random _rnd = Random();

  @override
  void initState() {
    super.initState();
    _selection = widget.selection ?? _chars;
    _randomString = String.fromCharCodes(
      Iterable<int>.generate(
        widget.length,
        (_) => _selection.codeUnitAt(_rnd.nextInt(_selection.length)),
      ),
    );
    _timer = Timer.periodic(
      widget.period,
      (_) => setState(
        () =>
            _randomString = String.fromCharCodes(
              Iterable<int>.generate(
                widget.length,
                (_) => _selection.codeUnitAt(_rnd.nextInt(_selection.length)),
              ),
            ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(_randomString, style: widget.style));
  }
}
