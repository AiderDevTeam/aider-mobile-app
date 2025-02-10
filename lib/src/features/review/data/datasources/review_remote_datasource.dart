import 'package:aider_mobile_app/core/constants/firestore_collections.dart';
import 'package:aider_mobile_app/core/services/logger_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../core/errors/error.dart';
import '../../../../../core/services/api_routes.dart';
import '../../../../../core/services/http_service_requester.dart';
import '../../../product/domain/models/history/product_history_model.dart';
import '../../domain/review/review_history_model.dart';

abstract class ReviewRemoteDataSource {
  Future<ProductHistoryModel> fetchVendorProductsAndReviews(
      {String? userExternalId,
      String? nextPage,
      required Map<String, dynamic> queryParam});
  Future<ReviewHistoryModel> fetchRenterReviews(
      {String? userExternalId,
      String? nextPage,
      required Map<String, dynamic> queryParam});
  Future<ReviewHistoryModel> fetchVendorReviews(
      {String? userExternalId,
      String? nextPage,
      required Map<String, dynamic> queryParam});
}

class ReviewRemoteDataSourceImpl extends ReviewRemoteDataSource {
  ReviewRemoteDataSourceImpl({required this.firestore});

  final FirebaseFirestore firestore;
  @override
  Future<ProductHistoryModel> fetchVendorProductsAndReviews(
      {String? userExternalId,
      String? nextPage,
      required Map<String, dynamic> queryParam}) async {
    // ZLoggerService.logOnDebug(
    //     'fetchVendorProductsAndReviews: $userExternalId, $nextPage, $queryParam');
    // final response = await firestore
    //     .collection(kReviewsCollection)
    //     .where('userUid', isEqualTo: userExternalId)
    //     .get();

    // var body = response.data;
    // if (body['success'] == false) {
    //   throw ServerException(message: body['message'] ?? '');
    // }

    return ProductHistoryModel.fromJson({
      'data': [],
      'meta': null,
    });
  }

  @override
  Future<ReviewHistoryModel> fetchRenterReviews(
      {String? userExternalId,
      String? nextPage,
      required Map<String, dynamic> queryParam}) async {
    final response = await firestore
        .collection(kReviewsCollection)
        .where('userUid', isEqualTo: userExternalId)
        .get();

    var body = response.docs.map((e) => e.data()).toList();
    return ReviewHistoryModel.fromJson({
      'data': body,
      'meta': null,
    });
  }

  @override
  Future<ReviewHistoryModel> fetchVendorReviews(
      {String? userExternalId,
      String? nextPage,
      required Map<String, dynamic> queryParam}) async {
    final response = await firestore
        .collection(kReviewsCollection)
        .where('userUid', isEqualTo: userExternalId)
        .get();

    var body = response.docs.map((e) => e.data()).toList();

    return ReviewHistoryModel.fromJson({
      'data': body,
      'meta': null,
    });
  }
}
