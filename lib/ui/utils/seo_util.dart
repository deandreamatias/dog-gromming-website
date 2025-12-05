import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:web/web.dart' as web;

/// Utility class for managing SEO meta tags across different screens
class SeoUtil {
  static const String _baseUrl = 'https://peluqueriacaninamimos.com';
  static const String _siteName = 'Peluquería canina Mimos';
  static const String _defaultImage = '$_baseUrl/icons/og-image.png';

  /// Update SEO meta tags for a specific page
  static void updateMetaTags({
    required String title,
    required String description,
    required String path,
    required String locale,
    String? image,
  }) {
    final fullUrl = '$_baseUrl/$locale$path';
    final ogImage = image ?? _defaultImage;

    // Update page title
    web.document.title = title;

    // Update or create meta tags
    _updateMetaTag('description', description, false);
    _updateMetaTag('og:title', title, true);
    _updateMetaTag('og:description', description, true);
    _updateMetaTag('og:url', fullUrl, true);
    _updateMetaTag('og:image', ogImage, true);
    _updateMetaTag('og:image:width', '1200', true);
    _updateMetaTag('og:image:height', '630', true);
    _updateMetaTag('og:image:alt', _siteName, true);
    _updateMetaTag('og:site_name', _siteName, true);
    _updateMetaTag('og:type', 'website', true);
    _updateMetaTag('og:locale', _getOgLocale(locale), true);
    _updateMetaTag('twitter:card', 'summary_large_image', false);
    _updateMetaTag('twitter:title', title, false);
    _updateMetaTag('twitter:description', description, false);
    _updateMetaTag('twitter:image', ogImage, false);

    // Update canonical link
    _updateLinkTag('canonical', fullUrl, null);

    // Update hreflang links
    _updateLinkTag('alternate', '$_baseUrl/es$path', 'es');
    _updateLinkTag('alternate', '$_baseUrl/en$path', 'en');
    _updateLinkTag('alternate', '$_baseUrl/pt$path', 'pt');
  }

  /// Helper method to update or create a meta tag
  static void _updateMetaTag(
    String nameOrProperty,
    String content,
    bool isProperty,
  ) {
    final attribute = isProperty ? 'property' : 'name';
    final selector = 'meta[$attribute="$nameOrProperty"]';

    var metaTag = web.document.querySelector(selector) as web.HTMLMetaElement?;

    if (metaTag == null) {
      metaTag = web.document.createElement('meta') as web.HTMLMetaElement;
      metaTag.setAttribute(attribute, nameOrProperty);
      web.document.head!.appendChild(metaTag);
    }

    metaTag.content = content;
  }

  /// Helper method to update or create a link tag
  static void _updateLinkTag(String rel, String href, String? hreflang) {
    String selector = 'link[rel="$rel"]';
    if (hreflang != null) {
      selector = 'link[rel="$rel"][hreflang="$hreflang"]';
    }

    var linkTag = web.document.querySelector(selector) as web.HTMLLinkElement?;

    if (linkTag == null) {
      linkTag = web.document.createElement('link') as web.HTMLLinkElement;
      linkTag.rel = rel;
      if (hreflang != null) {
        linkTag.hreflang = hreflang;
      }
      web.document.head!.appendChild(linkTag);
    }

    linkTag.href = href;
  }

  /// Get Open Graph locale format from language code
  static String _getOgLocale(String locale) => switch (locale) {
    'es' => 'es_ES',
    'en' => 'en_US',
    'pt' => 'pt_BR',
    _ => 'es_ES',
  };

  /// Home page SEO configuration
  static void updateHomePageSeo(BuildContext context) {
    updateMetaTags(
      title: context.tr('seo.home.title'),
      description: context.tr('seo.home.description'),
      path: '/home',
      locale: context.locale.languageCode,
    );
  }

  /// Services page SEO configuration
  static void updateServicesPageSeo(BuildContext context) {
    updateMetaTags(
      title: context.tr('seo.services.title'),
      description: context.tr('seo.services.description'),
      path: '/services',
      locale: context.locale.languageCode,
    );
  }

  /// About page SEO configuration
  static void updateAboutPageSeo(BuildContext context) {
    updateMetaTags(
      title: context.tr('seo.about.title'),
      description: context.tr('seo.about.description'),
      path: '/about',
      locale: context.locale.languageCode,
    );
  }

  /// Privacy policy page SEO configuration
  static void updatePrivacyPolicyPageSeo(BuildContext context) {
    updateMetaTags(
      title: context.tr('seo.privacy_policy.title'),
      description: context.tr('seo.privacy_policy.description'),
      path: '/privacy-policy',
      locale: context.locale.languageCode,
    );
  }
}
