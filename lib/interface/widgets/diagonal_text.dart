import 'package:flutter/material.dart';
import 'package:gtfo_rundown_roulette/utils/computed_consts.dart';

class DiagonalText extends StatelessWidget {
  final String text;
  final Widget child;
  final double angle;
  final TextStyle? style;

  final AlignmentGeometry alignment;

  const DiagonalText({
    super.key,
    required this.text,
    required this.child,
    this.angle = PI_DIV_4,
    this.style,
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        child,
        Transform.rotate(
          angle: angle,
          child: Text(
            text,
            style:
                style ??
                const TextStyle(color: Colors.red, fontSize: 16.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
