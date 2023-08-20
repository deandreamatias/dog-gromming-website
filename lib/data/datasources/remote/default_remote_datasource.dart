import 'package:dog_gromming_website/data/datasources/remote/remote_datasource.dart';
import 'package:dog_gromming_website/data/services/api_service.dart';
import 'package:dog_gromming_website/di/di.dart';
import 'package:dog_gromming_website/domain/models/errors.dart';
import 'package:dog_gromming_website/env/env.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RemoteDatasource)
class DefaultRemoteDatasource implements RemoteDatasource {
  final ApiService _apiService;
  final _env = getIt<Env>();

  DefaultRemoteDatasource(this._apiService);

  @override
  Future<Either<MainError, List<String>>> getExample() async {
    final uri = Uri.parse(_env.urlRestService);

    final result = await _apiService.get<Map<String, dynamic>>(uri);
    return result.either<MainError, List<String>>(
      (left) => left,
      (right) => [],
    );
  }
}
