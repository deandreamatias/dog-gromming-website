import 'package:dog_gromming_website/domain/models/errors.dart';
import 'package:either_dart/either.dart';

abstract interface class RemoteDatasource {
  Future<Either<MainError, List<String>>> getExample();
}
