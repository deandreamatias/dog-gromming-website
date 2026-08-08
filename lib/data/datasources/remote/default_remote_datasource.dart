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

  const DefaultRemoteDatasource(this._apiService, this._env);

  @override
  Future<Either<MainError, OpeningHours>> getPlaceDetails({
    required String languageCode,
  }) async {
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
    return Right(PlaceDetailsDto.fromJson(data).openingHours);
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
