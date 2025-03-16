import 'package:dog_gromming_website/env/constants.dart';
import 'package:dog_gromming_website/ui/styles/app_colors.dart';
import 'package:dog_gromming_website/ui/styles/icons_name.dart';
import 'package:dog_gromming_website/ui/utils/url_launcher_util.dart';
import 'package:dog_gromming_website/ui/widgets/components/assets/svg_icon.dart';
import 'package:dog_gromming_website/ui/widgets/components/box_spacer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SocialNetworks extends StatelessWidget {
  final bool isCenter;

  const SocialNetworks({super.key, this.isCenter = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isCenter ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        IconButton(
          tooltip: 'footer.social_networks_tooltip'.tr(
            args: ['footer.facebook'.tr()],
          ),
          onPressed: () {
            UrlLauncherUtil.openLink(Uri.parse(Constants.facebookProfile));
          },
          icon: const SvgIcon(iconName: IconsName.facebook),
          color: AppColors.secondary,
        ),
        BoxSpacer.h4(),
        IconButton(
          tooltip: 'footer.social_networks_tooltip'.tr(
            args: ['footer.instagram'.tr()],
          ),
          onPressed: () {
            UrlLauncherUtil.openLink(Uri.parse(Constants.instagramProfile));
          },
          icon: const SvgIcon(iconName: IconsName.instagram),
          color: AppColors.secondary,
        ),
        BoxSpacer.h4(),
        IconButton(
          tooltip: 'footer.social_networks_tooltip'.tr(
            args: ['footer.whatsapp'.tr()],
          ),
          onPressed: () {
            UrlLauncherUtil.openWhatsapp(Constants.phone);
          },
          icon: const SvgIcon(iconName: IconsName.whatsapp),
          color: AppColors.secondary,
        ),
        BoxSpacer.h4(),
        IconButton(
          tooltip: 'footer.social_networks_tooltip'.tr(
            args: ['footer.tik_tok'.tr()],
          ),
          onPressed: () {
            UrlLauncherUtil.openLink(Uri.parse(Constants.tikTokProfile));
          },
          icon: const SvgIcon(
            iconName: IconsName.tiktok,
            color: AppColors.secondary,
          ),
          color: AppColors.secondary,
        ),
      ],
    );
  }
}
