import 'package:dog_gromming_website/ui/styles/app_colors.dart';
import 'package:dog_gromming_website/ui/widgets/components/box_spacer.dart';
import 'package:dog_gromming_website/ui/widgets/components/circle_logo.dart';
import 'package:flutter/widgets.dart';

class BigWelcomeBoard extends StatelessWidget {
  final Widget child;
  final double maxWidth;

  const BigWelcomeBoard({
    super.key,
    required this.child,
    required this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    const double circleRadius = 200;
    const double rectHeight = 370;
    final double rectWidth = maxWidth * 0.8;

    return SizedBox(
      height: rectHeight + circleRadius * 1.34,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: (maxWidth - rectWidth) / 2,
            child: Container(
              width: rectWidth,
              height: rectHeight,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Column(
                children: [
                  const BoxSpacer(verticalSpacing: circleRadius * 0.66),
                  Expanded(child: child),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: rectHeight - circleRadius * 0.66,
            left: (maxWidth - circleRadius * 2) / 2,
            child: const CircleLogo(circleRadius: circleRadius),
          ),
        ],
      ),
    );
  }
}

class SmallWelcomeBoard extends StatelessWidget {
  final Widget child;
  final double maxWidth;

  const SmallWelcomeBoard({
    super.key,
    required this.child,
    required this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    final double circleRadius = maxWidth * 0.2;
    const double fixedChildHeight = 200;

    return SizedBox(
      height: circleRadius * 2 + fixedChildHeight,
      child: Stack(
        children: [
          Positioned(
            top: circleRadius * 1.33,
            left: 0,
            child: Container(
              width: maxWidth,
              height: circleRadius * 0.66 + fixedChildHeight,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Column(
                children: [
                  BoxSpacer(verticalSpacing: circleRadius * 0.66),
                  Expanded(child: child),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: (maxWidth - circleRadius * 2) / 2,
            child: CircleLogo(circleRadius: circleRadius),
          ),
        ],
      ),
    );
  }
}
