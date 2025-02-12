import 'dart:collection';

import 'package:aider_mobile_app/src/features/review/domain/review/review_model.dart';
import 'package:flutter/material.dart';

import '../../../../../core/domain/models/pagination/pagination_model.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/services/git_it_service_locator.dart';
import '../../../../../core/providers/base_provider.dart';
import '../../../product/domain/models/history/product_history_model.dart';
import '../../../product/domain/models/product/product_model.dart';
import '../../data/repositories/review_repository.dart';
import '../../domain/review/review_history_model.dart';

class ReviewViewModel extends BaseProvider {
  final _reviewRepository = sl.get<ReviewRepository>();
  ProductHistoryModel _vendorProductAndReviewHistory = ProductHistoryModel();
  ReviewHistoryModel _renterReviewHistory = const ReviewHistoryModel();

  UnmodifiableListView<ProductModel> get getVendorProductsAndReviews =>
      UnmodifiableListView(_vendorProductAndReviewHistory.data);
  PaginationModel? get getVendorProductAndReviewsMeta =>
      _vendorProductAndReviewHistory.meta;

  void setVendorProductsAndReviewsHistory(ProductHistoryModel history,
      [bool append = false]) {
    if (append) {
      _vendorProductAndReviewHistory = _vendorProductAndReviewHistory.copyWith(
        data: List.from(_vendorProductAndReviewHistory.data)
          ..addAll(history.data),
        meta: history.meta,
      );
    } else {
      _vendorProductAndReviewHistory = history;
    }
  }

  Future<void> fetchVendorProductsAndReviews(BuildContext context,
      {String? userExternalId,
      required Map<String, dynamic> queryParam,
      String loadingComponent = 'fetchVendorProductsAndReview',
      String? nextPage}) async {
    setComponentErrorType = null;
    if (nextPage == null) {
      _vendorProductAndReviewHistory = ProductHistoryModel();
    }
    setLoading(true, component: loadingComponent);

    final result = await _reviewRepository.fetchVendorProductsAndReviews(
        userExternalId: userExternalId,
        nextPage: nextPage,
        queryParam: queryParam);

    result.fold((left) {
      setComponentErrorType = {
        'error': FailureToMessage.mapFailureToMessage(left),
        'component': loadingComponent
      };
      setLoading(false, component: loadingComponent);
    }, (history) {
      setVendorProductsAndReviewsHistory(
          history, (history.meta?.currentPage ?? 0) > 1);
      setLoading(
        false,
        component: loadingComponent,
      );
    });
  }

  UnmodifiableListView<ReviewModel> get getRenterReviews =>
      UnmodifiableListView(_renterReviewHistory.data);
  PaginationModel? get getRenterReviewsMeta => _renterReviewHistory.meta;

  void setRenterReviewsHistory(ReviewHistoryModel history,
      [bool append = false]) {
    if (append) {
      _renterReviewHistory = _renterReviewHistory.copyWith(
        data: List.from(_renterReviewHistory.data)..addAll(history.data),
        meta: history.meta,
      );
    } else {
      _renterReviewHistory = history;
    }
  }

  Future<void> fetchRenterReviews(BuildContext context,
      {String? userExternalId,
      required Map<String, dynamic> queryParam,
      String loadingComponent = 'fetchRenterReviews',
      String? nextPage}) async {
    setComponentErrorType = null;
    if (nextPage == null) {
      _renterReviewHistory = const ReviewHistoryModel();
    }
    setLoading(true, component: loadingComponent);

    final result = await _reviewRepository.fetchRenterReviews(
        userExternalId: userExternalId,
        nextPage: nextPage,
        queryParam: queryParam);

    result.fold((left) {
      setComponentErrorType = {
        'error': FailureToMessage.mapFailureToMessage(left),
        'component': loadingComponent
      };
      setLoading(false, component: loadingComponent);
    }, (history) {
      setRenterReviewsHistory(history, (history.meta?.currentPage ?? 0) > 1);
      setLoading(
        false,
        component: loadingComponent,
      );
    });
  }

  UnmodifiableListView<ReviewModel> get getVendorReviews =>
      UnmodifiableListView(_renterReviewHistory.data);
  PaginationModel? get getVendorReviewsMeta => _renterReviewHistory.meta;

  void setVendorReviewsHistory(ReviewHistoryModel history,
      [bool append = false]) {
    if (append) {
      _renterReviewHistory = _renterReviewHistory.copyWith(
        data: List.from(_renterReviewHistory.data)..addAll(history.data),
        meta: history.meta,
      );
    } else {
      _renterReviewHistory = history;
    }
  }

  Future<void> fetchVendorReviews(BuildContext context,
      {String? userExternalId,
      required Map<String, dynamic> queryParam,
      String loadingComponent = 'fetchVendorReviews',
      String? nextPage}) async {
    setComponentErrorType = null;
    if (nextPage == null) {
      _renterReviewHistory = const ReviewHistoryModel();
    }
    setLoading(true, component: loadingComponent);

    final result = await _reviewRepository.fetchVendorReviews(
        userExternalId: userExternalId,
        nextPage: nextPage,
        queryParam: queryParam);

    result.fold((left) {
      setComponentErrorType = {
        'error': FailureToMessage.mapFailureToMessage(left),
        'component': loadingComponent
      };
      setLoading(false, component: loadingComponent);
    }, (history) {
      setVendorReviewsHistory(history, (history.meta?.currentPage ?? 0) > 1);
      setLoading(
        false,
        component: loadingComponent,
      );
    });
  }
}
