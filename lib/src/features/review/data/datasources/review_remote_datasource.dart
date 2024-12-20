import '../../../../../core/errors/error.dart';
import '../../../../../core/services/api_routes.dart';
import '../../../../../core/services/http_service_requester.dart';
import '../../../product/domain/models/history/product_history_model.dart';
import '../../domain/review/review_history_model.dart';

abstract class ReviewRemoteDataSource{
  Future<ProductHistoryModel> fetchVendorProductsAndReviews({String? userExternalId, String? nextPage, required Map<String, dynamic> queryParam});
  Future<ReviewHistoryModel> fetchRenterReviews({String? userExternalId, String? nextPage, required Map<String, dynamic> queryParam});
  Future<ReviewHistoryModel> fetchVendorReviews({String? userExternalId, String? nextPage, required Map<String, dynamic> queryParam});
}

class ReviewRemoteDataSourceImpl extends ReviewRemoteDataSource {
  ReviewRemoteDataSourceImpl({required this.httpServiceRequester});

  final HttpServiceRequester httpServiceRequester;

  @override
  Future<ProductHistoryModel> fetchVendorProductsAndReviews({String? userExternalId, String? nextPage, required Map<String, dynamic> queryParam}) async{
    final response = await httpServiceRequester.getRequest(
        endpoint: nextPage?? ApiRoutes.getVendorProductsAndReviews(userExternalId),
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
  Future<ReviewHistoryModel> fetchRenterReviews({String? userExternalId, String? nextPage, required Map<String, dynamic> queryParam}) async{
    final response = await httpServiceRequester.getRequest(
        endpoint: nextPage?? ApiRoutes.getRenterReviews(userExternalId),
        queryParam: queryParam
    );

    var body = response.data;
    if(body['success'] == false){
      throw ServerException(message: body['message']?? '');
    }

    return ReviewHistoryModel.fromJson({
      'data': body['data']?? [],
      'meta': body['meta'],
    });
  }

  @override
  Future<ReviewHistoryModel> fetchVendorReviews({String? userExternalId, String? nextPage, required Map<String, dynamic> queryParam}) async{
    final response = await httpServiceRequester.getRequest(
        endpoint: nextPage?? ApiRoutes.getVendorReviews(userExternalId),
        queryParam: queryParam
    );

    var body = response.data;
    if(body['success'] == false){
      throw ServerException(message: body['message']?? '');
    }

    return ReviewHistoryModel.fromJson({
      'data': body['data']?? [],
      'meta': body['meta'],
    });
  }
}