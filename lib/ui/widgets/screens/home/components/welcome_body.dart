import 'package:dog_gromming_website/ui/styles/app_colors.dart';
import 'package:dog_gromming_website/ui/styles/insets.dart';
import 'package:dog_gromming_website/ui/styles/theme.dart';
import 'package:dog_gromming_website/ui/widgets/components/box_spacer.dart';
import 'package:dog_gromming_website/ui/widgets/components/buttons/contact_buttons.dart';
import 'package:dog_gromming_website/ui/widgets/components/texts/body_l_text.dart';
import 'package:dog_gromming_website/ui/widgets/components/texts/body_m_text.dart';
import 'package:dog_gromming_website/ui/widgets/components/texts/headline_m_text.dart';
import 'package:dog_gromming_website/ui/widgets/components/texts/headline_s_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BigWelcomeBody extends StatelessWidget {
  const BigWelcomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Insets.a16,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          HeadlineMText('home.slogan'.tr()),
          BoxSpacer.v16(),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                BodyLText('home.appointment'.tr()),
                BoxSpacer.v16(),
                const ContactButtons(isBigButtons: true),
              ],
            ),
          ),
          BoxSpacer.v16(),
        ],
      ),
    );
  }
}

class SmallWelcomeBody extends StatelessWidget {
  const SmallWelcomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderTypes.borderRadius8,
        ),
        padding: Insets.a16,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HeadlineSText('home.slogan'.tr()),
            BoxSpacer.v8(),
            Column(
              children: [
                BodyMText('home.appointment'.tr()),
                BoxSpacer.v8(),
                const ContactButtons(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
