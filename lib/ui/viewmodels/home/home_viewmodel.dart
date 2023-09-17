import 'package:dog_gromming_website/domain/models/errors.dart';
import 'package:dog_gromming_website/ui/viewmodels/base_viewmodel.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeViewModel extends BaseViewModel<HomeViewState> {
  HomeViewModel() : super(const Loading());

  @override
  void onAttach() async {
    emitValue(const Success(list: []));
  }
}

sealed class HomeViewState extends ViewState {
  const HomeViewState();
}

class Loading extends HomeViewState {
  const Loading();
}

class Success extends HomeViewState {
  final List<String> list;

  const Success({required this.list});
}

class Error extends HomeViewState {
  final MainError error;

  const Error(this.error);
}
