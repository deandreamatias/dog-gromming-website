import 'package:dog_gromming_website/di/di.dart';
import 'package:dog_gromming_website/domain/models/errors.dart';
import 'package:dog_gromming_website/ui/navigation/main_navigator.dart';
import 'package:dog_gromming_website/ui/viewmodels/root_viewmodel.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class HomeViewModel extends RootViewModel<HomeViewState> {
  MainNavigator get navigator => getIt<MainNavigator>();

  HomeViewModel() : super(Loading());

  @override
  void onAttach() async {
    emitValue(Success(list: []));
  }
}

sealed class HomeViewState extends ViewState {}

class Loading extends HomeViewState {}

class Success extends HomeViewState {
  final List<String> list;

  Success({required this.list});
}

class Error extends HomeViewState {
  final MainError error;

  Error(this.error);
}
