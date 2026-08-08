import 'dart:async';

import 'package:dog_gromming_website/data/cache/place_details_cache.dart';
import 'package:dog_gromming_website/data/datasources/remote/remote_datasource.dart';
import 'package:dog_gromming_website/data/dto/contact_client_dto.dart';
import 'package:dog_gromming_website/data/dto/place_details_dto.dart';
import 'package:dog_gromming_website/data/dto/sendgrid_email_dto.dart';
import 'package:dog_gromming_website/data/services/api_service.dart';
import 'package:dog_gromming_website/domain/models/contact_client.dart';
import 'package:dog_gromming_website/domain/models/errors.dart';
import 'package:dog_gromming_website/domain/models/opening_hours.dart';
import 'package:dog_gromming_website/env/constants.dart';
import 'package:dog_gromming_website/env/env.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RemoteDatasource)
class DefaultRemoteDatasource implements RemoteDatasource {
  final ApiService _apiService;
  final Env _env;
  final PlaceDetailsCache _cache;

  final Map<String, Future<Either<MainError, OpeningHours>>> _inFlight =
      <String, Future<Either<MainError, OpeningHours>>>{};

  DefaultRemoteDatasource(this._apiService, this._env, this._cache);

  @override
  Future<Either<MainError, OpeningHours>> getPlaceDetails({
    required String languageCode,
  }) async {
    final cached = _cache.read(languageCode);
    if (cached == null) return _fetch(languageCode);

    if (_cache.isFresh(cached)) {
      return Right(cached.openingHours);
    }

    unawaited(_fetch(languageCode));
    return Right(cached.openingHours);
  }

  Future<Either<MainError, OpeningHours>> _fetch(String languageCode) {
    final existing = _inFlight[languageCode];
    if (existing != null) return existing;

    final future = _doFetch(languageCode);
    _inFlight[languageCode] = future;
    future.whenComplete(() => _inFlight.remove(languageCode));
    return future;
  }

  Future<Either<MainError, OpeningHours>> _doFetch(String languageCode) async {
    final uri = Uri.https(
      'places.googleapis.com',
      '/v1/places/${Constants.mapPlaceId}',
      <String, String>{
        'fields': 'currentOpeningHours,regularOpeningHours,businessStatus',
        'languageCode': languageCode,
        'key': _env.googleMapsApiKey,
      },
    );

    final result = await _apiService.get<Map<String, dynamic>>(uri);
    if (result.isLeft) return Left(result.left);
    final data = result.right;
    if (data == null || data.isEmpty) return const Left(UnknowApiError());

    try {
      final openingHours = PlaceDetailsDto.fromJson(data).openingHours;
      _cache.write(languageCode, data);
      return Right(openingHours);
    } catch (_) {
      return const Left(UnknowApiError());
    }
  }

  @override
  Future<Either<MainError, bool>> sendEmail({
    required ContactClient contactClient,
  }) async {
    final uri = Uri.parse('https://api.sendgrid.com/v3/mail/send');

    final data = SendgridDto(
      from: const SendgridEmail(email: Constants.email),
      personalizations: [
        SendgridPersonalization(
          to: const [SendgridEmail(email: Constants.email)],
          templateData: ContactClientDto.fromDomain(contactClient),
        ),
      ],
      templateId: _env.sendgridTemplateId,
    );

    try {
      _apiService.post(
        uri,
        data: data.toJson(),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${_env.sendgridApiKey}',
        },
      );
      return const Right(true);
    } catch (e) {
      return const Left(UnknowApiError());
    }
  }
}
