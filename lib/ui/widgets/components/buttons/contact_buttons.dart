import 'package:dog_gromming_website/env/constants.dart';
import 'package:dog_gromming_website/ui/styles/icons_name.dart';
import 'package:dog_gromming_website/ui/utils/url_launcher_util.dart';
import 'package:dog_gromming_website/ui/widgets/components/box_spacer.dart';
import 'package:dog_gromming_website/ui/widgets/components/buttons/icon_primary_button.dart';
import 'package:dog_gromming_website/ui/widgets/components/buttons/primary_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ContactButtons extends StatelessWidget {
  final bool isBigButtons;
  const ContactButtons({super.key, this.isBigButtons = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SelectionArea(
          child: PrimaryButton(
            isBigButton: isBigButtons,
            onPressed: () {
              UrlLauncherUtil.openWhatsapp(Constants.phone);
            },
            label: 'home.whatsapp'.tr(),
            iconName: IconsName.whatsapp,
          ),
        ),
        BoxSpacer.h8(),
        IconPrimaryButton(
          isBigButton: isBigButtons,
          tooltip: 'home.contact_number_tooltip'.tr(args: [Constants.phone]),
          onPressed: () {
            UrlLauncherUtil.openTelephone(Constants.phone);
          },
          iconName: IconsName.phone,
        ),
      ],
    );
  }
}
