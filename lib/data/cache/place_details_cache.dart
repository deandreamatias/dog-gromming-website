import 'dart:convert';

import 'package:dog_gromming_website/data/cache/cache_store.dart';
import 'package:dog_gromming_website/data/dto/place_details_dto.dart';
import 'package:dog_gromming_website/domain/models/opening_hours.dart';
import 'package:dog_gromming_website/env/constants.dart';
import 'package:injectable/injectable.dart';

class PlaceDetailsCacheEntry {
  final OpeningHours openingHours;
  final DateTime cachedAt;

  const PlaceDetailsCacheEntry({
    required this.openingHours,
    required this.cachedAt,
  });
}

@injectable
class PlaceDetailsCache {
  static const Duration ttl = Duration(minutes: 15);

  final CacheStore _store;

  const PlaceDetailsCache(CacheStore store) : _store = store;

  PlaceDetailsCacheEntry? read(String languageCode) {
    final raw = _store.read(_key(languageCode));
    if (raw == null) return null;
    try {
      final json = jsonDecode(raw) as Map<String, dynamic>;
      final body = json['body'] as Map<String, dynamic>;
      final cachedAt = DateTime.fromMillisecondsSinceEpoch(
        json['cachedAt'] as int,
      );
      return PlaceDetailsCacheEntry(
        openingHours: PlaceDetailsDto.fromJson(body).openingHours,
        cachedAt: cachedAt,
      );
    } catch (_) {
      return null;
    }
  }

  void write(String languageCode, Map<String, dynamic> body) {
    _store.write(
      _key(languageCode),
      jsonEncode(<String, dynamic>{
        'body': body,
        'cachedAt': DateTime.now().millisecondsSinceEpoch,
      }),
    );
  }

  void remove(String languageCode) {
    _store.remove(_key(languageCode));
  }

  bool isFresh(PlaceDetailsCacheEntry entry) =>
      DateTime.now().difference(entry.cachedAt) < ttl;

  String _key(String languageCode) =>
      'place_details_${Constants.mapPlaceId}_$languageCode';
}
