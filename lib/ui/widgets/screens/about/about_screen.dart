import 'package:dog_gromming_website/ui/styles/insets.dart';
import 'package:dog_gromming_website/ui/styles/sizes.dart';
import 'package:dog_gromming_website/ui/styles/spacing.dart';
import 'package:dog_gromming_website/ui/widgets/components/box_spacer.dart';
import 'package:dog_gromming_website/ui/widgets/components/cards/outlined_card.dart';
import 'package:dog_gromming_website/ui/widgets/components/logo.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cards = <Widget>[
      OutlinedCard(
        description: 'about.company.description'.tr(),
        titleWidget: Logo.text(
          semanticLabel: 'about.company.semantic_label'.tr(),
          height: 24,
        ),
      ),
      OutlinedCard(
        title: 'about.owner.title'.tr(),
        description: 'about.owner.description'.tr(),
      ),
    ];
    return Padding(
      padding: Insets.a16,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Sizes.s.width > constraints.maxWidth
              ? GridView.extent(
                  maxCrossAxisExtent: 550,
                  crossAxisSpacing: Spacing.sp16,
                  mainAxisSpacing: Spacing.sp16,
                  children: cards,
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: FractionallySizedBox(
                        heightFactor:
                            Sizes.xs.width < constraints.maxHeight ? 0.5 : 1,
                        child: cards.first,
                      ),
                    ),
                    BoxSpacer.h24(),
                    Flexible(
                      child: FractionallySizedBox(
                        heightFactor:
                            Sizes.xs.width < constraints.maxHeight ? 0.5 : 1,
                        child: cards.last,
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
