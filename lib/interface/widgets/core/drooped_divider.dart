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
    // this is more of a hack to just force the divider to expand horizontally and is the
    // most intuitive on the spot thing i came up with
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: CustomPaint(
            painter: _DroopedDividerPainter(amount: amount, color: color, thickness: thickness),
          ),
        ),
      ],
    );
  }
}

class _DroopedDividerPainter extends CustomPainter {
  final double amount;
  final Color color;
  final double thickness;
  final double thicknessDiv2;

  _DroopedDividerPainter({required num amount, required this.color, required this.thickness})
    : amount = amount.toDouble(),
      // not really div2 but i am too lazy to rename it
      // used to calculate the value without having to potentially recalculate it on each repaint call
      thicknessDiv2 = thickness / 4;

  @override
  void paint(final Canvas canvas, final Size size) {
    canvas.drawPath(
      Path()
        ..moveTo(
          thicknessDiv2,
          0,
        ) // calculations in regards to using relative thickness of the stroke
        ..relativeLineTo(size.width, 0) // draw the actual horizontal divider line
        ..relativeLineTo(0, amount) // the far right droop line
        ..moveTo(thicknessDiv2, 0) // move back
        ..relativeLineTo(0, amount), // draw the far left droop line
      Paint()
        ..strokeJoin = StrokeJoin.bevel
        ..strokeCap = StrokeCap.square
        ..filterQuality = FilterQuality.none
        ..isAntiAlias = false
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = thickness,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
