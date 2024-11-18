import 'package:aider_mobile_app/core/services/http_service_requester.dart';
import '../../../../../core/errors/error.dart';
import '../../../../../core/services/api_routes.dart';
import '../../../product/domain/models/category/category_model.dart';
import '../../../product/domain/models/product/product_model.dart';

abstract class ExploreRemoteDatasource{
  Future<List> fetchSections({required Map<String, dynamic> queryParams});
  Future<List<CategoryModel>> fetchCategories({required String sectionExternalId, required Map<String, dynamic> queryParams});
  Future<List<ProductModel>> fetchProducts({required String sectionExternalId, required Map<String, dynamic> queryParams});
  Future<List<ProductModel>> fetchProductsByCategory({required String categoryExternalId, required Map<String, dynamic> queryParams});
  Future<List<ProductModel>> fetchFilteredProducts({required Map<String, dynamic> requestBody, required Map<String, dynamic> queryParams});

}

class ExploreRemoteDatasourceImpl extends ExploreRemoteDatasource{
  ExploreRemoteDatasourceImpl({required this.httpServiceRequester,});

  final HttpServiceRequester httpServiceRequester;

  @override
  Future<List> fetchSections({required Map<String, dynamic> queryParams}) async{
    final response = await httpServiceRequester.getRequest(
      endpoint: ApiRoutes.exploreSection,
      queryParam: queryParams,
    );
    var body = response.data;
    if(body['success'] != null && !body['success']){
      throw ServerException(message: body['message']?? '');
    }

    return body['data'];
  }

  @override
  Future<List<CategoryModel>> fetchCategories({required String sectionExternalId, required Map<String, dynamic> queryParams}) async{
    final response = await httpServiceRequester.getRequest(
      endpoint: ApiRoutes.seeAllSection(sectionExternalId),
      queryParam: queryParams,
    );
    var body = response.data;
    if(body['success'] != null && !body['success']){
      throw ServerException(message: body['message']?? '');
    }

    return CategoryList.fromJson(body['data']['data']).list;
  }

  @override
  Future<List<ProductModel>> fetchProducts({required String sectionExternalId, required Map<String, dynamic> queryParams}) async{
    final response = await httpServiceRequester.getRequest(
      endpoint: ApiRoutes.seeAllSection(sectionExternalId),
      queryParam: queryParams,
    );
    var body = response.data;
    if(body['success'] != null && !body['success']){
      throw ServerException(message: body['message']?? '');
    }

    return ProductList.fromJson(body['data']['data']).list;
  }

  @override
  Future<List<ProductModel>> fetchProductsByCategory({required String categoryExternalId, required Map<String, dynamic> queryParams}) async{
    final response = await httpServiceRequester.getRequest(
        endpoint: ApiRoutes.getProductsByCategory(categoryExternalId),
        queryParam: queryParams
    );
    var body = response.data;
    if(body['success'] != null && !body['success']){
      throw ServerException(message: body['message']?? '');
    }

    return ProductList.fromJson(body['data']).list;
  }

  @override
  Future<List<ProductModel>> fetchFilteredProducts({required Map<String, dynamic> requestBody, required Map<String, dynamic> queryParams}) async{
    final response = await httpServiceRequester.postRequest(
        endpoint: ApiRoutes.filter,
        queryParam: queryParams,
        requestBody: requestBody
    );

    var body = response.data;
    if(body['success'] == false){
      throw ServerException(message: body['message']?? '');
    }

    return ProductList.fromJson(body['data']).list;
  }
}
