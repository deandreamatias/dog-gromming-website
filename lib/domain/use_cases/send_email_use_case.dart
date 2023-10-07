import 'package:dog_gromming_website/data/datasources/remote/remote_datasource.dart';
import 'package:dog_gromming_website/domain/models/contact_client.dart';
import 'package:dog_gromming_website/domain/models/errors.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

@injectable
class SendEmailUseCase {
  final RemoteDatasource _remoteDatasource;

  const SendEmailUseCase(this._remoteDatasource);

  Future<Either<MainError, bool>> call({
    required ContactClient contactClient,
  }) async {
    if (!contactClient.isValid) return const Left(InvalidDataForm());

    return _remoteDatasource.sendEmail(contactClient: contactClient);
  }
}
