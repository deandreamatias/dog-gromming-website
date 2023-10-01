import 'package:dog_gromming_website/env/constants.dart';
import 'package:dog_gromming_website/ui/widgets/components/box_spacer.dart';
import 'package:dog_gromming_website/ui/widgets/components/buttons/social_networks.dart';
import 'package:dog_gromming_website/ui/widgets/components/cards/outlined_card.dart';
import 'package:dog_gromming_website/ui/widgets/components/texts/body_m_text.dart';
import 'package:dog_gromming_website/ui/widgets/components/texts/title_l_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class WhenCard extends StatelessWidget {
  const WhenCard({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedCard(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SelectionArea(
                child: Column(
                  children: [
                    TitleLText('home.when.title'.tr()),
                    const BoxSpacer(
                      horizontalSpacing: double.infinity,
                      verticalSpacing: 8,
                    ),
                    BodyMText('home.when.schedule'.tr()),
                  ],
                ),
              ),
            ),
            BoxSpacer.v8(),
            Expanded(
              flex: 2,
              child: SelectionArea(
                child: Column(
                  children: [
                    TitleLText('home.contact.title'.tr()),
                    BoxSpacer.v8(),
                    BodyMText('home.contact.phone'.tr(args: [Constants.phone])),
                    BoxSpacer.v12(),
                    BodyMText('home.contact.email'.tr(args: [Constants.email])),
                    BoxSpacer.v12(),
                    Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        BodyMText('home.contact.social_networks'.tr()),
                        const SocialNetworks(isCenter: true),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
