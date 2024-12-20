import 'package:dio/dio.dart';

import '../../../errors/error.dart';
import '../../../services/api_routes.dart';
import '../../../services/git_it_service_locator.dart';
import '../../../services/http_service_requester.dart';
import '../../../services/local_storage_service.dart';
import '../../../services/logger_service.dart';
import '../../domain/models/wallet/wallet_model.dart';
import '../../domain/models/user/user_model.dart';

abstract class UserRemoteDatasource{
  Future<UserModel> signup({required Map<String, dynamic> requestBody});
  Future<UserModel> login({required Map<String, dynamic> requestBody});
  Future<String> forgotPassword({required Map<String, dynamic> requestBody});
  Future<bool> resetPassword({ required Map<String, dynamic> requestBody });
  Future<bool> logout();
  Future<bool> deleteAccount({ required Map<String, dynamic> requestBody });
  Future<UserModel> updateUser({ required Map<String, dynamic> requestBody });
  Future<UserModel> fetchUserDetail({ required Map<String, dynamic> requestBody });
  Future<bool> verifyDisplayName({ required Map<String, dynamic> requestBody });
  Future<bool> verifyEmail({ required Map<String, dynamic> requestBody });
  Future<String> signUpOTP({ required Map<String, dynamic> requestBody });
  Future<WalletModel> saveWallet({ required Map<String, dynamic> requestBody });
  Future<List<WalletModel>> fetchWallet({ required Map<String, dynamic> requestBody });
  Future<WalletModel> setWalletToDefault({String? walletExternalId});
  Future<bool> addProfileImage({required Map<String, dynamic> requestBody});
  Future<List<dynamic>> userType();
}

class UserRemoteDatasourceImpl extends UserRemoteDatasource{

  UserRemoteDatasourceImpl({required this.httpServiceRequester});

  final HttpServiceRequester httpServiceRequester;

  @override
  Future<UserModel> signup({required Map<String, dynamic> requestBody}) async{
    final response = await httpServiceRequester.postRequest(
      endpoint: ApiRoutes.signup,
      requestBody: requestBody,
    );

    var body = response.data;
    if(body['success'] == false){
      throw ServerException(message: body['message']?? '');
    }

    var token = body['data']['bearer']['token'];
    await sl.get<LocalStorageService>().writeToken(token??'');
    return UserModel.fromJson(response.data['data']?? {});
  }

  @override
  Future<UserModel> login({required Map<String, dynamic> requestBody}) async{
    final response = await httpServiceRequester.postRequest(
      endpoint: ApiRoutes.login,
      requestBody: requestBody,
    );

    var body = response.data;
    if(body['success'] == false){
      throw ServerException(message: body['message']?? '');
    }

    var token = body['data']['bearer']['token'];
    await sl.get<LocalStorageService>().writeToken(token??'');
    return UserModel.fromJson(response.data['data']?? {});
  }

  @override
  Future<String> forgotPassword({ required Map<String, dynamic> requestBody }) async{
    final response = await httpServiceRequester.postRequest(
      endpoint: ApiRoutes.forgotPassword,
      requestBody: requestBody,
    );
    var body = response.data;
    if(body['success'] != null && !body['success']){
      throw ServerException(message: body['message']?? '');
    }

    return body['data']['code'];
  }

  @override
  Future<bool> resetPassword({ required Map<String, dynamic> requestBody }) async{
    final response = await httpServiceRequester.postRequest(
      endpoint: ApiRoutes.resetPassword,
      requestBody: requestBody,
    );
    var body = response.data;
    if(body['success'] != null && !body['success']){
      throw ServerException(message: body['message']?? '');
    }

    return true;
  }

  @override
  Future<bool> logout() async{
    final response = await httpServiceRequester.postRequest(
      endpoint: ApiRoutes.logout,
    );
    var body = response.data;
    if(body['success'] != null && !body['success']){
      throw ServerException(message: body['message']?? '');
    }

    return true;
  }

  @override
  Future<bool> deleteAccount({ required Map<String, dynamic> requestBody }) async{
    await httpServiceRequester.postRequest(
      endpoint: ApiRoutes.deleteAccount, requestBody: requestBody,
    );

    return true;
  }

