abstract class Env {
  final String urlRestService;
  final String packageName;
  final String appName;

  const Env({
    required this.urlRestService,
    required this.packageName,
    required this.appName,
  });
}

class EnvConfig implements Env {
  @override
  String get packageName => const String.fromEnvironment("PACKAGE_NAME");

  @override
  String get urlRestService => const String.fromEnvironment("URL_REST_SERVICE");

  @override
  String get appName => const String.fromEnvironment("APP_NAME");
}
