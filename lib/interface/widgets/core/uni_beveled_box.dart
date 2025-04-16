import 'package:flutter/material.dart';
import 'package:gtfo_rundown_roulette/public.dart';

/// creates a right trapezoid or a rectangle with the top right corner being bevelled off
class UniBeveledBox extends StatelessWidget {
  final Widget child;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final EdgeInsetsGeometry padding;
  final double amount;

  const UniBeveledBox({
    super.key,
    this.foregroundColor = PublicTheme.abyssBlack,
    this.backgroundColor = PublicTheme.normalWhite,
    this.padding = const EdgeInsets.only(top: 2, bottom: 2, right: 26, left: 2),
    this.amount = 8,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: ShapeDecoration(
        color: backgroundColor,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(amount),
            bottomLeft: Radius.zero,
          ),
        ),
      ),
      child: Padding(
        padding: padding,
        child: IconTheme(
          data: IconThemeData(color: foregroundColor ?? PublicTheme.normalWhite),
          child: DefaultTextStyle(
            style: TextStyle(
              fontFamily: "Shared Tech",
              color: foregroundColor ?? PublicTheme.normalWhite,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[child]),
          ),
        ),
      ),
    );
  }
}

/// similar to [UniBeveledBox] but its just the clipper by itself
///
/// just bevels off the top right corner to produce a sort of right trapezoid
class UniBeveledBoxClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width - 100, 0);
    path.lineTo(size.width, 100);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
