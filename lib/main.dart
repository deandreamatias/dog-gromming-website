import 'package:dog_gromming_website/app.dart';
import 'package:dog_gromming_website/data/services/certificates_http_overrides.dart';
import 'package:dog_gromming_website/di/di.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  const String env = String.fromEnvironment("ENVIRONMENT");
  configureDependencies(env: env);
  final widgetBindings = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetBindings);

  if (dev.name == env) overrideHttpCertificate();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('es')],
      path: 'assets/translations',
      fallbackLocale: const Locale('es'),
      child: const App(),
    ),
  );
}
