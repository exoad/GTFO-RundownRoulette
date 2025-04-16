import 'package:flutter/material.dart';
import 'package:gtfo_rundown_roulette/public.dart';

/// Draws a diagonal cross out kind of thing. It goes from top left to bottom right with a default color of [Colors.red]
/// There is no way to reverse the order.
class DiagonalTracePainter extends CustomPainter {
  /// Color to use to draw
  final Color color;

  const DiagonalTracePainter([this.color = PublicTheme.dangerRed]);

  @override
  void paint(Canvas canvas, Size size) {
    // draws using the two points of the top left corner and the last 2 parameters being the x and y of the bottom right corner
    canvas.drawLine(
      const Offset(2, 2),
      Offset(size.width - 2, size.height - 2),
      Paint()
        ..color = color
        ..strokeWidth = 4
        ..isAntiAlias = true
        ..strokeCap = StrokeCap.square,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
