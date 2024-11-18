import '../../../../../core/errors/error.dart';
import '../../../../../core/services/api_routes.dart';
import '../../../../../core/services/http_service_requester.dart';
import '../../../review/domain/review/review_model.dart';
import '../../domain/models/booked_history_model.dart';
import '../../domain/models/booking/booking_model.dart';

abstract class RentalRemoteDataSource {
  Future<BookedProductHistoryModel> fetchRentedItems({String? nextPage, required Map<String, dynamic> queryParam});
  Future<BookedProductHistoryModel> fetchMyItems({String? nextPage, required Map<String, dynamic> queryParam});
  Future<BookingModel> confirmPickUp({required String bookingExternalId, required Map<String, dynamic> requestBody});
  Future<BookingModel> confirmDropOff({required String bookingExternalId, required Map<String, dynamic> requestBody});
  Future<ReviewModel> createProductReviews({required String bookingExternalId, required Map<String, dynamic> requestBody});
  Future<BookingModel> earlyReturn({required String bookedProductExternalId});
  Future<void> reportBookingWith({required String externalId, required int bookingId, required String andReason});
}

class RentalRemoteDataSourceImpl extends RentalRemoteDataSource {
  RentalRemoteDataSourceImpl({
    required this.httpServiceRequester,
  });

  final HttpServiceRequester httpServiceRequester;

  @override
  Future<BookedProductHistoryModel> fetchRentedItems({String? nextPage, required Map<String, dynamic> queryParam}) async {
    final response = await httpServiceRequester.getRequest(
      endpoint: nextPage ?? ApiRoutes.getBookings,
      queryParam: queryParam,
    );

    var body = response.data;
    if (body['success'] == false) {
      throw ServerException(message: body['message'] ?? '');
    }

    return BookedProductHistoryModel.fromJson({
      'data': body['data'] ?? [],
      'meta': body['meta'],
    });
  }

  @override
  Future<BookedProductHistoryModel> fetchMyItems({String? nextPage, required Map<String, dynamic> queryParam}) async {
    final response = await httpServiceRequester.getRequest(
      endpoint: nextPage ?? ApiRoutes.getBookings,
      queryParam: queryParam,
    );

    var body = response.data;
    if (body['success'] == false) {
      throw ServerException(message: body['message'] ?? '');
    }

    return BookedProductHistoryModel.fromJson({
      'data': body['data'] ?? [],
      'meta': body['meta'],
    });
  }

  @override
  Future<BookingModel> confirmPickUp({required String bookingExternalId, required Map<String, dynamic> requestBody}) async {
    final response = await httpServiceRequester.postRequest(
      endpoint: ApiRoutes.confirmPickUp(bookingExternalId),
      requestBody: requestBody,
    );

    var body = response.data;
    if (body['success'] == false) {
      throw ServerException(message: body['message'] ?? '');
    }

    return BookingModel.fromJson(body['data']);
  }

  @override
  Future<BookingModel> confirmDropOff({required String bookingExternalId, required Map<String, dynamic> requestBody}) async {
    final response = await httpServiceRequester.postRequest(
      endpoint: ApiRoutes.confirmDropOff(bookingExternalId),
      requestBody: requestBody,
    );

    var body = response.data;
    if (body['success'] == false) {
      throw ServerException(message: body['message'] ?? '');
    }

    return BookingModel.fromJson(body['data']);
  }

  @override
  Future<ReviewModel> createProductReviews({required String bookingExternalId, required Map<String, dynamic> requestBody}) async {
    final response = await httpServiceRequester.postRequest(
      endpoint: ApiRoutes.createReviews(bookingExternalId),
      requestBody: requestBody,
    );
    var body = response.data;
    if (body['success'] != null && !body['success']) {
      throw ServerException(message: body['message'] ?? '');
    }

    return ReviewModel.fromJson(body['data']);
  }

  @override
  Future<BookingModel> earlyReturn({required String bookedProductExternalId}) async {
    final response = await httpServiceRequester.putRequest(
      endpoint: ApiRoutes.earlyReturn(bookedProductExternalId),
    );
    var body = response.data;
    if (body['success'] != null && !body['success']) {
      throw ServerException(message: body['message'] ?? '');
    }

    return BookingModel.fromJson(body['data']);
  }

  @override
  Future<void> reportBookingWith({required String externalId, required int bookingId, required String andReason}) async {
    final response = await httpServiceRequester.postRequest(endpoint: ApiRoutes.reportBookingWith(externalId), requestBody: {
      "bookingId": bookingId,
      "reason": andReason,
    });

    var body = response.data;
    if (body['success'] != null && !body['success']) {
      throw ServerException(message: body['message'] ?? '');
    }
  }
}
