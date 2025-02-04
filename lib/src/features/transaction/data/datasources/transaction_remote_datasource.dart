import 'package:aider_mobile_app/core/services/http_service_requester.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../core/services/logger_service.dart';
import '../../../../../core/errors/error.dart';
import '../../../../../core/services/api_routes.dart';
import '../../../../../core/services/remote_config_service.dart';

abstract class TransactionRemoteDatasource {
  Future<String> initiateTransaction({required String bookingUid});
  Future<void> initiatePayout({required String bookingUid});
  Future<String> enquireAccountName({required Map<String, dynamic> queryParam});
  Future<bool> collectionCallback({required String stan});
}

class TransactionRemoteDatasourceImpl extends TransactionRemoteDatasource {
  TransactionRemoteDatasourceImpl({
    required this.httpServiceRequester,
    required this.auth,
  });

  final HttpServiceRequester httpServiceRequester;
  final FirebaseAuth auth;
  @override
  Future<String> initiateTransaction({required String bookingUid}) async {
    final baseUrl = RemoteConfigService.getRemoteData.configs['env']
        ['paymentBaseUrl'] as String;

    final token = await auth.currentUser!.getIdToken();
    final response = await httpServiceRequester.postRequest(
      endpoint: '$baseUrl/initiate-payment',
      requestBody: {'bookingUid': bookingUid},
      token: token,
    );

    var body = response.data;
    if (body['success'] == false) {
      throw ServerException(message: body['message'] ?? '');
    }

    return body['data']['paymentUrl'];
  }

  @override
  Future<bool> collectionCallback({required String stan}) async {
    final response = await httpServiceRequester.getRequest(
      endpoint: ApiRoutes.collectionCallback(stan),
    );

    var body = response.data;
    if (body['success'] == false) {
      throw ServerException(message: body['message'] ?? '');
    }

    return true;
  }

  @override
  Future<String> enquireAccountName(
      {required Map<String, dynamic> queryParam}) async {
    final response = await httpServiceRequester.getRequest(
      endpoint: ApiRoutes.accountResolution,
      queryParam: queryParam,
    );
    ZLoggerService.logOnInfo(
        'FETCHING ACCOUNT NAME \n ---- $response ---- \n${DateTime.now()}');
    var body = response.data;
    if (body['status'] == 'error') {
      throw ServerException(message: body['message'] ?? '');
    }

    return body['data']['accountName'] ?? '';
  }

  @override
  Future<void> initiatePayout({required String bookingUid}) async {
    final token = await auth.currentUser!.getIdToken();
    final baseUrl = RemoteConfigService.getRemoteData.configs['env']
        ['paymentBaseUrl'] as String;

    final response = await httpServiceRequester.postRequest(
      endpoint: '$baseUrl/payout',
      requestBody: {'bookingUid': bookingUid},
      token: token,
    );

    var body = response.data;
    if (body['status'] == 'error') {
      throw ServerException(message: body['message'] ?? '');
    }

    return;
  }
}
