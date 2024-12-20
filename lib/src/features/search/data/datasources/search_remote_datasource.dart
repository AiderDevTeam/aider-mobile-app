import '../../../../../core/errors/error.dart';
import '../../../../../core/services/api_routes.dart';
import '../../../../../core/services/http_service_requester.dart';
import '../../../product/domain/models/history/product_history_model.dart';
import '../../domain/models/search/search_model.dart';

abstract class SearchRemoteDataSource{
  Future<SearchModel> searchAll({ required Map<String, dynamic> requestBody });
  Future<ProductHistoryModel> fetchFilteredProducts({required Map<String, dynamic> requestBody, required Map<String, dynamic> queryParam});
  Future<ProductHistoryModel>searchAllProducts({required Map<String, dynamic> requestBody, String? nextPage, required Map<String, dynamic> queryParam});

}

class SearchRemoteDataSourceImpl extends SearchRemoteDataSource {
  SearchRemoteDataSourceImpl({required this.httpServiceRequester,});

  final HttpServiceRequester httpServiceRequester;

  @override
  Future<SearchModel> searchAll({required Map<String, dynamic> requestBody}) async{
    final response = await httpServiceRequester.postRequest(
      endpoint: ApiRoutes.searchAll,
      requestBody: requestBody,
    );

    var body = response.data;
    if(body['success'] != null && !body['success']){
      throw ServerException(message: body['message']?? '');
    }
    return SearchModel.fromJson(body['data']?? {});

  }

  @override
  Future<ProductHistoryModel>  fetchFilteredProducts({required Map<String, dynamic> requestBody, required Map<String, dynamic> queryParam}) async{
    final response = await httpServiceRequester.postRequest(
        endpoint: ApiRoutes.filter,
        queryParam: queryParam,
        requestBody: requestBody
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
  Future<ProductHistoryModel>searchAllProducts({required Map<String, dynamic> requestBody, String? nextPage, required Map<String, dynamic> queryParam}) async{
    final response = await httpServiceRequester.postRequest(
      endpoint: nextPage?? ApiRoutes.searchProducts,
      queryParam: queryParam,
      requestBody: requestBody,
    );

    var body = response.data;
    if(body['success'] != null && !body['success']){
      throw ServerException(message: body['message']?? '');
    }

    return ProductHistoryModel.fromJson({
      'data': body['data']?? [],
      'meta': body['meta'],
    });

  }

}