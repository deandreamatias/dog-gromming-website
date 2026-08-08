import 'package:dog_gromming_website/domain/models/contact_client.dart';
import 'package:dog_gromming_website/domain/models/errors.dart';
import 'package:dog_gromming_website/domain/models/opening_hours.dart';
import 'package:either_dart/either.dart';

abstract interface class RemoteDatasource {
  Future<Either<MainError, OpeningHours>> getPlaceDetails({
    required String languageCode,
  });
  Future<Either<MainError, bool>> sendEmail({
    required ContactClient contactClient,
  });
}
