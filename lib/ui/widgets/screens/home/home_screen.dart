import 'package:dog_gromming_website/ui/styles/insets.dart';
import 'package:dog_gromming_website/ui/styles/sizes.dart';
import 'package:dog_gromming_website/ui/widgets/components/box_spacer.dart';
import 'package:dog_gromming_website/ui/widgets/components/footer.dart';
import 'package:dog_gromming_website/ui/widgets/screens/home/components/welcome_board.dart';
import 'package:dog_gromming_website/ui/widgets/screens/home/components/welcome_body.dart';
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
                  const BoxSpacer(verticalSpacing: 500), // Placeholder
                  BoxSpacer.v32(),
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
