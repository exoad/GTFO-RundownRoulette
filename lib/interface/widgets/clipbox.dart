import 'package:flutter/material.dart';

class ClipBox extends StatelessWidget {
  final Color background;
  final EdgeInsetsGeometry childPadding;
  final BorderRadiusGeometry borderRadius;
  final Widget child;

  const ClipBox({
    super.key,
    required this.background,
    this.borderRadius = BorderRadius.zero,
    this.childPadding = EdgeInsets.zero,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: background, borderRadius: borderRadius),
      padding: childPadding,
      child: child,
    );
  }
}
