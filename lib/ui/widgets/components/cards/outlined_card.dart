import 'package:dog_gromming_website/ui/styles/app_colors.dart';
import 'package:dog_gromming_website/ui/styles/insets.dart';
import 'package:dog_gromming_website/ui/styles/theme.dart';
import 'package:dog_gromming_website/ui/widgets/components/box_spacer.dart';
import 'package:dog_gromming_website/ui/widgets/components/texts/body_m_text.dart';
import 'package:dog_gromming_website/ui/widgets/components/texts/title_l_text.dart';
import 'package:flutter/material.dart';

class OutlinedCard extends StatelessWidget {
  final String title;
  final String description;

  const OutlinedCard({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primary, width: 4),
        borderRadius: BorderTypes.borderRadius8,
      ),
      child: Padding(
        padding: Insets.v24 + Insets.h16,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TitleLText(title),
            BoxSpacer.v8(),
            Expanded(child: BodyMText(description)),
          ],
        ),
      ),
    );
  }
}
