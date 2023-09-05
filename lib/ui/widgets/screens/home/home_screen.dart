import 'package:dog_gromming_website/ui/styles/insets.dart';
import 'package:dog_gromming_website/ui/styles/sizes.dart';
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
        final double maxHeight = constraints.maxHeight;

        if (maxWidth > Sizes.medium.width) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: maxHeight,
              ),
              child: BigWelcomeBoard(
                maxWidth: maxWidth,
                maxHeight: maxHeight,
                child: const BigWelcomeBody(),
              ),
            ),
          );
        }
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: Insets.a16,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: maxHeight,
              ),
              child: SmallWelcomeBoard(
                maxWidth: maxWidth - Insets.a16.horizontal,
                child: const SmallWelcomeBody(),
              ),
            ),
          ),
        );
      },
    );
  }
}
