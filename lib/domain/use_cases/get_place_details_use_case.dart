import 'package:dog_gromming_website/data/datasources/remote/remote_datasource.dart';
import 'package:dog_gromming_website/domain/models/errors.dart';
import 'package:dog_gromming_website/domain/models/opening_hours.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetPlaceDetailsUseCase {
  final RemoteDatasource _remoteDatasource;

  const GetPlaceDetailsUseCase(this._remoteDatasource);

  Future<Either<MainError, OpeningHours>> call({required String languageCode}) {
    return _remoteDatasource.getPlaceDetails(languageCode: languageCode);
  }
}
