import 'package:aider_mobile_app/core/services/http_service_requester.dart';

import '../../../../../core/services/logger_service.dart';
import '../../../../../core/errors/error.dart';
import '../../../../../core/services/api_routes.dart';
import '../../domain/models/transaction/transaction_model.dart';

abstract class TransactionRemoteDatasource{
  Future<TransactionModel> initiateTransaction({required Map<String, dynamic> requestBody});
  Future<String> enquireAccountName({required Map<String, dynamic> queryParam});
  Future<bool> collectionCallback({required String stan });
}

class TransactionRemoteDatasourceImpl extends TransactionRemoteDatasource{
  TransactionRemoteDatasourceImpl({required this.httpServiceRequester,});

  final HttpServiceRequester httpServiceRequester;

  @override
  Future<TransactionModel> initiateTransaction({required Map<String, dynamic> requestBody}) async{
    final response = await httpServiceRequester.postRequest(
      endpoint: ApiRoutes.initiatePayment,
      requestBody: requestBody
    );

    var body = response.data;
    if(body['success'] == false){
      throw ServerException(message: body['message']?? '');
    }

    return TransactionModel.fromJson(body['data']);
  }

  @override
  Future<bool> collectionCallback({required String stan}) async{
    final response = await httpServiceRequester.getRequest(
        endpoint: ApiRoutes.collectionCallback(stan),
    );

    var body = response.data;
    if(body['success'] == false){
      throw ServerException(message: body['message']?? '');
    }

    return true;
  }

  @override
  Future<String> enquireAccountName({required Map<String, dynamic> queryParam}) async{
    final response = await httpServiceRequester.getRequest(
      endpoint: ApiRoutes.accountResolution,
      queryParam: queryParam,
    );
    ZLoggerService.logOnInfo('FETCHING ACCOUNT NAME \n ---- $response ---- \n${DateTime.now()}');
    var body = response.data;
    if(body['success'] == false){
      throw ServerException(message: body['message']?? '');
    }

    return body['data']['accountName']?? '';
  }
}
