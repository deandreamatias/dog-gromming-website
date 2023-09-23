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
                    child: _WhereWhenSection(
                      isSmall: maxWidth < Sizes.m.width,
                    ),
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
  final bool isSmall;
  const _WhereWhenSection({this.isSmall = false});

  @override
  Widget build(BuildContext context) {
    return isSmall
        ? GridView.extent(
            shrinkWrap: true,
            crossAxisSpacing: Spacing.sp16,
            mainAxisSpacing: Spacing.sp16,
            maxCrossAxisExtent: 700,
            childAspectRatio: 1.5,
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
}
