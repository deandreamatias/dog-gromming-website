import 'package:dog_gromming_website/ui/styles/app_colors.dart';
import 'package:dog_gromming_website/ui/widgets/components/box_spacer.dart';
import 'package:dog_gromming_website/ui/widgets/components/circle_logo.dart';
import 'package:flutter/widgets.dart';

class BigWelcomeBoard extends StatelessWidget {
  final Widget child;
  final double maxWidth;
  final double maxHeight;

  const BigWelcomeBoard({
    super.key,
    required this.child,
    required this.maxWidth,
    required this.maxHeight,
  });

  @override
  Widget build(BuildContext context) {
    final double rectWidth = maxWidth * 0.8;
    final double rectHeight = maxHeight * 0.7;
    double circleRadius = maxWidth * 0.2;

    // Verify if the circle radius is off the screen
    // (behaind the top nav bar)
    if (maxHeight < rectHeight + circleRadius * 1.34) {
      circleRadius = maxHeight * 0.2;
    }

    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: (maxWidth - rectWidth) / 2,
          child: Container(
            width: rectWidth,
            height: rectHeight,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
            ),
            child: Column(
              children: [
                BoxSpacer(verticalSpacing: circleRadius * 0.66),
                Expanded(child: Center(child: child)),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: rectHeight - circleRadius * 0.66,
          left: (maxWidth - circleRadius * 2) / 2,
          child: CircleLogo(circleRadius: circleRadius),
        ),
      ],
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

    return Stack(
      children: [
        Positioned(
          top: circleRadius * 1.33,
          left: 0,
          child: Container(
            width: maxWidth,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Column(
              children: [
                BoxSpacer(verticalSpacing: circleRadius * 0.66),
                child,
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
    );
  }
}