  @override
  Future<UserModel> updateUser({ required Map<String, dynamic> requestBody }) async{
    final response = await httpServiceRequester.putRequest(
      endpoint: ApiRoutes.updateUser, requestBody: requestBody,
    );

    var body = response.data;
    if(body['success'] != null && !body['success']){
      throw ServerException(message: body['message']?? '');
    }

    return UserModel.fromJson(body['data']?? {});
  }

  @override
  Future<UserModel> fetchUserDetail({ required Map<String, dynamic> requestBody }) async{
    final response = await httpServiceRequester.getRequest(
      endpoint: ApiRoutes.updateUser,
    );

    var body = response.data;
    if(body['success'] != null && !body['success']){
      throw ServerException(message: body['message']?? '');
    }

    return UserModel.fromJson(body['data']?? {});
  }

  @override
  Future<bool> verifyDisplayName({required Map<String, dynamic> requestBody}) async{
    final response = await httpServiceRequester.postRequest(
      endpoint: ApiRoutes.verifyDisplayName,
      requestBody: requestBody,
    );

    var body = response.data;
    if(body['success'] == false){
      throw ServerException(message: body['message']?? '');
    }

    return true;
  }

  @override
  Future<bool> verifyEmail({required Map<String, dynamic> requestBody}) async{
    final response = await httpServiceRequester.postRequest(
      endpoint: ApiRoutes.verifyEmail,
      requestBody: requestBody,
    );

    var body = response.data;
    if(body['success'] == false){
      throw ServerException(message: body['message']?? '');
    }

    return true;
  }

  @override
  Future<String> signUpOTP({required Map<String, dynamic> requestBody}) async{
    final response = await httpServiceRequester.postRequest(
      endpoint: ApiRoutes.signUpOTP,
      requestBody: requestBody,
    );

    var body = response.data;
    if(body['success'] == false){
      throw ServerException(message: body['message']?? '');
    }

    return body['data']?['code']?? '';
  }

  @override
  Future<WalletModel> saveWallet({required Map<String, dynamic> requestBody}) async{
    final response = await httpServiceRequester.postRequest(
      endpoint: ApiRoutes.bankAccountWallet,
      requestBody: requestBody,
    );

    var body = response.data;
    if(body['success'] == false){
      throw ServerException(message: body['message']?? '');
    }

    return WalletModel.fromJson(body['data']);
  }

  @override
  Future<List<WalletModel>> fetchWallet({required Map<String, dynamic> requestBody}) async {
    final response = await httpServiceRequester.getRequest(
      endpoint: ApiRoutes.bankAccountWallet,
    );

    var body = response.data;

    if (body['success'] == false) {
      throw ServerException(message: body['message'] ?? '');
    }
    return (body['data'] as List)
        .map((walletJson) => WalletModel.fromJson(walletJson))
        .toList();
  }



  @override
  Future<WalletModel> setWalletToDefault({String? walletExternalId}) async{
    final response = await httpServiceRequester.postRequest(
      endpoint: ApiRoutes.walletToDefault(walletExternalId),
    );

    var body = response.data;
    if(body['success'] == false){
      throw ServerException(message: body['message']?? '');
    }

    return WalletModel.fromJson(body['data']);
  }

  @override
  Future<bool> addProfileImage({required Map<String, dynamic> requestBody}) async{
    final response = await httpServiceRequester.postFormDataRequest(
      endpoint: ApiRoutes.addProfileImage,
      requestBody: FormData.fromMap(requestBody),
    );

    var body = response.data;
    if(body['success'] != null && !body['success']){
      throw ServerException(message: body['message']?? '');
    }

    return true;
  }

  @override
  Future<List<dynamic>> userType() async{
    final response = await httpServiceRequester.getRequest(
      endpoint: ApiRoutes.userTypes,
    );

    var body = response.data;
    if(body['success'] == false){
      throw ServerException(message: body['message']?? '');
    }

    print(response.data);

    return body['data'] ?? [];
  }

}