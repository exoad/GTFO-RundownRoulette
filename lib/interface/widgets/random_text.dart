import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class FlashingRandomTextWidget extends StatefulWidget {
  final int length;
  final Duration period;
  final TextStyle style;
  const FlashingRandomTextWidget({
    super.key,
    required this.length,
    this.period = const Duration(milliseconds: 50),
    required this.style,
  });

  @override
  State<FlashingRandomTextWidget> createState() => _FlashingRandomTextWidgetState();
}

class _FlashingRandomTextWidgetState extends State<FlashingRandomTextWidget> {
  late Timer _timer;
  String _randomString = '';
  static const String _chars =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#\$%^&*()';
  final Random _rnd = Random();

  @override
  void initState() {
    super.initState();
    _randomString = String.fromCharCodes(
      Iterable<int>.generate(widget.length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))),
    );
    _timer = Timer.periodic(
      widget.period,
      (_) => setState(
        () =>
            _randomString = String.fromCharCodes(
              Iterable<int>.generate(
                widget.length,
                (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length)),
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
