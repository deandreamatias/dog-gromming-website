import 'package:dog_gromming_website/ui/navigation/menu_navigation.dart';
import 'package:dog_gromming_website/ui/navigation/routes.dart';
import 'package:dog_gromming_website/ui/styles/app_colors.dart';
import 'package:dog_gromming_website/ui/styles/insets.dart';
import 'package:dog_gromming_website/ui/styles/theme.dart';
import 'package:dog_gromming_website/ui/widgets/components/box_spacer.dart';
import 'package:dog_gromming_website/ui/widgets/components/buttons/social_networks.dart';
import 'package:dog_gromming_website/ui/widgets/components/logo.dart';
import 'package:dog_gromming_website/ui/widgets/components/texts/body_m_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderTypes.borderRadiusTop32,
      ),
      padding: Insets.h48 + Insets.v12,
      width: double.infinity,
      height: 140,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Logo.circle(
              radius: 55,
              semanticLabel: 'footer.logo_semantic'.tr(),
            ),
          ),
          BoxSpacer.h16(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () => context.go(MenuNavigation.services.route),
                child: BodyMText(MenuNavigation.services.label.tr()),
              ),
              // BoxSpacer.v4(),
              // TextButton(
              //   onPressed: () => context.go(MenuNavigation.gallery.route),
              //   child: BodyMText(MenuNavigation.gallery.label.tr()),
              // ),
              BoxSpacer.v4(),
              TextButton(
                onPressed: () => context.go(MenuNavigation.about.route),
                child: BodyMText(MenuNavigation.about.label.tr()),
              ),
            ],
          ),
          BoxSpacer.h16(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () => context.go(MenuNavigation.home.route),
                child: BodyMText(MenuNavigation.home.label.tr()),
              ),
              BoxSpacer.v4(),
              TextButton(
                onPressed: () => context.go(Routes.privacyPolicy),
                child: BodyMText('footer.privacy_policy'.tr()),
              ),
            ],
          ),
          BoxSpacer.h16(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SocialNetworks(),
              BoxSpacer.v8(),
              Padding(
                padding: Insets.a8,
                child: BodyMText(
                  'footer.trademark'.tr(args: [DateTime.now().year.toString()]),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

extension _FooterNavigationExtension on MenuNavigation {
  String get label {
    switch (this) {
      case MenuNavigation.home:
        return 'footer.home';
      case MenuNavigation.services:
        return 'footer.services';
      // case MenuNavigation.gallery:
      //   return 'footer.gallery';
      case MenuNavigation.about:
        return 'footer.about';
    }
  }
}
