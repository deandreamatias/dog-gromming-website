import 'package:dog_gromming_website/ui/styles/app_colors.dart';
import 'package:dog_gromming_website/ui/styles/icons_name.dart';
import 'package:dog_gromming_website/ui/styles/insets.dart';
import 'package:dog_gromming_website/ui/styles/sizes.dart';
import 'package:dog_gromming_website/ui/styles/spacing.dart';
import 'package:dog_gromming_website/ui/utils/seo_util.dart';
import 'package:dog_gromming_website/ui/widgets/components/assets/svg_icon.dart';
import 'package:dog_gromming_website/ui/widgets/components/box_spacer.dart';
import 'package:dog_gromming_website/ui/widgets/components/cards/outlined_card.dart';
import 'package:dog_gromming_website/ui/widgets/components/footer.dart';
import 'package:dog_gromming_website/ui/widgets/components/sliver_footer.dart';
import 'package:dog_gromming_website/ui/widgets/components/texts/headline_s_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SeoUtil.updateServicesPageSeo(context);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> cards = <Widget>[
      OutlinedCard.text(
        title: 'services.first.title'.tr(),
        description: 'services.first.description'.tr(),
      ),
      OutlinedCard.text(
        title: 'services.second.title'.tr(),
        description: 'services.second.description'.tr(),
      ),
      OutlinedCard.text(
        title: 'services.third.title'.tr(),
        description: 'services.third.description'.tr(),
      ),
      OutlinedCard.text(
        title: 'services.fourth.title'.tr(),
        description: 'services.fourth.description'.tr(),
      ),
      OutlinedCard.text(
        title: 'services.fifth.title'.tr(),
        description: 'services.fifth.description'.tr(),
      ),
      OutlinedCard.text(
        title: 'services.sixth.title'.tr(),
        description: 'services.sixth.description'.tr(),
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
              return SliverGrid.extent(
                crossAxisSpacing: Spacing.sp16,
                mainAxisSpacing: Spacing.sp16,
                maxCrossAxisExtent: 450,
                children: cards,
              );
            },
          ),
        ),
        SliverToBoxAdapter(child: BoxSpacer.v24()),
        SliverPadding(
          padding: Insets.h16,
          sliver: SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const _LoveIcon(),
                BoxSpacer.h16(),
                Flexible(child: HeadlineSText('services.footer'.tr())),
                BoxSpacer.h16(),
                const _LoveIcon(),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(child: BoxSpacer.v32()),
        SliverLayoutBuilder(
          builder: (context, constraints) =>
              Sizes.s.width < constraints.crossAxisExtent
              ? const SliverFooter(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Footer(),
                  ),
                )
              : const SliverToBoxAdapter(child: SizedBox()),
        ),
      ],
    );
  }
}

class _LoveIcon extends StatelessWidget {
  const _LoveIcon();

  @override
  Widget build(BuildContext context) {
    return const SvgIcon(
      iconName: IconsName.heart,
      color: AppColors.primary,
      width: 48,
      height: 48,
    );
  }
}
