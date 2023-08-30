import 'package:dog_gromming_website/ui/styles/app_colors.dart';
import 'package:dog_gromming_website/ui/widgets/components/assets/svg_image.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ResponsiveWelcome();
  }
}

class _ResponsiveWelcome extends StatelessWidget {
  const _ResponsiveWelcome();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double screenWidth = constraints.maxWidth;
        final double screenHeight = constraints.maxHeight;
        // TODO: Implement small landscape layout

        final double rectWidth = screenWidth * 0.8;
        final double rectHeight = screenHeight * 0.7;
        final double circleRadius = rectWidth * 0.25;

        return Stack(
          children: [
            Positioned(
              bottom: 0,
              left: (screenWidth - rectWidth) / 2,
              child: Container(
                width: rectWidth,
                height: rectHeight,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                ),
              ),
            ),
            Positioned(
              bottom: rectHeight - circleRadius * 0.66,
              left: (screenWidth - circleRadius * 2) / 2,
              child: SizedBox(
                width: circleRadius * 2,
                height: circleRadius * 2,
                child: const SvgImage(
                  imageName: 'logo',
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
