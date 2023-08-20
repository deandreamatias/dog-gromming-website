import 'package:dog_gromming_website/di/di.config.dart';
import 'package:dog_gromming_website/env/env.dart';
import 'package:dog_gromming_website/ui/navigation/main_navigator.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies({required String env}) =>
    getIt.init(environment: env);

const dev = Environment("dev");
const prod = Environment("prod");

@module
abstract class DiModule {
  @Singleton()
  Env get env => EnvConfig();

  @Singleton()
  MainNavigator get navigator => MainNavigator();
}
