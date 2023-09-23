import 'package:dog_gromming_website/env/constants.dart';
import 'package:dog_gromming_website/ui/widgets/components/box_spacer.dart';
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
      child: SelectionArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleLText('home.when.title'.tr()),
                    BoxSpacer.v8(),
                    Expanded(child: BodyMText('home.when.description'.tr())),
                  ],
                ),
              ),
              BoxSpacer.v8(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleLText('home.contact.title'.tr()),
                    BoxSpacer.v8(),
                    BodyMText('home.contact.phone'.tr(args: [Constants.phone])),
                    BoxSpacer.v8(),
                    BodyMText('home.contact.email'.tr(args: [Constants.email])),
                    BoxSpacer.v8(),
                    BodyMText('home.social_networks.title'.tr()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
