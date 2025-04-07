import 'package:flutter/material.dart';

/// Draws a drooped divider. Based on the divider used in the GTFO game directly.
///
/// It looks like the square brackets '[' but it is rotated 90 degrees clockwise.
///
/// Much of the logic and layout is copied from [Divider] itself.
class DroopedDivider extends StatelessWidget {
  /// The amount to droop by
  final int amount;

  /// The color to use for this
  final Color color;

  /// Thickness of the stroke to use.
  final double thickness;

  const DroopedDivider({
    super.key,
    required this.amount,
    required this.color,
    required this.thickness,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: DividerTheme.of(context).space,
      child: Center(
        child: CustomPaint(
          painter: _DroopedDividerPainter(amount: amount, color: color, thickness: thickness),
        ),
      ),
    );
  }
}

class _DroopedDividerPainter extends CustomPainter {
  final int amount;
  final Color color;
  final double thickness;

  _DroopedDividerPainter({required this.amount, required this.color, required this.thickness});

  @override
  void paint(final Canvas canvas, final Size size) {
    final double height = size.height + 2;
    canvas.drawPath(
      Path()
        ..lineTo(0, height) // first (left) droop
        ..moveTo(0, 0)
        ..lineTo(size.width, 0) // actual divider line
        ..lineTo(size.width, height), // last (right) droop
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = thickness,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
