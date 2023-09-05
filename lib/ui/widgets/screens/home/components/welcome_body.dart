import 'package:dog_gromming_website/env/constants.dart';
import 'package:dog_gromming_website/ui/styles/app_colors.dart';
import 'package:dog_gromming_website/ui/styles/insets.dart';
import 'package:dog_gromming_website/ui/utils/url_launcher_util.dart';
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

class BigWelcomeBody extends StatelessWidget {
  const BigWelcomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Insets.a16,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: HeadlineMText('home.slogan'.tr()),
          ),
          BoxSpacer.v16(),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                BodyLText('home.appointment'.tr()),
                BoxSpacer.v16(),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SelectionArea(
                      child: PrimaryButton(
                        isBigButton: true,
                        onPressed: () {
                          UrlLauncherUtil.openTelephone(Constants.phone);
                        },
                        label: 'home.contact_number'.tr(),
                      ),
                    ),
                    BoxSpacer.h16(),
                    IconPrimaryButton(
                      tooltip:
                          'home.whatsapp_tooltip'.tr(args: [Constants.phone]),
                      isBigButton: true,
                      onPressed: () {
                        UrlLauncherUtil.openWhatsapp(Constants.phone);
                      },
                      icon: UniconsLine.whatsapp_alt,
                    ),
                  ],
                ),
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
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        padding: Insets.a16,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HeadlineSText('home.slogan'.tr()),
            BoxSpacer.v8(),
            Column(
              children: [
                BodyMText('home.appointment'.tr()),
                BoxSpacer.v8(),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SelectionArea(
                      child: PrimaryButton(
                        onPressed: () {
                          UrlLauncherUtil.openTelephone(Constants.phone);
                        },
                        label: 'home.contact_number'.tr(),
                      ),
                    ),
                    BoxSpacer.h8(),
                    IconPrimaryButton(
                      tooltip:
                          'home.whatsapp_tooltip'.tr(args: [Constants.phone]),
                      onPressed: () {
                        UrlLauncherUtil.openWhatsapp(Constants.phone);
                      },
                      icon: UniconsLine.whatsapp_alt,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
