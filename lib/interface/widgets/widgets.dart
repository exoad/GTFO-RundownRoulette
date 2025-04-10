// ignore_for_file: prefer_asserts_with_message

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gtfo_rundown_roulette/interface/widgets/diagonal_trace.dart';

/// a widget that applies a grayscale filter, a [DiagonalTracePainter], and an [AbsorbPainter] onto its child
/// if its set to be disabled.
///
/// a good visual indicator for users
class DisableableWidget extends StatelessWidget {
  final bool disabled;
  final Widget child;

  const DisableableWidget({super.key, required this.disabled, required this.child});

  @override
  Widget build(BuildContext context) {
    return disabled
        ? CustomPaint(
          foregroundPainter: const DiagonalTracePainter(),
          child: ColorFiltered(
            colorFilter: const ColorFilter.matrix(<double>[
              // values from wikipedia
              0.2126, 0.7152, 0.0722, 0, 0, //
              0.2126, 0.7152, 0.0722, 0, 0, //
              0.2126, 0.7152, 0.0722, 0, 0, //
              0, 0, 0, 1, 0, //
            ]),
            child: AbsorbPointer(child: child),
          ),
        )
        : child;
  }
}

/// a custom [SliverGridDelegate] for more fine grain control of its properties
class SliverGridDelegateAll extends SliverGridDelegate {
  const SliverGridDelegateAll({
    required this.crossAxisCount,
    this.mainAxisSpacing = 0.0,
    this.crossAxisSpacing = 0.0,
    this.childAspectRatio = 1.0,
    this.crossAxisExtent,
    this.mainAxisExtent,
  }) : assert(crossAxisCount > 0),
       assert(mainAxisSpacing >= 0),
       assert(crossAxisSpacing >= 0),
       assert(childAspectRatio > 0),
       assert(mainAxisExtent == null || mainAxisExtent >= 0);

  final int crossAxisCount;

  final double? crossAxisExtent;

  final double mainAxisSpacing;

  final double crossAxisSpacing;

  final double childAspectRatio;

  final double? mainAxisExtent;

  bool _debugAssertIsValid() {
    assert(crossAxisCount > 0);
    assert(mainAxisSpacing >= 0.0);
    assert(crossAxisSpacing >= 0.0);
    assert(childAspectRatio > 0.0);
    return true;
  }

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    assert(_debugAssertIsValid());
    final double usableCrossAxisExtent = math.max(
      0.0,
      constraints.crossAxisExtent - crossAxisSpacing * (crossAxisCount - 1),
    );
    final double childCrossAxisExtent = crossAxisExtent ?? usableCrossAxisExtent / crossAxisCount;
    final double childMainAxisExtent = mainAxisExtent ?? childCrossAxisExtent / childAspectRatio;
    return SliverGridRegularTileLayout(
      crossAxisCount: crossAxisCount,
      mainAxisStride: childMainAxisExtent + mainAxisSpacing,
      crossAxisStride: childCrossAxisExtent + crossAxisSpacing,
      childMainAxisExtent: childMainAxisExtent,
      childCrossAxisExtent: childCrossAxisExtent,
      reverseCrossAxis: axisDirectionIsReversed(constraints.crossAxisDirection),
    );
  }

  @override
  bool shouldRelayout(SliverGridDelegateWithFixedCrossAxisCount oldDelegate) {
    return oldDelegate.crossAxisCount != crossAxisCount ||
        oldDelegate.mainAxisSpacing != mainAxisSpacing ||
        oldDelegate.crossAxisSpacing != crossAxisSpacing ||
        oldDelegate.childAspectRatio != childAspectRatio ||
        oldDelegate.mainAxisExtent != mainAxisExtent;
  }
}
