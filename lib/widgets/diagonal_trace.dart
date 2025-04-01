import 'package:flutter/material.dart';

class DiagonalTracePainter extends CustomPainter {
  final Color color;

  const DiagonalTracePainter([this.color = Colors.red]);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(
      const Offset(4, 4),
      Offset(size.width - 4, size.height - 4),
      Paint()
        ..color = color
        ..strokeWidth = 4.0
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
