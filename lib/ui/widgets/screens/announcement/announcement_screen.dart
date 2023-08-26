import 'package:dog_gromming_website/ui/styles/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AnnouncementScreen extends StatelessWidget {
  const AnnouncementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColoredBox(
        color: AppColors.primary,
        child: Center(
          child: Text(
            'coming_soon'.tr(),
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
      ),
    );
  }
}
