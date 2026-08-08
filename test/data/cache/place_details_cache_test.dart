import 'package:dog_gromming_website/data/cache/cache_store.dart';
import 'package:dog_gromming_website/data/cache/place_details_cache.dart';
import 'package:dog_gromming_website/domain/models/opening_hours.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  
  const languageCode = 'es';

  final sampleBody = <String, dynamic>{
    'businessStatus': 'OPERATIONAL',
    'regularOpeningHours': <String, dynamic>{
      'openNow': false,
      'periods': <Map<String, dynamic>>[
        <String, dynamic>{
          'open': <String, dynamic>{'day': 1, 'hour': 10, 'minute': 0},
          'close': <String, dynamic>{'day': 1, 'hour': 14, 'minute': 0},
        },
      ],
    },
    'currentOpeningHours': <String, dynamic>{
      'openNow': true,
      'specialDays': <Object>[],
    },
  };

  group('PlaceDetailsCache', () {
    test('writes and reads a round trip entry', () {
      final cache = PlaceDetailsCache(InMemoryCacheStore());

      cache.write(languageCode, sampleBody);
      final entry = cache.read(languageCode);

      expect(entry, isNotNull);
      expect(entry!.openingHours.isOpenNow, isTrue);
      expect(entry.openingHours.businessStatus, BusinessStatus.operational);
      expect(entry.openingHours.weekdays[1].times.first.startTime, 600);
      expect(entry.openingHours.closedSpecialDays, isEmpty);
      expect(cache.isFresh(entry), isTrue);
    });

    test('returns null when nothing is stored', () {
      final cache = PlaceDetailsCache(InMemoryCacheStore());

      expect(cache.read(languageCode), isNull);
    });

    test('removes a stored entry', () {
      final cache = PlaceDetailsCache(InMemoryCacheStore());

      cache.write(languageCode, sampleBody);
      cache.remove(languageCode);

      expect(cache.read(languageCode), isNull);
    });

    test('is not fresh after ttl has passed', () {
      final cache = PlaceDetailsCache(InMemoryCacheStore());
      cache.write(languageCode, sampleBody);
      final stored = cache.read(languageCode)!;
      final entry = PlaceDetailsCacheEntry(
        openingHours: stored.openingHours,
        cachedAt: DateTime.now()
            .subtract(PlaceDetailsCache.ttl + const Duration(seconds: 1)),
      );

      expect(cache.isFresh(entry), isFalse);
    });

    test('is fresh when inside ttl', () {
      final cache = PlaceDetailsCache(InMemoryCacheStore());
      cache.write(languageCode, sampleBody);
      final stored = cache.read(languageCode)!;
      final entry = PlaceDetailsCacheEntry(
        openingHours: stored.openingHours,
        cachedAt: DateTime.now().subtract(const Duration(minutes: 5)),
      );

      expect(cache.isFresh(entry), isTrue);
    });
  });
}
