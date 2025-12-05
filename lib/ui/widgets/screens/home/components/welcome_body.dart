import 'package:dog_gromming_website/ui/styles/app_colors.dart';
import 'package:dog_gromming_website/ui/styles/insets.dart';
import 'package:dog_gromming_website/ui/styles/theme.dart';
import 'package:dog_gromming_website/ui/widgets/components/box_spacer.dart';
import 'package:dog_gromming_website/ui/widgets/components/buttons/contact_buttons.dart';
import 'package:dog_gromming_website/ui/widgets/components/texts/body_l_text.dart';
import 'package:dog_gromming_website/ui/widgets/components/texts/body_m_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';

class BigWelcomeBody extends StatelessWidget {
  const BigWelcomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Insets.a16,
      child: Column(
        children: [
          BodyLText('home.appointment'.tr()),
          BoxSpacer.v16(),
          const ContactButtons(isBigButtons: true),
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
          children: [
            BodyMText('home.appointment'.tr(), textAlign: .center),
            BoxSpacer.v8(),
            const ContactButtons(),
          ],
        ),
      ),
    );
  }
}
