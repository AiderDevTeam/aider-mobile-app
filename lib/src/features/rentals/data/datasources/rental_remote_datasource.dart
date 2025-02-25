import 'package:aider_mobile_app/core/constants/firestore_collections.dart';
import 'package:aider_mobile_app/src/features/rentals/domain/models/booked_product/booked_product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../core/services/crash_service.dart';
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
  Stream<BookingModel> fetchBookingStream({required String bookingUid});
  Future<void> confirmPickUp(
      {required String bookingUid, required String type});
  Future<void> confirmDropOff(
      {required String bookingUid, required String type});
  Future<ReviewModel> createProductReviews(
      {required String bookingUid, required Map<String, dynamic> requestBody});
  Future<void> earlyReturn(
      {required String bookingUid, required BookedProductModel bookedProduct});
  Future<void> reportBookingWith(
      {required String externalId,
      required int bookingId,
      required String andReason});
  Future<void> clearHasUnreadMessages({required BookingModel booking});
  Future<void> setCurrentBooking({required BookingModel booking});
  Future<void> clearCurrentBooking();
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
    ZLoggerService.logOnInfo('fetchItems is completed: $isCompleted');

    QuerySnapshot<Map<String, dynamic>> response;
    if (isCompleted) {
      response = await firebaseFirestore
          .collection(kBookingCollection)
          .orderBy('createdAt', descending: true)
          .where(userTypeUid, isEqualTo: firebaseAuth.currentUser!.uid)
          .where('collectionStatus',
              isEqualTo: BookingProgressStatus.success.name)
          .get();
    } else {
      response = await firebaseFirestore
          .collection(kBookingCollection)
          .orderBy('createdAt', descending: true)
          .where(userTypeUid, isEqualTo: firebaseAuth.currentUser!.uid)
          .get();
    }
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
        .where('status', isEqualTo: 'active')
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
    if (type == 'user') {
      await handleUserDropOff(bookingUid: bookingUid, returnedEarly: false);
    } else {
      await handleVendorDropOff(bookingUid: bookingUid);
    }
  }

  Future<void> triggerPayout({required String bookingUid}) async {
    try {
      final baseUrl = RemoteConfigService.getRemoteData.configs['env']
          ['paymentBaseUrl'] as String;

      final token = await firebaseAuth.currentUser!.getIdToken();

      await httpServiceRequester.postRequest(
        endpoint: '$baseUrl/payout',
        requestBody: {'bookingUid': bookingUid},
        token: token,
      );
    } catch (e) {
      ZLoggerService.logOnError('Error triggering payout: $e');
      CrashService.setCrashKey(
          'payout', 'Error triggering payout: $e, bookingUid: $bookingUid');
    }
  }

  @override
  Future<ReviewModel> createProductReviews(
      {required String bookingUid,
      required Map<String, dynamic> requestBody}) async {
    final reviewCollection = firebaseFirestore.collection(kReviewsCollection);
    await firebaseFirestore.runTransaction((Transaction tx) async {
      final reviewDoc = reviewCollection.doc();
      requestBody['uid'] = reviewDoc.id;
      requestBody['bookingUid'] = bookingUid;
      tx.set(reviewDoc, requestBody);
    });

    final averageRatingQuery = await reviewCollection
        .where('productUid', isEqualTo: requestBody['productUid'])
        .aggregate(average('rating'))
        .get();

    final averageRating = averageRatingQuery.getAverage('rating');
    ZLoggerService.logOnInfo('averageRating: $averageRating');
    if (averageRating != null) {
      ZLoggerService.logOnInfo('averageRating: ${requestBody['productUid']}');
      final productRef = firebaseFirestore
          .collection(kProductsCollection)
          .doc(requestBody['productUid']);
      await productRef.update({'rating': averageRating});
    }

    return ReviewModel.fromJson(requestBody);
  }

  @override
  Future<void> earlyReturn(
      {required String bookingUid,
      required BookedProductModel bookedProduct}) async {
    await handleUserDropOff(bookingUid: bookingUid, returnedEarly: true);
  }

  Future<void> handleUserDropOff(
      {required String bookingUid, required bool returnedEarly}) async {
    await firebaseFirestore.runTransaction((trx) async {
      final bookingRef =
          firebaseFirestore.collection(kBookingCollection).doc(bookingUid);

      final bookingDoc = await bookingRef.get();
      final bookingData = BookingModel.fromJson(bookingDoc.data()!);

      if (bookingData.userDropOffStatus == BookingProgressStatus.success) {
        return;
      }

      trx.update(bookingRef, {
        'userDropOffStatus': 'success',
        'bookedProduct': bookingData.bookedProduct!
            .copyWith(returnedEarly: returnedEarly)
            .toJson()
      });

      final productRef = firebaseFirestore
          .collection(kProductsCollection)
          .doc(bookingData.productUid);
      trx.update(productRef, {
        'quantity':
            FieldValue.increment(-(bookingData.bookedProduct!.quantity!))
      });
    });
  }

  Future<void> handleVendorDropOff({required String bookingUid}) async {
    await firebaseFirestore
        .collection(kBookingCollection)
        .doc(bookingUid)
        .update({'vendorDropOffStatus': 'success'});

    await triggerPayout(bookingUid: bookingUid);
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
  Stream<BookingModel> fetchBookingStream({required String bookingUid}) {
    return firebaseFirestore
        .collection(kBookingCollection)
        .doc(bookingUid)
        .snapshots()
        .map((event) => BookingModel.fromJson(event.data() ?? {}));
  }

  @override
  Future<void> clearHasUnreadMessages({
    required BookingModel booking,
  }) async {
    final userUid = firebaseAuth.currentUser!.uid;
    final unreadRef = firebaseFirestore.collection(kBookingUnreadCollection);

    await firebaseFirestore.runTransaction((trx) async {
      final bookingRef = firebaseFirestore.collection(kBookingCollection);
      trx.update(
          bookingRef.doc(booking.uid),
          userUid == booking.vendorUid
              ? {'vendorHasUnread': false}
              : {'userHasUnread': false});

      ZLoggerService.logOnInfo("booking UID ${booking.uid}");
      final unreadBookings = await unreadRef
          .where('bookingUid', isEqualTo: booking.uid!)
          .where('userUid', isEqualTo: userUid)
          .get();

      if (unreadBookings.docs.isEmpty) {
        ZLoggerService.logOnInfo('No unread messages found for user: $userUid');
        return;
      }

      ZLoggerService.logOnInfo('Found unread messages for user: $userUid');
      final batch = firebaseFirestore.batch();
      for (var unreadDoc in unreadBookings.docs) {
        batch.delete(unreadRef.doc(unreadDoc.id));
      }
      await batch.commit();
    });
  }

  @override
  Future<void> clearCurrentBooking() async {
    await firebaseFirestore.runTransaction((trx) async {
      ZLoggerService.logOnInfo(
          "clearCurrentBooking: ${firebaseAuth.currentUser!.uid}");

      final usersCollection = firebaseFirestore.collection(kUsersCollection);
      final userUid = firebaseAuth.currentUser!.uid;
      trx.update(usersCollection.doc(userUid), {'currentBooking': ''});
    });
  }

  @override
  Future<void> setCurrentBooking({required BookingModel booking}) async {
    await firebaseFirestore.runTransaction((trx) async {
      final userUid = firebaseAuth.currentUser!.uid;

      ZLoggerService.logOnInfo(
          "setCurrentBooking: ${firebaseAuth.currentUser!.uid}, bookingUid: ${booking.uid}");
      final usersCollection = firebaseFirestore.collection(kUsersCollection);
      trx.update(usersCollection.doc(userUid), {'currentBooking': booking.uid});
    });

    await clearHasUnreadMessages(booking: booking);
  }
}
