import 'package:dog_gromming_website/ui/styles/insets.dart';
import 'package:dog_gromming_website/ui/styles/sizes.dart';
import 'package:dog_gromming_website/ui/styles/spacing.dart';
import 'package:dog_gromming_website/ui/widgets/components/box_spacer.dart';
import 'package:dog_gromming_website/ui/widgets/components/cards/outlined_card.dart';
import 'package:dog_gromming_website/ui/widgets/components/footer.dart';
import 'package:dog_gromming_website/ui/widgets/components/logo.dart';
import 'package:dog_gromming_website/ui/widgets/components/sliver_footer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cards = <Widget>[
      OutlinedCard.logo(
        description: 'about.company.description'.tr(),
        title: Logo.text(
          semanticLabel: 'about.company.semantic_label'.tr(),
          height: 24,
        ),
      ),
      OutlinedCard.text(
        title: 'about.owner.title'.tr(),
        description: 'about.owner.description'.tr(),
      ),
    ];

    return CustomScrollView(
      shrinkWrap: true,
      scrollBehavior: const ScrollBehavior().copyWith(overscroll: false),
      slivers: <Widget>[
        SliverToBoxAdapter(child: BoxSpacer.v16()),
        SliverPadding(
          padding: Insets.h16,
          sliver: SliverLayoutBuilder(
            builder: (context, constraints) {
              // Hack to center the cards when the screen is large
              return Sizes.s.width > constraints.crossAxisExtent
                  ? SliverGrid.extent(
                      crossAxisSpacing: Spacing.sp16,
                      mainAxisSpacing: Spacing.sp16,
                      maxCrossAxisExtent: 550,
                      children: cards,
                    )
                  : SliverToBoxAdapter(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxWidth: 550,
                                maxHeight: 300,
                              ),
                              child: cards.first,
                            ),
                          ),
                          BoxSpacer.h24(),
                          Flexible(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxWidth: 550,
                                maxHeight: 300,
                              ),
                              child: cards.last,
                            ),
                          ),
                        ],
                      ),
                    );
            },
          ),
        ),
        SliverToBoxAdapter(child: BoxSpacer.v32()),
        SliverLayoutBuilder(
          builder: (context, constraints) => Sizes.s.width <
                  constraints.crossAxisExtent
              ? const SliverFooter(
                  child:
                      Align(alignment: Alignment.bottomCenter, child: Footer()),
                )
              : const SliverToBoxAdapter(child: SizedBox()),
        ),
      ],
    );
  }
}
