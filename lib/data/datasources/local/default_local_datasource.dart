import 'package:dog_gromming_website/data/datasources/local/local_data_source.dart';
import 'package:dog_gromming_website/di/di.dart';
import 'package:dog_gromming_website/domain/models/errors.dart';
import 'package:dog_gromming_website/env/env.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LocalDataSource)
class DefaultLocalDataSource implements LocalDataSource {
  final env = getIt<Env>();

  @override
  Future<Either<MainError, Env>> getEnvironment() {
    try {
      return Future.value(Right(env));
    } catch (e) {
      return Future.value(const Left(UnknownError()));
    }
  }
}
