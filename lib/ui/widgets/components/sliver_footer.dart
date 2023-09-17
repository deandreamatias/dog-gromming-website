import 'dart:math' as math;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class SliverFooter extends SingleChildRenderObjectWidget {
  /// Creates a sliver that fills the remaining space in the viewport.
  const SliverFooter({super.key, super.child});

  @override
  RenderSliverFooter createRenderObject(BuildContext context) =>
      RenderSliverFooter();
}

class RenderSliverFooter extends RenderSliverSingleBoxAdapter {
  @override
  void performLayout() {
    final extent =
        constraints.remainingPaintExtent - math.min(constraints.overlap, 0.0);
    double childGrowthSize = .0; // added
    if (child != null) {
      // changed maxExtent from 'extent' to double.infinity
      child!.layout(
        constraints.asBoxConstraints(minExtent: extent),
        parentUsesSize: true,
      );
      childGrowthSize = constraints.axis == Axis.vertical
          ? child!.size.height
          : child!.size.width; // added
    }
    final paintedChildSize =
        calculatePaintOffset(constraints, from: 0.0, to: extent);
    assert(
        paintedChildSize.isFinite,
        'The calculated paintedChildSize '
        '$paintedChildSize for child $child is not finite.');
    assert(
        paintedChildSize >= 0.0,
        'The calculated paintedChildSize was '
        '$paintedChildSize but is not greater than or equal to zero. '
        'This can happen if the child is too big in which case it '
        'should be sized down or if the SliverConstraints.scrollOffset '
        'was not correct.');
    geometry = SliverGeometry(
      // used to be this : scrollExtent: constraints.viewportMainAxisExtent,
      scrollExtent: math.max(extent, childGrowthSize),
      paintExtent: paintedChildSize,
      maxPaintExtent: paintedChildSize,
      hasVisualOverflow: extent > constraints.remainingPaintExtent ||
          constraints.scrollOffset > 0.0,
    );
    if (child != null) {
      setChildParentData(child!, constraints, geometry!);
    }
  }
}
