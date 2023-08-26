import 'package:dog_gromming_website/app.dart';
import 'package:dog_gromming_website/data/services/certificates_http_overrides.dart';
import 'package:dog_gromming_website/di/di.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  const String env = String.fromEnvironment("ENVIRONMENT");
  configureDependencies(env: env);

  final widgetBindings = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetBindings);

  LicenseRegistry.addLicense(() async* {
    final fredokaLicense =
        await rootBundle.loadString('assets/licenses/comfortaa-OFL.txt');
    final comfortaaLicense =
        await rootBundle.loadString('assets/licenses/fredoka-OFL.txt');

    yield LicenseEntryWithLineBreaks(['google_fonts'], fredokaLicense);
    yield LicenseEntryWithLineBreaks(['google_fonts'], comfortaaLicense);
  });

  if (dev.name == env) overrideHttpCertificate();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('es'),
        Locale('pt'),
      ],
      path: 'assets/translations',
      useOnlyLangCode: true,
      fallbackLocale: const Locale('es'),
      child: const App(),
    ),
  );
}
