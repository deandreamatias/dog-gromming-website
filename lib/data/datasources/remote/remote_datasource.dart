import 'package:dog_gromming_website/domain/models/contact_client.dart';
import 'package:dog_gromming_website/domain/models/errors.dart';
import 'package:either_dart/either.dart';

abstract interface class RemoteDatasource {
  Future<Either<MainError, List<String>>> getPlaceDetails();
  Future<Either<MainError, bool>> sendEmail({
    required ContactClient contactClient,
  });
}
