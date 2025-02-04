import 'package:aider_mobile_app/core/constants/firestore_collections.dart';
import 'package:aider_mobile_app/src/features/rentals/domain/models/booked_product/booked_product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../core/services/http_service_requester.dart';
import '../../../../../core/services/logger_service.dart';
import '../../../../../core/services/remote_config_service.dart';
import '../../../review/domain/review/review_model.dart';
import '../../domain/models/booked_history_model.dart';
import '../../domain/models/booking/booking_model.dart';

abstract class RentalRemoteDataSource {
  Future<BookedProductHistoryModel> fetchRentedItems(
      {String? nextPage,
      required Map<String, dynamic> queryParam,
      bool isCompleted = false});
  Future<BookedProductHistoryModel> fetchMyItems(
      {String? nextPage,
      required Map<String, dynamic> queryParam,
      bool isCompleted = false});
  Stream<BookingModel> fetchBookingStream(String bookingExternalId);
  Future<void> confirmPickUp(
      {required String bookingUid, required String type});
  Future<void> confirmDropOff(
      {required String bookingUid, required String type});
  Future<ReviewModel> createProductReviews(
      {required String bookingExternalId,
      required Map<String, dynamic> requestBody});
  Future<void> earlyReturn(
      {required String bookingUid, required BookedProductModel bookedProduct});
  Future<void> reportBookingWith(
      {required String externalId,
      required int bookingId,
      required String andReason});
}

class RentalRemoteDataSourceImpl extends RentalRemoteDataSource {
  RentalRemoteDataSourceImpl({
    required this.firebaseFirestore,
    required this.firebaseAuth,
    required this.httpServiceRequester,
  });

  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;
  final HttpServiceRequester httpServiceRequester;
  late final CollectionReference bookingCollection;

  Future<BookedProductHistoryModel> fetchItems({
    String? nextPage,
    required String userTypeUid,
    required Map<String, dynamic> queryParam,
    bool isCompleted = false,
  }) async {
    final query = await firebaseFirestore
        .collection(kBookingCollection)
        .orderBy('createdAt', descending: true)
        .where(userTypeUid, isEqualTo: firebaseAuth.currentUser!.uid);

    if (isCompleted) {
      query.where('status', isEqualTo: 'completed');
    }

    final response = await query.get();
    // have a map  of productUid to list of booking index in list
    Map<String, List<int>> productUidToBookingIndexList = {};

    // have a map  of userId to UserModel to list of booking index in list
    Map<String, Map<String, dynamic>> userIdToUserModel = {};

    var bookingsResponse = response.docs;

    if (bookingsResponse.isEmpty) {
      return BookedProductHistoryModel.fromJson({
        'data': null,
        'meta': null,
      });
    }

    var bookings = [];

    for (var i = 0; i < bookingsResponse.length; i++) {
      var booking = bookingsResponse[i].data();
      if (productUidToBookingIndexList[booking['productUid']] == null) {
        productUidToBookingIndexList[booking['productUid']] = [];
      }
      productUidToBookingIndexList[booking['productUid']]!.add(i);
      bookings.add(booking);
    }

    final productIds = productUidToBookingIndexList.keys.toList();

    final products = await firebaseFirestore
        .collection(kProductsCollection)
        .where('uid', whereIn: productIds)
        .get();

    for (var product in products.docs) {
      for (var bookingIndex
          in productUidToBookingIndexList[product['uid']] ?? []) {
        bookings[bookingIndex]['bookedProduct']['product'] = product.data();
        bookings[bookingIndex]['user'] = await fetchUser(
            bookings[bookingIndex]['userUid'], userIdToUserModel);
        bookings[bookingIndex]['vendor'] = await fetchUser(
            bookings[bookingIndex]['vendorUid'], userIdToUserModel);
      }
    }

    ZLoggerService.logOnInfo('fetchRentedItems: $bookings');
    return BookedProductHistoryModel.fromJson({
      'data': bookings,
      'meta': {
        "nextPage": nextPage,
        "total": response.docs.length,
      },
    });
  }

