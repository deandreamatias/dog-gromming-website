import 'package:dog_gromming_website/di/di.dart';
import 'package:dog_gromming_website/ui/viewmodels/splash/splash_viewmodel.dart';
import 'package:dog_gromming_website/ui/widgets/components/error_card.dart';
import 'package:dog_gromming_website/ui/widgets/screens/root_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends RootScreen<SplashViewState> {
  const SplashScreen({super.key});

  @override
  SplashViewModel get viewModel => getIt<SplashViewModel>();

  @override
  Widget buildView(BuildContext context, SplashViewState state) {
    return Scaffold(
      body: Center(
        child: switch (state) {
          Loading _ => const SizedBox.shrink(),
          Success _ => const SizedBox.shrink(),
          Error _ => ErrorCard(error: state.error),
        },
      ),
    );
  }
}
