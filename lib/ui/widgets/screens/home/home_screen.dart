import 'package:dog_gromming_website/ui/styles/app_colors.dart';
import 'package:dog_gromming_website/ui/styles/insets.dart';
import 'package:dog_gromming_website/ui/styles/sizes.dart';
import 'package:dog_gromming_website/ui/widgets/components/assets/svg_image.dart';
import 'package:dog_gromming_website/ui/widgets/components/box_spacer.dart';
import 'package:dog_gromming_website/ui/widgets/components/buttons/icon_primary_button.dart';
import 'package:dog_gromming_website/ui/widgets/components/buttons/primary_button.dart';
import 'package:dog_gromming_website/ui/widgets/components/texts/body_l_text.dart';
import 'package:dog_gromming_website/ui/widgets/components/texts/body_m_text.dart';
import 'package:dog_gromming_website/ui/widgets/components/texts/headline_m_text.dart';
import 'package:dog_gromming_website/ui/widgets/components/texts/headline_s_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _WelcomeBoard(
      child: Padding(
        padding: Insets.a16,
        child: _WelcomeBody(),
      ),
    );
  }
}

class _WelcomeBody extends StatelessWidget {
  const _WelcomeBody();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMedium = constraints.maxWidth < Sizes.medium.width;

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: isMedium
                  ? HeadlineSText('home.slogan'.tr())
                  : HeadlineMText('home.slogan'.tr()),
            ),
            BoxSpacer.vSmall(isMedium: isMedium),
            Expanded(
              flex: isMedium ? 1 : 3,
              child: Column(
                children: [
                  isMedium
                      ? BodyMText('home.appointment'.tr())
                      : BodyLText('home.appointment'.tr()),
                  BoxSpacer.vSmall(isMedium: isMedium),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PrimaryButton(
                        isBigButton: !isMedium,
                        onPressed: () {},
                        label: 'home.contact_number'.tr(),
                      ),
                      BoxSpacer.hSmall(isMedium: isMedium),
                      IconPrimaryButton(
                        tooltip: 'home.whatsapp_tooltip'
                            .tr(args: ['home.contact_number'.tr()]),
                        isBigButton: !isMedium,
                        onPressed: () {},
                        icon: UniconsLine.whatsapp_alt,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (!isMedium) BoxSpacer.v16(),
          ],
        );
      },
    );
  }
}

class _WelcomeBoard extends StatelessWidget {
  final Widget child;

  const _WelcomeBoard({required this.child});

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
              child: Semantics(
                image: true,
                label: 'home.semantic_logo'.tr(),
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
            ),
          ],
        );
      },
    );
  }
}
