import 'dart:io';

import 'package:dog_gromming_website/ui/utils/platform_util.dart';
import 'package:flutter/foundation.dart';

/// Override certificates to avoid bad certificates in mobile devices
///
/// Only available to mobile native platforms (iOS and Android)
class CertificateHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void overrideHttpCertificate() {
  if (kDebugMode && PlatformUtil.isMobileSystem) {
    HttpOverrides.global = CertificateHttpOverrides();
  }
}
