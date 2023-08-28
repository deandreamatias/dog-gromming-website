import 'package:dog_gromming_website/ui/viewmodels/root_viewmodel.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseScreen<S extends ViewState> extends StatelessWidget {
  const BaseScreen({super.key});

  abstract final RootViewModel<S> viewModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: BlocBuilder(
        bloc: viewModel,
        builder: (context, state) => buildView(context, state as S),
      ),
    );
  }

  Widget buildView(BuildContext context, S state);
}
