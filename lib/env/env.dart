abstract class Env {
  final String googleMapsApiKey;
  final String packageName;
  final String appName;
  final String sendgridApiKey;
  final String sendgridTemplateId;

  const Env({
    required this.googleMapsApiKey,
    required this.packageName,
    required this.appName,
    required this.sendgridApiKey,
    required this.sendgridTemplateId,
  });
}

class EnvConfig implements Env {
  @override
  String get packageName => const String.fromEnvironment('PACKAGE_NAME');

  @override
  String get googleMapsApiKey =>
      const String.fromEnvironment('GOOGLE_MAPS_API_KEY');

  @override
  String get appName => const String.fromEnvironment('APP_NAME');

  @override
  String get sendgridApiKey => const String.fromEnvironment('SENDGRID_API_KEY');

  @override
  String get sendgridTemplateId =>
      const String.fromEnvironment('SENDGRID_TEMPLATE_ID');
}