  Future<Map<String, dynamic>> fetchUser(
      String userId, Map<String, Map<String, dynamic>> userMap) async {
    if (userMap[userId] != null) {
      return userMap[userId]!;
    }

    final user =
        await firebaseFirestore.collection(kUsersCollection).doc(userId).get();
    userMap[userId] = (user.data() ?? {});
    return userMap[userId]!;
  }

  @override
  Future<BookedProductHistoryModel> fetchRentedItems(
      {String? nextPage,
      required Map<String, dynamic> queryParam,
      bool isCompleted = false}) async {
    return fetchItems(
      nextPage: nextPage,
      userTypeUid: 'userUid',
      queryParam: queryParam,
      isCompleted: isCompleted,
    );
  }

  @override
  Future<BookedProductHistoryModel> fetchMyItems(
      {String? nextPage,
      required Map<String, dynamic> queryParam,
      bool isCompleted = false}) async {
    return fetchItems(
      nextPage: nextPage,
      userTypeUid: 'vendorUid',
      queryParam: queryParam,
      isCompleted: isCompleted,
    );
  }

  @override
  Future<void> confirmPickUp(
      {required String bookingUid, required String type}) async {
    Map<Object, Object?> requestBody = {};
    if (type == 'user') {
      requestBody['userPickupStatus'] = 'success';
    } else {
      requestBody['vendorPickupStatus'] = 'success';
    }
    await firebaseFirestore
        .collection(kBookingCollection)
        .doc(bookingUid)
        .update(requestBody);
  }

  @override
  Future<void> confirmDropOff(
      {required String bookingUid, required String type}) async {
    Map<Object, Object?> requestBody = {};
    if (type == 'user') {
      triggerPayout(bookingUid: bookingUid, type: type);
    } else {
      requestBody['vendorDropOffStatus'] = 'success';
    }

    await firebaseFirestore
        .collection(kBookingCollection)
        .doc(bookingUid)
        .update(requestBody);
  }

  Future<void> triggerPayout(
      {required String bookingUid, required String type}) async {
    final baseUrl = RemoteConfigService.getRemoteData.configs['env']
        ['paymentBaseUrl'] as String;

    final token = await firebaseAuth.currentUser!.getIdToken();

    await httpServiceRequester.postRequest(
      endpoint: '$baseUrl/payout',
      requestBody: {'bookingUid': bookingUid},
      token: token,
    );
  }

  @override
  Future<ReviewModel> createProductReviews(
      {required String bookingExternalId,
      required Map<String, dynamic> requestBody}) async {
    final docRef = firebaseFirestore.collection(kReviewsCollection).doc();

    requestBody['externalId'] = docRef.id;
    await docRef.set(requestBody);
    return ReviewModel.fromJson(requestBody);
  }

  @override
  Future<void> earlyReturn(
      {required String bookingUid,
      required BookedProductModel bookedProduct}) async {
    bookedProduct = bookedProduct.copyWith(returnedEarly: true);
    await firebaseFirestore
        .collection(kBookingCollection)
        .doc(bookingUid)
        .update({
      'userDropOffStatus': 'success',
      'bookedProduct': bookedProduct.customToJson()
    });

    await triggerPayout(bookingUid: bookingUid, type: 'vendor');
  }

  @override
  Future<void> reportBookingWith(
      {required String externalId,
      required int bookingId,
      required String andReason}) async {
    await firebaseFirestore
        .collection(kBookingCollection)
        .doc(externalId)
        .collection(kReportsCollection)
        .add({
      "bookingId": bookingId,
      "reason": andReason,
    });
  }

  @override
  Stream<BookingModel> fetchBookingStream(String bookingExternalId) {
    return firebaseFirestore
        .collection(kBookingCollection)
        .doc(bookingExternalId)
        .snapshots()
        .map((event) => BookingModel.fromJson(event.data() ?? {}));
  }
}
