import 'package:aider_mobile_app/core/services/http_service_requester.dart';

import '../../../../../core/errors/error.dart';
import '../../../../../core/services/api_routes.dart';
import '../../domain/models/chat/chat_model.dart';

abstract class InboxRemoteDatasource{
  Future<Map<String, dynamic>> approveBookingRequest({required String bookingExternalId, required Map<String, dynamic> requestBody});
  Future<ChatModel> sendNudge({String? conversationId, required Map<String, dynamic> requestBody});
}

class InboxRemoteDatasourceImpl extends InboxRemoteDatasource{
  InboxRemoteDatasourceImpl({required this.httpServiceRequester,});

  final HttpServiceRequester httpServiceRequester;

  @override
  Future<Map<String, dynamic>> approveBookingRequest({required String bookingExternalId, required Map<String, dynamic> requestBody}) async{
    final response = await httpServiceRequester.postRequest(
      endpoint: ApiRoutes.requestAcceptance(bookingExternalId),
      requestBody: requestBody
    );

    var body = response.data;
    if(body['success'] == false){
      throw ServerException(message: body['message']?? '');
    }

    return (body['data']?? {}) as Map<String, dynamic>;
  }

  @override
  Future<ChatModel> sendNudge({String? conversationId, required Map<String, dynamic> requestBody}) async{
    final response = await httpServiceRequester.postRequest(
        endpoint: ApiRoutes.sendMessage(conversationId),
        requestBody: requestBody
    );

    var body = response.data;
    if(body['success'] == false){
      throw ServerException(message: body['message']?? '');
    }

    return ChatModel.fromJson(body['data']);
  }

}
