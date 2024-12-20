import 'package:aider_mobile_app/core/env/environment.dart';
import 'package:aider_mobile_app/core/services/api_routes.dart';

import '../domain/models/location/location_prediction_detail_model.dart';
import '../domain/models/location/location_prediction_model.dart';
import '../errors/error.dart';
import 'http_service_requester.dart';

class LocationService{
  LocationService({required this.httpServiceRequester,});
  final HttpServiceRequester httpServiceRequester;

  Future<List<LocationPredictionModel>> searchLocation(String location) async{
    final response = await httpServiceRequester.getRequest(
        endpoint: ApiRoutes.googleLocation,
        queryParam: {
          'input': location,
          'key': Environment.getGoogleMapKey,
          'components': 'country:NG',
        }
    );
    final body = response.data['predictions'];
    return LocationPredictionList.fromJson(body).list;
  }

  Future<LocationPredictionDetailModel> fetchLocationDetails(String placeId) async{
    final response = await httpServiceRequester.getRequest(
        endpoint: ApiRoutes.googleLocationDetails,
        queryParam: {
          'place_id': placeId,
          'key': Environment.getGoogleMapKey,
        }
    );
    final body = response.data;
    if(body['status'] != null && (body['status']).toString().toLowerCase() != 'ok'){
      throw ServerException(message: body['error_message']?? '');
    }

    return LocationPredictionDetailModel.fromJson(body['result']);
  }
}
