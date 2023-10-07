import 'package:dog_gromming_website/data/services/dio_service.dart';
import 'package:dog_gromming_website/data/transformers/error_transformer.dart';
import 'package:dog_gromming_website/domain/models/errors.dart';
import 'package:injectable/injectable.dart';

class ApiService extends DioRestService<MainError> {
  ApiService()
      : super(
          validCodes: [200, 201, 202, 204],
          catchErrors: errorsHandler,
        );
}

@module
abstract class ApiServiceModule {
  @lazySingleton
  ApiService get httpClient => ApiService();
}
