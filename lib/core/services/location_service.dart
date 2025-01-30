import 'package:aider_mobile_app/core/env/environment.dart';
import 'package:aider_mobile_app/core/services/api_routes.dart';
import 'package:aider_mobile_app/core/services/logger_service.dart';
import 'package:aider_mobile_app/core/services/remote_config_service.dart';

import '../domain/models/location/location_prediction_detail_model.dart';
import '../domain/models/location/location_prediction_model.dart';
import '../errors/error.dart';
import 'http_service_requester.dart';

class LocationService {
  LocationService({
    required this.httpServiceRequester,
  });
  final HttpServiceRequester httpServiceRequester;

  Future<List<LocationPredictionModel>> searchLocation(String location) async {
    final googleMapKey = RemoteConfigService.getRemoteData.configs['env']
        ['googleMapKey'] as String;

    ZLoggerService.logOnInfo('GOOGLE MAP KEY: $googleMapKey');
    final response = await httpServiceRequester
        .getRequest(endpoint: ApiRoutes.googleLocation, queryParam: {
      'input': location,
      'key': googleMapKey,
      'components': 'country:NG',
    });
    final body = response.data['predictions'];
    return LocationPredictionList.fromJson(body).list;
  }

  Future<LocationPredictionDetailModel> fetchLocationDetails(
      String placeId) async {
    final googleMapKey = RemoteConfigService.getRemoteData.configs['env']
        ['googleMapKey'] as String;
    final response = await httpServiceRequester
        .getRequest(endpoint: ApiRoutes.googleLocationDetails, queryParam: {
      'place_id': placeId,
      'key': googleMapKey,
    });
    final body = response.data;
    if (body['status'] != null &&
        (body['status']).toString().toLowerCase() != 'ok') {
      throw ServerException(message: body['error_message'] ?? '');
    }

    return LocationPredictionDetailModel.fromJson(body['result']);
  }
}
