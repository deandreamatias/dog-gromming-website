import 'package:dog_gromming_website/data/datasources/local/local_data_source.dart';
import 'package:dog_gromming_website/domain/models/errors.dart';
import 'package:dog_gromming_website/domain/repositories/system/system_respository.dart';
import 'package:dog_gromming_website/env/env.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SystemRepository)
class SystemRepositoryImpl implements SystemRepository {
  final LocalDataSource _localDatasource;

  SystemRepositoryImpl(this._localDatasource);

  @override
  Future<Either<MainError, Env>> get() {
    return _localDatasource.getEnvironment();
  }
}
