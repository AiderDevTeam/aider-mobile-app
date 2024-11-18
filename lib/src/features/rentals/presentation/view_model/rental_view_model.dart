import 'dart:collection';

import 'package:aider_mobile_app/src/features/rentals/domain/models/booking/booking_model.dart';
import 'package:aider_mobile_app/src/shared_widgets/modals/success_modal_content.dart';
import 'package:flutter/material.dart';

import '../../../../../core/domain/models/pagination/pagination_model.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/routing/app_navigator.dart';
import '../../../../../core/services/git_it_service_locator.dart';
import '../../../../../core/utils/app_dialog_util.dart';
import '../../../../../core/view_models/base_view_model.dart';
import '../../../../shared_widgets/modals/error_modal_content.dart';
import '../../domain/models/booked_history_model.dart';
import '../../data/repositories/rental_repository.dart';

class RentalViewModel extends BaseViewModel {
  final _rentalRepository = sl.get<RentalRepository>();
  BookedProductHistoryModel _rentedProductHistory = const BookedProductHistoryModel();
  BookedProductHistoryModel _myItemsProductHistory = const BookedProductHistoryModel();

  UnmodifiableListView<BookingModel> get getRentalProducts => UnmodifiableListView(_rentedProductHistory.data);
  PaginationModel? get getRentalProductMeta => _rentedProductHistory.meta;

  Future<void> fetchRentedItems(BuildContext context,
      {required Map<String, dynamic> queryParams, String loadingComponent = 'fetchRentedItems', String? nextPage}) async {
    setComponentErrorType = null;
    setLoading(true, component: loadingComponent);

    final result = await _rentalRepository.fetchRentedItems(queryParam: queryParams, nextPage: nextPage);

    result.fold((left) {
      setComponentErrorType = {'error': FailureToMessage.mapFailureToMessage(left), 'component': loadingComponent};
      setLoading(false, component: loadingComponent);
    }, (history) {
      setRentedItemsHistory(history, (history.meta?.currentPage ?? 0) > 1);
      setLoading(
        false,
        component: loadingComponent,
      );
      if (history.meta?.currentPage == 1) _persistRentedItemsHistory();
    });
  }

  void setRentedItemsHistory(BookedProductHistoryModel history, [bool append = false]) {
    if (append) {
      _rentedProductHistory = _rentedProductHistory.copyWith(
        data: List.from(_rentedProductHistory.data)..addAll(history.data),
        meta: history.meta,
      );
    } else {
      _rentedProductHistory = history;
    }
  }

  UnmodifiableListView<BookingModel> get getMyItemsProducts => UnmodifiableListView(_myItemsProductHistory.data);
  PaginationModel? get getMyItemsProductMeta => _myItemsProductHistory.meta;

  Future<void> fetchMyItems(BuildContext context,
      {required Map<String, dynamic> queryParams, String loadingComponent = 'fetchMyItems', String? nextPage}) async {
    setComponentErrorType = null;
    setLoading(true, component: loadingComponent);

    final result = await _rentalRepository.fetchMyItems(queryParam: queryParams, nextPage: nextPage);

    result.fold((left) {
      setComponentErrorType = {'error': FailureToMessage.mapFailureToMessage(left), 'component': loadingComponent};
      setLoading(false, component: loadingComponent);
    }, (history) {
      setMyItemsHistory(history, (history.meta?.currentPage ?? 0) > 1);
      setLoading(
        false,
        component: loadingComponent,
      );
      if (history.meta?.currentPage == 1) _persistMyItemsHistory();
    });
  }

  void setMyItemsHistory(BookedProductHistoryModel history, [bool append = false]) {
    if (append) {
      _myItemsProductHistory = _myItemsProductHistory.copyWith(
        data: List.from(_myItemsProductHistory.data)..addAll(history.data),
        meta: history.meta,
      );
    } else {
      _myItemsProductHistory = history;
    }
  }

