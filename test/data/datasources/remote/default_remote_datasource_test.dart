import 'dart:convert';

import 'package:dog_gromming_website/data/cache/cache_store.dart';
import 'package:dog_gromming_website/data/cache/place_details_cache.dart';
import 'package:dog_gromming_website/data/datasources/remote/default_remote_datasource.dart';
import 'package:dog_gromming_website/data/services/api_service.dart';
import 'package:dog_gromming_website/domain/models/errors.dart';
import 'package:dog_gromming_website/env/env.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeApiService extends ApiService {
  Map<String, dynamic>? response;
  int calls = 0;
  bool shouldFail = false;

  @override
  Future<Either<MainError, T?>> get<T>(
    Uri uri, {
    Map<String, dynamic>? headers,
  }) async {
    calls++;
    if (shouldFail) return Left<MainError, T?>(const ServerError());
    return Right<MainError, T?>(response as T?);
  }
}

class _FakeEnv implements Env {
  const _FakeEnv();

  @override
  String get googleMapsApiKey => 'test-key';

  @override
  String get appName => 'test';

  @override
  String get packageName => 'test';

  @override
  String get sendEmailFunctionUrl => 'https://test.com/send-email';
}

void main() {
  const languageCode = 'es';
  const cacheKey = 'place_details_ChIJOVeL4O9PYA0RoT1iTfUhHaA_es';

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

  late InMemoryCacheStore store;
  late _FakeApiService api;
  late DefaultRemoteDatasource datasource;

  setUp(() {
    store = InMemoryCacheStore();
    api = _FakeApiService()..response = sampleBody;
    datasource = DefaultRemoteDatasource(
      api,
      const _FakeEnv(),
      PlaceDetailsCache(store),
    );
  });

  void storeStale() {
    store.write(
      cacheKey,
      jsonEncode(<String, dynamic>{
        'body': sampleBody,
        'cachedAt': DateTime.now()
            .subtract(const Duration(hours: 2))
            .millisecondsSinceEpoch,
      }),
    );
  }

  test('fetches from network and stores in cache on first request', () async {
    final result = await datasource.getPlaceDetails(languageCode: languageCode);

    expect(api.calls, 1);
    expect(result.isRight, isTrue);
    expect(store.read(cacheKey), isNotNull);
  });

  test('serves fresh cache without a network call', () async {
    store.write(
      cacheKey,
      jsonEncode(<String, dynamic>{
        'body': sampleBody,
        'cachedAt': DateTime.now().millisecondsSinceEpoch,
      }),
    );

    final result = await datasource.getPlaceDetails(languageCode: languageCode);

    expect(result.isRight, isTrue);
    expect(api.calls, 0);
  });

  test('refreshes stale cache in the background', () async {
    storeStale();

    final result = await datasource.getPlaceDetails(languageCode: languageCode);

    expect(result.isRight, isTrue);

    await Future<void>.delayed(const Duration(milliseconds: 50));
    expect(api.calls, 1);
    expect(store.read(cacheKey), isNotNull);
  });

  test('serves stale cache when the network fails', () async {
    storeStale();
    api.shouldFail = true;

    final result = await datasource.getPlaceDetails(languageCode: languageCode);

    expect(result.isRight, isTrue);
    await Future<void>.delayed(const Duration(milliseconds: 50));
    expect(api.calls, 1);
  });

  test('returns error without cache when the network fails', () async {
    api.shouldFail = true;

    final result = await datasource.getPlaceDetails(languageCode: 'en');

    expect(result.isLeft, isTrue);
    expect(result.left, isA<ServerError>());
    expect(api.calls, 1);
  });
}
