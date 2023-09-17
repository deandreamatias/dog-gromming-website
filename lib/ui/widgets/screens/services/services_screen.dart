import 'package:dog_gromming_website/ui/styles/app_colors.dart';
import 'package:dog_gromming_website/ui/styles/insets.dart';
import 'package:dog_gromming_website/ui/styles/sizes.dart';
import 'package:dog_gromming_website/ui/styles/spacing.dart';
import 'package:dog_gromming_website/ui/widgets/components/box_spacer.dart';
import 'package:dog_gromming_website/ui/widgets/components/cards/outlined_card.dart';
import 'package:dog_gromming_website/ui/widgets/components/texts/headline_s_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> cards = <Widget>[
      OutlinedCard(
        title: 'services.first.title'.tr(),
        description: 'services.first.description'.tr(),
      ),
      OutlinedCard(
        title: 'services.second.title'.tr(),
        description: 'services.second.description'.tr(),
      ),
      OutlinedCard(
        title: 'services.third.title'.tr(),
        description: 'services.third.description'.tr(),
      ),
      OutlinedCard(
        title: 'services.fourth.title'.tr(),
        description: 'services.fourth.description'.tr(),
      ),
    ];
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      slivers: <Widget>[
        SliverToBoxAdapter(child: BoxSpacer.v16()),
        SliverPadding(
          padding: Insets.h16,
          sliver: SliverLayoutBuilder(
            builder: (context, constraints) {
              // Hack to center the cards when the screen is large
              return Sizes.l.width > constraints.crossAxisExtent
                  ? SliverGrid.extent(
                      crossAxisSpacing: Spacing.sp16,
                      mainAxisSpacing: Spacing.sp16,
                      maxCrossAxisExtent: 380,
                      children: cards,
                    )
                  : SliverToBoxAdapter(
                      child: SizedBox(
                        height: 380,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: cards,
                        ),
                      ),
                    );
            },
          ),
        ),
        SliverToBoxAdapter(child: BoxSpacer.v16()),
        SliverPadding(
          padding: Insets.h16,
          sliver: SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const _LoveIcon(),
                BoxSpacer.h16(),
                Flexible(
                  child: HeadlineSText('services.footer'.tr()),
                ),
                BoxSpacer.h16(),
                const _LoveIcon(),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(child: BoxSpacer.v16()),
      ],
    );
  }
}

class _LoveIcon extends StatelessWidget {
  const _LoveIcon();

  @override
  Widget build(BuildContext context) {
    return const Icon(
      UniconsLine.heart,
      color: AppColors.primary,
      size: 48,
    );
  }
}
