import 'package:dog_gromming_website/di/di.dart';
import 'package:dog_gromming_website/domain/models/errors.dart';
import 'package:dog_gromming_website/domain/repositories/system/system_respository.dart';
import 'package:dog_gromming_website/env/env.dart';
import 'package:dog_gromming_website/ui/navigation/main_navigator.dart';
import 'package:dog_gromming_website/ui/viewmodels/root_viewmodel.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class SplashViewModel extends RootViewModel<SplashViewState> {
  final _systemRepository = getIt<SystemRepository>();

  MainNavigator get navigator => getIt<MainNavigator>();

  SplashViewModel() : super(Loading());

  @override
  void onAttach() async {
    final response = await _systemRepository.get();
    response.fold(
      (left) => emitValue(Error(left)),
      (right) => emitValue(Success(right)),
    );
    FlutterNativeSplash.remove();

    if (response.isRight) {
      redirect();
    }
  }

  void redirect() {
    navigator.navigateToAnnouncement();
  }
}

sealed class SplashViewState extends ViewState {}

class Loading extends SplashViewState {}

class Success extends SplashViewState {
  final Env env;

  Success(this.env);
}

class Error extends SplashViewState {
  final MainError error;

  Error(this.error);
}
