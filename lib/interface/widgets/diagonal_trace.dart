import 'package:flutter/material.dart';

/// Draws a diagonal cross out kind of thing. It goes from top left to bottom right with a default color of [Colors.red]
/// There is no way to reverse the order.
class DiagonalTracePainter extends CustomPainter {
  /// Color to use to draw
  final Color color;

  const DiagonalTracePainter([this.color = Colors.red]);

  @override
  void paint(Canvas canvas, Size size) {
    // draws using the two points of the top left corner and the last 2 parameters being the x and y of the bottom right corner
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
