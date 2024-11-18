import 'package:dio/dio.dart';

import '../../../../../core/errors/error.dart';
import '../../../../../core/services/api_routes.dart';
import '../../../../../core/services/http_service_requester.dart';
import '../../domain/verification_model/verification_model.dart';

abstract class KycRemoteDataSource {
  Future<VerificationModel> initializeVerification({required Map<String, dynamic> requestBody});
}

class KycRemoteDataSourceImpl extends KycRemoteDataSource {
  KycRemoteDataSourceImpl({
    required this.httpServiceRequester,
  });

  final HttpServiceRequester httpServiceRequester;

  @override
  Future<VerificationModel> initializeVerification({required Map<String, dynamic> requestBody}) async {
    final response = await httpServiceRequester.postFormDataRequest(
      endpoint: ApiRoutes.initializeVerification,
      requestBody: FormData.fromMap(requestBody),
    );

    var body = response.data;
    if (body['success'] != null && !body['success']) {
      throw ServerException(message: body['message'] ?? '');
    }
    return VerificationModel.fromJson(response.data['data']?? {});
  }
}
