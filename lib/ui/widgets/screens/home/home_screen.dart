import 'package:dog_gromming_website/ui/styles/insets.dart';
import 'package:dog_gromming_website/ui/styles/sizes.dart';
import 'package:dog_gromming_website/ui/styles/spacing.dart';
import 'package:dog_gromming_website/ui/widgets/components/box_spacer.dart';
import 'package:dog_gromming_website/ui/widgets/components/footer.dart';
import 'package:dog_gromming_website/ui/widgets/components/sliver_footer.dart';
import 'package:dog_gromming_website/ui/widgets/screens/home/components/welcome_board.dart';
import 'package:dog_gromming_website/ui/widgets/screens/home/components/welcome_body.dart';
import 'package:dog_gromming_website/ui/widgets/screens/home/components/when_card.dart';
import 'package:dog_gromming_website/ui/widgets/screens/home/components/where_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      slivers: <Widget>[
        SliverToBoxAdapter(child: BoxSpacer.v16()),
        SliverPadding(
          padding: Insets.a16,
          sliver: SliverLayoutBuilder(
            builder: (context, constraints) {
              return constraints.crossAxisExtent > Sizes.m.width
                  ? SliverToBoxAdapter(
                    child: BigWelcomeBoard(
                      maxWidth: constraints.crossAxisExtent,
                      child: const BigWelcomeBody(),
                    ),
                  )
                  : SliverToBoxAdapter(
                    child: SmallWelcomeBoard(
                      maxWidth: constraints.crossAxisExtent,
                      child: const SmallWelcomeBody(),
                    ),
                  );
            },
          ),
        ),
        SliverToBoxAdapter(child: BoxSpacer.v8()),
        SliverPadding(
          padding: Insets.h16,
          sliver: SliverLayoutBuilder(
            builder:
                (context, constraints) => SliverToBoxAdapter(
                  child: _WhereWhenSection(
                    maxWidth: constraints.crossAxisExtent,
                  ),
                ),
          ),
        ),
        // TODO: Temporal disable until implement new send email
        // SliverToBoxAdapter(child: BoxSpacer.v8()),
        // const SliverPadding(
        //   padding: Insets.h16,
        //   sliver: SliverToBoxAdapter(child: ContactCard()),
        // ),
        SliverToBoxAdapter(child: BoxSpacer.v8()),
        SliverLayoutBuilder(
          builder:
              (context, constraints) =>
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

class _WhereWhenSection extends StatelessWidget {
  final double maxWidth;
  const _WhereWhenSection({required this.maxWidth});

  @override
  Widget build(BuildContext context) {
    return maxWidth < Sizes.m.width
        ? GridView.extent(
          shrinkWrap: true,
          crossAxisSpacing: Spacing.sp16,
          mainAxisSpacing: Spacing.sp16,
          maxCrossAxisExtent: 700,
          childAspectRatio: _getAspecRatio(maxWidth),
          children: const [WhereCard(), WhenCard()],
        )
        : Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 24,
          children: [
            Expanded(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 400),
                child: const WhereCard(),
              ),
            ),
            Expanded(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 400),
                child: const WhenCard(),
              ),
            ),
          ],
        );
  }

  double _getAspecRatio(double maxWidth) {
    if (maxWidth < 360) {
      return 0.75;
    } else if (maxWidth < 500) {
      return 1;
    } else if (maxWidth < 750) {
      return 1.6;
    } else if (maxWidth < Sizes.m.width) {
      return 1.1;
    } else if (maxWidth < Sizes.l.width) {
      return 1.3;
    }
    return 1;
  }
}
