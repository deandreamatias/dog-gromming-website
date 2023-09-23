import 'package:dog_gromming_website/env/constants.dart';
import 'package:dog_gromming_website/ui/widgets/components/box_spacer.dart';
import 'package:dog_gromming_website/ui/widgets/components/cards/outlined_card.dart';
import 'package:dog_gromming_website/ui/widgets/components/iframe.dart';
import 'package:dog_gromming_website/ui/widgets/components/texts/title_l_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';

class WhereCard extends StatelessWidget {
  const WhereCard({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TitleLText('home.where.title'.tr()),
          BoxSpacer.v8(),
          Expanded(
            child: Semantics(
              container: true,
              label: 'home.where.semantic_description'.tr(),
              child: const Iframe(url: Constants.maps),
            ),
          ),
        ],
      ),
    );
  }
}
