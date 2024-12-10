import 'package:dio/dio.dart';

import '../../../../../core/errors/error.dart';
import '../../../../../core/services/api_routes.dart';
import '../../../../../core/services/http_service_requester.dart';
import '../../domain/verification_model/verification_model.dart';

abstract class KycRemoteDataSource {
  Future<VerificationModel> initializeVerification({required Map<String, dynamic> requestBody});
  Future<List<VerificationModel>> fetchUserKYC({ required Map<String, dynamic> requestBody });
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

  @override
  Future<List<VerificationModel>> fetchUserKYC({required Map<String, dynamic> requestBody}) async {
    final response = await httpServiceRequester.getRequest(
      endpoint: ApiRoutes.getUserKYC,
    );

    var body = response.data;

    if (body['success'] == false) {
      throw ServerException(message: body['message'] ?? '');
    }

    return (body['data'] as List)
        .map((kycJson) => VerificationModel.fromJson(kycJson))
        .toList();
  }
}
