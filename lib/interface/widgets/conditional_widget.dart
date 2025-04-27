import 'package:flutter/material.dart';

class ConditionalWidget extends StatelessWidget {
  final Widget normal;
  final Widget? Function(BuildContext, Widget) second;

  const ConditionalWidget({super.key, required this.normal, required this.second});

  @override
  Widget build(BuildContext context) {
    return second(context, normal) ?? normal;
  }
}
