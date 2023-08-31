import 'package:dog_gromming_website/ui/styles/app_colors.dart';
import 'package:dog_gromming_website/ui/styles/insets.dart';
import 'package:dog_gromming_website/ui/widgets/components/assets/svg_image.dart';
import 'package:dog_gromming_website/ui/widgets/components/box_spacer.dart';
import 'package:dog_gromming_website/ui/widgets/components/buttons/primary_button.dart';
import 'package:dog_gromming_website/ui/widgets/components/texts/body_l_text.dart';
import 'package:dog_gromming_website/ui/widgets/components/texts/body_m_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _ResponsiveWelcome(
      child: Padding(
        padding: Insets.a16,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: BodyLText('home.slogan'.tr())),
            BoxSpacer.v16(),
            Expanded(
              child: Column(
                children: [
                  BodyMText('home.appointment'.tr()),
                  BoxSpacer.v16(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PrimaryButton(
                        onPressed: () {},
                        label: 'home.contact_number'.tr(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            BoxSpacer.v16(),
          ],
        ),
      ),
    );
  }
}

class _ResponsiveWelcome extends StatelessWidget {
  final Widget child;

  const _ResponsiveWelcome({required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double screenWidth = constraints.maxWidth;
        final double screenHeight = constraints.maxHeight;

        final double rectWidth = screenWidth * 0.8;
        final double rectHeight = screenHeight * 0.7;
        double circleRadius = screenWidth * 0.2;

        // Verify if the circle radius is off the screen
        // (behaind the top nav bar)
        if (constraints.maxHeight < rectHeight + circleRadius * 1.34) {
          circleRadius = screenHeight * 0.2;
        }

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
