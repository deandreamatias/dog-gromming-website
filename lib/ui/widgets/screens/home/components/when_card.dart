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
          children: [
            Expanded(
              child: SelectionArea(
                child: Column(
                  spacing: 8,
                  children: [
                    TitleLText('home.when.title'.tr()),
                    BodyMText(
                      'home.when.schedule_1'.tr(),
                      textAlign: TextAlign.center,
                    ),
                    BodyMText(
                      'home.when.schedule_2'.tr(),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            BoxSpacer.v8(),
            Expanded(
              flex: 2,
              child: SelectionArea(
                child: Column(
                  spacing: 8,
                  children: [
                    TitleLText('home.contact.title'.tr()),
                    BodyMText('home.contact.phone'.tr(args: [Constants.phone])),
                    BodyMText('home.contact.email'.tr(args: [Constants.email])),
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
