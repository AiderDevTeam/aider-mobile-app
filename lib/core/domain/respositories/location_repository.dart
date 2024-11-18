
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/services/location_service.dart';
import '../../services/crash_service.dart';
import '../models/location/location_prediction_detail_model.dart';
import '../models/location/location_prediction_model.dart';

abstract class LocationRepository{
  Future<Either<Failure, List<LocationPredictionModel>>> searchLocation(String location);

  Future<Either<Failure, LocationPredictionDetailModel>> fetchLocationDetails(String placeId);
}


class LocationRepositoryImpl extends LocationRepository{
  LocationRepositoryImpl({required this.locationService,});
  final LocationService locationService;

  @override
  Future<Either<Failure, List<LocationPredictionModel>>> searchLocation(String location) async{
    try {
      final response = await locationService.searchLocation(location);
      return Right(response);
    } catch (e) {
      CrashService.setCrashKey('Location', 'location prediction');
      return Left(FailureToMessage.returnLeftError(e));
    }
  }

  @override
  Future<Either<Failure, LocationPredictionDetailModel>> fetchLocationDetails(String placeId) async{
    try {
      final response = await locationService.fetchLocationDetails(placeId);
      return Right(response);
    } catch (e) {
      CrashService.setCrashKey('Location', 'location detail');
      return Left(FailureToMessage.returnLeftError(e));
    }
  }

}