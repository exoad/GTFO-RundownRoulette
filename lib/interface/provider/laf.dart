import 'package:flutter/material.dart';

class Laf with ChangeNotifier {
  Color _seedColor = Colors.amber;

  set seedColor(Color color) {
    _seedColor = color;
    notifyListeners();
  }

  Color get seedColor => _seedColor;
}
