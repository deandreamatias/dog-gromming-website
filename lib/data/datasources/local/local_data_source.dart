import 'package:dog_gromming_website/domain/models/errors.dart';
import 'package:dog_gromming_website/env/env.dart';
import 'package:either_dart/either.dart';

abstract interface class LocalDataSource {
  Future<Either<MainError, Env>> getEnvironment();
}