  Future<void> confirmPickUp(
    BuildContext context, {
    String type = 'user',
    required String bookingExternalId,
    required Map<String, dynamic> requestBody,
    required GlobalKey<ScaffoldState> scaffoldKey,
  }) async {
    AppDialogUtil.loadingDialog(context);

    final result = await _rentalRepository.confirmPickUp(bookingExternalId: bookingExternalId, requestBody: requestBody);
    if (context.mounted) {
      AppNavigator.pop(context);
    }

    result.fold((left) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        AppDialogUtil.popUpModal(
          context,
          modalContent: ErrorModalContent(
            errorMessage: FailureToMessage.mapFailureToMessage(left),
          ),
        );
      });
    }, (right) {
      if (type == 'user') {
        final index = _rentedProductHistory.data.indexWhere((obj) => obj.externalId == bookingExternalId);
        if (index >= 0) {
          final userBooking = _rentedProductHistory.data[index].copyWith(
            id: right.id,
            externalId: right.externalId,
            status: right.status,
            collectionAmount: right.collectionAmount,
            collectionStatus: right.collectionStatus,
            disbursementAmount: right.disbursementAmount,
            disbursementStatus: right.disbursementStatus,
            reversalStatus: right.reversalStatus,
            bookingAcceptanceStatus: right.bookingAcceptanceStatus,
            vendorPickupStatus: right.vendorPickupStatus,
            userPickupStatus: right.userPickupStatus,
            vendorDropOffStatus: right.vendorDropOffStatus,
            userDropOffStatus: right.userDropOffStatus,
            bookingNumber: right.bookingNumber,
          );

          List<BookingModel> bookings = List.from(_rentedProductHistory.data);
          bookings[index] = userBooking;
          final history = _rentedProductHistory.copyWith(
            data: bookings,
          );

          _rentedProductHistory = history;
          notifyListeners();
        }
      } else {
        final index = _myItemsProductHistory.data.indexWhere((obj) => obj.externalId == bookingExternalId);
        if (index >= 0) {
          final userBooking = _myItemsProductHistory.data[index].copyWith(
            id: right.id,
            externalId: right.externalId,
            status: right.status,
            collectionAmount: right.collectionAmount,
            collectionStatus: right.collectionStatus,
            disbursementAmount: right.disbursementAmount,
            disbursementStatus: right.disbursementStatus,
            reversalStatus: right.reversalStatus,
            bookingAcceptanceStatus: right.bookingAcceptanceStatus,
            vendorPickupStatus: right.vendorPickupStatus,
            userPickupStatus: right.userPickupStatus,
            vendorDropOffStatus: right.vendorDropOffStatus,
            userDropOffStatus: right.userDropOffStatus,
            bookingNumber: right.bookingNumber,
          );

          List<BookingModel> bookings = List.from(_myItemsProductHistory.data);
          bookings[index] = userBooking;
          final history = _myItemsProductHistory.copyWith(
            data: bookings,
          );

          _myItemsProductHistory = history;
          notifyListeners();
        }
      }
      Navigator.of(context).pop();
    });
  }

  Future<void> confirmDropOff(
    BuildContext context, {
    String type = 'user',
    required String bookingExternalId,
    required Map<String, dynamic> requestBody,
    required GlobalKey<ScaffoldState> scaffoldKey,
  }) async {
    AppDialogUtil.loadingDialog(context);

    final result = await _rentalRepository.confirmDropOff(bookingExternalId: bookingExternalId, requestBody: requestBody);
    if (context.mounted) {
      AppNavigator.pop(context);
    }

    result.fold((left) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        AppDialogUtil.popUpModal(
          context,
          modalContent: ErrorModalContent(
            errorMessage: FailureToMessage.mapFailureToMessage(left),
          ),
        );
      });
    }, (right) {
      if (type == 'user') {
        final index = _rentedProductHistory.data.indexWhere((obj) => obj.externalId == bookingExternalId);
        if (index >= 0) {
          final userBooking = _rentedProductHistory.data[index].copyWith(
            id: right.id,
            externalId: right.externalId,
            status: right.status,
            collectionAmount: right.collectionAmount,
            collectionStatus: right.collectionStatus,
            disbursementAmount: right.disbursementAmount,
            disbursementStatus: right.disbursementStatus,
            reversalStatus: right.reversalStatus,
            bookingAcceptanceStatus: right.bookingAcceptanceStatus,
            vendorPickupStatus: right.vendorPickupStatus,
            userPickupStatus: right.userPickupStatus,
            vendorDropOffStatus: right.vendorDropOffStatus,
            userDropOffStatus: right.userDropOffStatus,
            bookingNumber: right.bookingNumber,
          );

          List<BookingModel> bookings = List.from(_rentedProductHistory.data);
          bookings[index] = userBooking;
          final history = _rentedProductHistory.copyWith(
            data: bookings,
          );

          _rentedProductHistory = history;
          notifyListeners();
        }
      } else {
        final index = _myItemsProductHistory.data.indexWhere((obj) => obj.externalId == bookingExternalId);
        if (index >= 0) {
          final userBooking = _myItemsProductHistory.data[index].copyWith(
            id: right.id,
            externalId: right.externalId,
            status: right.status,
            collectionAmount: right.collectionAmount,
            collectionStatus: right.collectionStatus,
            disbursementAmount: right.disbursementAmount,
            disbursementStatus: right.disbursementStatus,
            reversalStatus: right.reversalStatus,
            bookingAcceptanceStatus: right.bookingAcceptanceStatus,
            vendorPickupStatus: right.vendorPickupStatus,
            userPickupStatus: right.userPickupStatus,
            vendorDropOffStatus: right.vendorDropOffStatus,
            userDropOffStatus: right.userDropOffStatus,
            bookingNumber: right.bookingNumber,
          );

          List<BookingModel> bookings = List.from(_myItemsProductHistory.data);
          bookings[index] = userBooking;
          final history = _myItemsProductHistory.copyWith(
            data: bookings,
          );

          _myItemsProductHistory = history;
          notifyListeners();
        }
      }
      AppNavigator.pop(context);
    });
  }

  Future<void> createProductReviews(BuildContext context,
      {required String type, required String bookingProductExternalId, required Map<String, dynamic> requestBody}) async {
    AppDialogUtil.loadingDialog(context);

    final result = await _rentalRepository.createProductReviews(requestBody: requestBody, bookingExternalId: bookingProductExternalId);

    if (context.mounted) {
      AppNavigator.pop(context);
    }

    result.fold((left) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        AppDialogUtil.popUpModal(
          context,
          willPop: false,
          modalContent: ErrorModalContent(
            errorMessage: FailureToMessage.mapFailureToMessage(left),
            onButtonPressed: () {
              AppNavigator.of(context)
                ..pop()
                ..pop();
            },
          ),
        );
      });
    }, (right) {
      if (type == 'product') {
        final index = _rentedProductHistory.data.indexWhere((obj) => obj.bookedProduct?.externalId == bookingProductExternalId);
        if (index >= 0) {
          final hasUserReview = _rentedProductHistory.data[index].bookedProduct?.copyWith(
            isReviewed: true,
            review: right,
          );

          List<BookingModel> updatedData = List.from(_rentedProductHistory.data);
          updatedData[index] = _rentedProductHistory.data[index].copyWith(
            bookedProduct: hasUserReview, // Assign the updated BookedProductModel
          );

          final updatedHistory = _rentedProductHistory.copyWith(data: updatedData);
          _rentedProductHistory = updatedHistory;
          notifyListeners();
          AppNavigator.pop(context);
        }
      } else {
        final index = _myItemsProductHistory.data.indexWhere((obj) => obj.bookedProduct?.externalId == bookingProductExternalId);
        if (index >= 0) {
          final hasUserReview = _myItemsProductHistory.data[index].bookedProduct?.copyWith(
            isReviewed: true,
            review: right,
          );

          List<BookingModel> updatedData = List.from(_myItemsProductHistory.data);
          updatedData[index] = _myItemsProductHistory.data[index].copyWith(
            bookedProduct: hasUserReview, // Assign the updated BookedProductModel
          );

          final updatedHistory = _myItemsProductHistory.copyWith(data: updatedData);
          _myItemsProductHistory = updatedHistory;
          notifyListeners();
          AppNavigator.pop(context);
        }
      }
    });
  }

  Future<void> reportBooking({required BuildContext context, required String externalId, required int bookingId, required String andReason}) async {
    AppDialogUtil.loadingDialog(context);
    final result = await _rentalRepository.reportBookingWith(externalId: externalId, bookingId: bookingId, andReason: andReason);
    if (context.mounted) {
      AppNavigator.pop(context);
    }
    result.fold(
        (err) => AppDialogUtil.popUpModal(
              context,
              modalContent: ErrorModalContent(
                errorMessage: FailureToMessage.mapFailureToMessage(err),
                onButtonPressed: () {
                  // updateCart(context, requestBody['orderExternalId']?? '', cartExternalId);
                  AppNavigator.of(context)
                    ..pop()
                    ..pop();
                },
              ),
            ), (success) {
      AppDialogUtil.popUpModal(
        context,
        modalContent: SuccessModalContent(
          message: "Report has been made",
          onButtonPressed: () {
            Navigator.of(context)
              ..pop()
              ..pop();
          },
        ),
      );
    });
  }

  Future<void> earlyReturn(BuildContext context, {required String bookedProductExternalId}) async {
    AppDialogUtil.loadingDialog(context);

    final result = await _rentalRepository.earlyReturn(bookedProductExternalId: bookedProductExternalId);

    if (context.mounted) {
      AppNavigator.pop(context);
    }

    result.fold((left) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        AppDialogUtil.popUpModal(
          context,
          willPop: false,
          modalContent: ErrorModalContent(
            errorMessage: FailureToMessage.mapFailureToMessage(left),
            onButtonPressed: () {
              // updateCart(context, requestBody['orderExternalId']?? '', cartExternalId);
              AppNavigator.of(context)
                ..pop()
                ..pop();
            },
          ),
        );
      });
    }, (right) {
      final index = _rentedProductHistory.data.indexWhere((obj) => obj.bookedProduct?.externalId == bookedProductExternalId);
      if (index >= 0) {
        final bookedProduct = _rentedProductHistory.data[index].bookedProduct?.copyWith(
          id: right.bookedProduct?.id,
          externalId: right.bookedProduct?.externalId,
          amount: right.bookedProduct?.amount,
          quantity: right.bookedProduct?.quantity,
          value: right.bookedProduct?.value,
          startDate: right.bookedProduct?.startDate,
          endDate: right.bookedProduct?.endDate,
          duration: right.bookedProduct?.duration,
          daysSpan: right.bookedProduct?.daysSpan,
          isOverdue: right.bookedProduct?.isOverdue,
          returnedEarly: right.bookedProduct?.returnedEarly,
        );

        List<BookingModel> updatedData = List.from(_rentedProductHistory.data);
        updatedData[index] = _rentedProductHistory.data[index].copyWith(
          bookedProduct: bookedProduct,
        );

        _rentedProductHistory = _rentedProductHistory.copyWith(data: updatedData);
        notifyListeners();
      }
      AppNavigator.pop(context);
    });
  }

  /// LOCAL DB
  void _persistRentedItemsHistory() async {
    final _ = await _rentalRepository.persistRentedItemHistory(_rentedProductHistory);
  }

  void _persistMyItemsHistory() async {
    final _ = await _rentalRepository.persistMyItemHistory(_myItemsProductHistory);
  }

  // void _persistReviewHistory() async {
  //   final _ = await _rentalRepository.persistReviewHistory(_reviewModel);
  // }
}
