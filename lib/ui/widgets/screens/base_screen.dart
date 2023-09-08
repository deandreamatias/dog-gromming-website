import 'package:dog_gromming_website/di/di.dart';
import 'package:dog_gromming_website/ui/viewmodels/base_viewmodel.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseScreen<T extends ViewState, V extends BaseViewModel<T>>
    extends StatelessWidget {
  const BaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = getIt<V>();

    return BlocBuilder<V, T>(
      bloc: viewModel,
      builder: (context, state) {
        return buildView(context, state, viewModel);
      },
    );
  }

  Widget buildView(BuildContext context, T state, V viewModel);
}

abstract class BaseScreenStateful<T extends ViewState,
    V extends BaseViewModel<T>> extends StatefulWidget {
  const BaseScreenStateful({super.key});

  @override
  RootScreenState<T, V, BaseScreenStateful<T, V>> createState();
}

abstract class RootScreenState<T extends ViewState, V extends BaseViewModel<T>,
    K extends BaseScreenStateful<T, V>> extends State<K> {
  late final V viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = getIt<V>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<V, T>(
      bloc: viewModel,
      builder: (context, state) {
        return buildView(context, state, viewModel);
      },
    );
  }

  Widget buildView(BuildContext context, T state, V viewModel);
}
