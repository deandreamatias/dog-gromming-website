import 'package:url_launcher/url_launcher.dart';

/// Methods to make easy open links and apps
///
/// Remember to setup your targer platform follow this
/// https://pub.dev/packages/url_launcher#configuration
class UrlLauncherUtil {
  /// Open link with external browser
  static Future<void> openLink(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
      return;
    }
    throw 'Could not launch $url';
  }

  /// Open dialer app to call
  static Future<void> openTelephone(String telephone) async {
    await openLink(Uri.parse('tel:$telephone'));
  }

  /// Open mail client to send email
  static Future<void> openMail(String email) async {
    await openLink(Uri.parse('mailto:$email'));
  }

  /// Use whatsapp api to open Whatsapp app
  ///
  /// Number required a country code
  /// Example [+34123456789]
  static Future<void> openWhatsapp(String number) async {
    await openLink(Uri.parse('https://wa.me/$number'));
  }

  /// Use google maps api to open app
  static Future<void> openMaps(double lat, double lon) async {
    await openLink(
      Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lon'),
    );
  }
}
