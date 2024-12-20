import 'package:aider_mobile_app/core/services/http_service_requester.dart';
import 'package:dio/dio.dart';
import '../../../../../core/errors/error.dart';
import '../../../../../core/services/api_routes.dart';
import '../../domain/models/history/product_history_model.dart';
import '../../domain/models/product/product_model.dart';

abstract class ProductRemoteDatasource{
  Future<ProductModel> listProduct({required Map<String, dynamic> requestBody});
  Future<ProductHistoryModel> fetchUserProducts({String? nextPage, required Map<String, dynamic> queryParam});
  Future<bool> requestForItem(String productExternalId, {required Map<String, dynamic> requestBody});
  Future<bool> deleteProductPhoto({required String productExternalId, required Map<String, dynamic> requestBody});
  Future<bool> addProductPhoto({required String productExternalId, required Map<String, dynamic> requestBody});
  Future<bool> deleteProduct({required String productExternalId});
  Future<ProductModel> updateProduct({required String productExternalId, required Map<String, dynamic> requestBody});
  Future<bool> deleteProductPrice({required String productExternalId, required Map<String, dynamic> requestBody});
  Future<ProductHistoryModel> fetchVendorProducts({String? vendorExternalId, String? nextPage, required Map<String, dynamic> queryParam});
}

class ProductRemoteDatasourceImpl extends ProductRemoteDatasource{
  ProductRemoteDatasourceImpl({required this.httpServiceRequester,});

  final HttpServiceRequester httpServiceRequester;

  @override
  Future<ProductModel> listProduct({required Map<String, dynamic> requestBody}) async{
    final response = await httpServiceRequester.postFormDataRequest(
      endpoint: ApiRoutes.listProduct,
      requestBody: FormData.fromMap(requestBody),
    );

    var body = response.data;
    if(body['success'] == false){
      throw ServerException(message: body['message']?? '');
    }

    return ProductModel.fromJson(response.data['data']?? {});
  }

  @override
  Future<ProductHistoryModel> fetchUserProducts({String? nextPage, required Map<String, dynamic> queryParam}) async{
    final response = await httpServiceRequester.getRequest(
      endpoint: nextPage?? ApiRoutes.getProducts,
      queryParam: queryParam
    );

    var body = response.data;
    if(body['success'] == false){
      throw ServerException(message: body['message']?? '');
    }

    return ProductHistoryModel.fromJson({
      'data': body['data']?? [],
      'meta': body['meta'],
    });
  }

  @override
  Future<bool> requestForItem(String productExternalId, {required Map<String, dynamic> requestBody}) async{
    final response = await httpServiceRequester.postRequest(
      endpoint: ApiRoutes.requestForItem(productExternalId),
      requestBody: requestBody,
    );

    var body = response.data;
    if(body['success'] == false){
      throw ServerException(message: body['message']?? '');
    }

    return true;
  }

  @override
  Future<bool> deleteProductPhoto({required String productExternalId, required Map<String, dynamic> requestBody}) async{
    await httpServiceRequester.deleteRequest(
      endpoint: ApiRoutes.deleteProductPhoto(productExternalId),
      requestBody: requestBody,
    );

    return true;
  }

  @override
  Future<bool> addProductPhoto({required String productExternalId, required Map<String, dynamic> requestBody}) async{
    await httpServiceRequester.postFormDataRequest(
      endpoint: ApiRoutes.addProductPhoto(productExternalId),
      requestBody: FormData.fromMap(requestBody),
    );

    return true;
  }

  @override
  Future<bool> deleteProduct({required String productExternalId}) async{
    await httpServiceRequester.deleteRequest(
      endpoint: ApiRoutes.deleteProduct(productExternalId),
    );

    return true;
  }

  @override
  Future<ProductModel> updateProduct({required String productExternalId, required Map<String, dynamic> requestBody}) async{
    final response = await httpServiceRequester.putRequest(
      endpoint: ApiRoutes.updateProduct(productExternalId),
      requestBody: requestBody,
    );

    var body = response.data;
    if(body['success'] == false){
      throw ServerException(message: body['message']?? '');
    }

    return ProductModel.fromJson(response.data['data']?? {});
  }

  @override
  Future<bool> deleteProductPrice({required String productExternalId, required Map<String, dynamic> requestBody}) async{
    await httpServiceRequester.deleteRequest(
      endpoint: ApiRoutes.deleteProductPrice(productExternalId),
      requestBody: requestBody,
    );

    return true;
  }

  @override
  Future<ProductHistoryModel> fetchVendorProducts({String? vendorExternalId, String? nextPage, required Map<String, dynamic> queryParam}) async{
    final response = await httpServiceRequester.getRequest(
      endpoint: nextPage?? ApiRoutes.getVendorProducts(vendorExternalId),
      queryParam: queryParam
    );

    var body = response.data;
    if(body['success'] == false){
      throw ServerException(message: body['message']?? '');
    }

    return ProductHistoryModel.fromJson({
      'data': body['data']?? [],
      'meta': body['meta'],
    });
  }

}
