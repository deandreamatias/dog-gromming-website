import 'package:dog_gromming_website/di/di.dart';
import 'package:dog_gromming_website/ui/viewmodels/home/home_viewmodel.dart';
import 'package:dog_gromming_website/ui/widgets/components/error_card.dart';
import 'package:dog_gromming_website/ui/widgets/components/iframe.dart';
import 'package:dog_gromming_website/ui/widgets/components/loading_circle.dart';
import 'package:dog_gromming_website/ui/widgets/screens/root_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends RootScreen<HomeViewState> {
  HomeScreen({super.key});

  @override
  final HomeViewModel viewModel = getIt<HomeViewModel>();

  @override
  Widget buildView(BuildContext context, HomeViewState state) {
    return Scaffold(
      body: SafeArea(
        child: switch (state) {
          Loading _ => const LoadingCircle(),
          Success _ => const Iframe(url: ''),
          Error _ => ErrorCard(error: state.error),
        },
      ),
    );
  }
}
