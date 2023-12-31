import 'package:dog_gromming_website/data/datasources/remote/remote_datasource.dart';
import 'package:dog_gromming_website/data/dto/contact_client_dto.dart';
import 'package:dog_gromming_website/data/dto/sendgrid_email_dto.dart';
import 'package:dog_gromming_website/data/services/api_service.dart';
import 'package:dog_gromming_website/domain/models/contact_client.dart';
import 'package:dog_gromming_website/domain/models/errors.dart';
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
  Future<Either<MainError, List<String>>> getPlaceDetails() async {
    const mapsUrl = 'https://maps.googleapis.com/maps/api/place/details/json';

    final uri = Uri.parse(mapsUrl)
      ..queryParameters.addAll({
        'place_id': Constants.mapPlaceId,
        'fields':
            ' current_opening_hours,opening_hours,secondary_opening_hours',
        'key': _env.googleMapsApiKey,
      });

    final result = await _apiService.get<Map<String, dynamic>>(uri);
    return result.either<MainError, List<String>>(
      (left) => left,
      (right) => [],
    );
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
