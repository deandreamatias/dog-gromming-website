import 'package:dog_gromming_website/ui/styles/insets.dart';
import 'package:dog_gromming_website/ui/styles/sizes.dart';
import 'package:dog_gromming_website/ui/styles/spacing.dart';
import 'package:dog_gromming_website/ui/widgets/components/box_spacer.dart';
import 'package:dog_gromming_website/ui/widgets/components/footer.dart';
import 'package:dog_gromming_website/ui/widgets/screens/home/components/welcome_board.dart';
import 'package:dog_gromming_website/ui/widgets/screens/home/components/welcome_body.dart';
import 'package:dog_gromming_website/ui/widgets/screens/home/components/when_card.dart';
import 'package:dog_gromming_website/ui/widgets/screens/home/components/where_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxWidth = constraints.maxWidth;

        return ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(overscroll: false),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                children: [
                  maxWidth > Sizes.m.width
                      ? Padding(
                          padding: Insets.a16,
                          child: BigWelcomeBoard(
                            maxWidth: maxWidth - Insets.a16.horizontal,
                            child: const BigWelcomeBody(),
                          ),
                        )
                      : Padding(
                          padding: Insets.a16,
                          child: SmallWelcomeBoard(
                            maxWidth: maxWidth - Insets.a16.horizontal,
                            child: const SmallWelcomeBody(),
                          ),
                        ),
                  BoxSpacer.v8(),
                  Padding(
                    padding: Insets.a16,
                    child: _WhereWhenSection(maxWidth: maxWidth),
                  ),
                  BoxSpacer.v8(),
                  if (Sizes.s.width < maxWidth) const Footer(),
                ],
              ),
            ),
          ),
        );
      },
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
            children: [
              Expanded(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 400),
                  child: const WhereCard(),
                ),
              ),
              BoxSpacer.h24(),
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
