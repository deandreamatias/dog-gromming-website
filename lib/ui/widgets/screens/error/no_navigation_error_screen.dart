import 'package:dog_gromming_website/ui/navigation/routes.dart';
import 'package:dog_gromming_website/ui/styles/insets.dart';
import 'package:dog_gromming_website/ui/widgets/components/box_spacer.dart';
import 'package:dog_gromming_website/ui/widgets/components/buttons/primary_button.dart';
import 'package:dog_gromming_website/ui/widgets/components/texts/body_l_text.dart';
import 'package:dog_gromming_website/ui/widgets/components/texts/display_s_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NoNavigationErrorScreen extends StatelessWidget {
  final String path;
  const NoNavigationErrorScreen({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: Insets.a16,
        child: Center(
          child: Column(
            children: [
              DisplaySText('errors.no_navigation'.tr()),
              BoxSpacer.v16(),
              BodyLText(
                GoRouter.of(
                  context,
                ).routeInformationProvider.value.uri.toString(),
              ),
              BoxSpacer.v16(),
              PrimaryButton(
                onPressed: () => GoRouter.of(context).go(Routes.home),
                label: 'menu.home'.tr(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
