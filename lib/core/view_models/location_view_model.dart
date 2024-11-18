
import 'dart:developer';

import '../domain/models/location/location_prediction_detail_model.dart';
import '../domain/models/location/location_prediction_model.dart';
import '../domain/respositories/location_repository.dart';
import '../errors/failure.dart';
import '../services/git_it_service_locator.dart';
import 'base_view_model.dart';


class LocationViewModel extends BaseViewModel{
  final _locationRepository = sl.get<LocationRepository>();

  List<LocationPredictionModel> _locationPredictions = [];
  LocationPredictionDetailModel? _locationPredictionDetailModel;

  List<LocationPredictionModel> get getLocationPrediction => _locationPredictions;

  Future<void> searchLocation(String location) async{
    setComponentErrorType = null;
    setLoading(true, component: 'searchLocation');
    final result = await _locationRepository.searchLocation(location);

    result.fold((left) {
      log(FailureToMessage.mapFailureToMessage(left));
      setComponentErrorType = {
        'error': FailureToMessage.mapFailureToMessage(left),
        'component': 'searchLocation'
      };
      setLoading(false, component: 'searchLocation');

    }, (right) {
      _locationPredictions = right;
      setLoading(false, component: 'searchLocation');
    });
  }

  Future<LocationPredictionDetailModel?> fetchLocationDetails(String placeId) async{
    final result = await _locationRepository.fetchLocationDetails(placeId);

    result.fold((left) {
      _locationPredictionDetailModel = null;
      log(FailureToMessage.mapFailureToMessage(left));
    }, (right) {
      _locationPredictionDetailModel = right;
    });

    return _locationPredictionDetailModel;
  }




}