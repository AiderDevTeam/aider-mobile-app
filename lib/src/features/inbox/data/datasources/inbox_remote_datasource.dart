import 'package:aider_mobile_app/core/constants/firestore_collections.dart';
import 'package:aider_mobile_app/core/services/http_service_requester.dart';
import 'package:aider_mobile_app/src/features/inbox/domain/models/message/message_model.dart';
import 'package:aider_mobile_app/src/features/rentals/domain/models/booking/booking_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../core/errors/error.dart';
import '../../../../../core/services/logger_service.dart';
import '../../../../../core/services/remote_config_service.dart';

abstract class InboxRemoteDatasource {
  Future<void> approveBookingRequest(
      {required BookingModel booking, required BookingProgressStatus status});
  Stream<List<MessageModel>> fetchMessagesStream(String bookingUid);

  Future<void> sendNudge({
    required BookingModel booking,
  });

  Stream<int> getUnreadMessagesStream({String? bookingUid});

  Future<void> sendNotification(
      {required String message,
      required String title,
      required String bookingUid,
      required String senderUid,
      required String recipientUid});
}

class InboxRemoteDatasourceImpl extends InboxRemoteDatasource {
  InboxRemoteDatasourceImpl(
      {required this.httpServiceRequester,
      required this.firestore,
      required this.firebaseAuth});

  final HttpServiceRequester httpServiceRequester;
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;
  late final bookingCollection = firestore.collection(kBookingCollection);
  late final productCollection = firestore.collection(kProductsCollection);
  late final messageCollection = firestore.collection(kMessagesCollection);

  @override
  Future<void> approveBookingRequest(
      {required BookingModel booking,
      required BookingProgressStatus status}) async {
    final currentUser = firebaseAuth.currentUser!;

    if (booking.vendorUid != currentUser.uid &&
        status == BookingProgressStatus.accepted) {
      throw const ServerException(
          message: "you don't have permission to approve this booking");
    }

    if (booking.vendorUid != currentUser.uid &&
        booking.userUid != currentUser.uid) {
      throw const ServerException(message: "permission denied");
    }
    await firestore.runTransaction((trx) async {
      final bookingRef = bookingCollection.doc(booking.uid);
      final productRef = productCollection.doc(booking.productUid);

      final bookingDoc = await bookingRef.get();
      final bookingData = BookingModel.fromJson(bookingDoc.data()!);

      if (bookingData.bookingAcceptanceStatus == status) {
        throw ServerException(
            message: "booking already status already set: ${status.name}");
      }

      trx.update(bookingRef, {'bookingAcceptanceStatus': status.name});

      if (status == BookingProgressStatus.accepted) {
        trx.update(productRef, {
          'quantity':
              FieldValue.increment(-(bookingData.bookedProduct!.quantity!))
        });
      }
    });
  }

  @override
  Future<void> sendNudge({required BookingModel booking}) async {
    final docRef = messageCollection.doc();

    final messageModel = MessageModel(
        uid: docRef.id,
        message:
            "Hey! can you please look at my request and respond accordingly thanks.",
        type: "nudge",
        bookingUid: booking.uid,
        senderUid: booking.userUid,
        receiverUid: booking.vendorUid,
        sentAt: DateTime.now().toIso8601String());

    await messageCollection.doc(docRef.id).set(messageModel.toJson());
  }

  @override
  Stream<List<MessageModel>> fetchMessagesStream(String bookingUid) {
    ZLoggerService.logOnInfo('fetching messages for booking: $bookingUid');
    return firestore
        .collection(kMessagesCollection)
        .where('bookingUid', isEqualTo: bookingUid)
        .orderBy('sentAt', descending: true)
        .snapshots()
        .map((event) => event.docs
            .map((doc) => MessageModel.fromJson(doc.data()))
            .toList());
  }

  @override
  Stream<int> getUnreadMessagesStream({String? bookingUid}) {
    final userUid = firebaseAuth.currentUser!.uid;
    ZLoggerService.logOnInfo("User UID: $userUid");
    var query = firestore
        .collection(kBookingUnreadCollection)
        .where('userUid', isEqualTo: userUid);

    if (bookingUid != null) {
      query = query.where('bookingUid', isEqualTo: bookingUid);
    }

    final snapshots = query.snapshots().map((e) {
      ZLoggerService.logOnInfo("unread Data: ${e.docs.length}");
      return e.docs.length;
    });

    return snapshots;
  }

  @override
  Future<void> sendNotification(
      {required String message,
      required String title,
      required String bookingUid,
      required String senderUid,
      required String recipientUid}) async {
    final recipient =
        await firestore.collection(kUsersCollection).doc(recipientUid).get();

    if (!recipient.exists) {
      throw const ServerException(message: "recipient not found");
    }

    ZLoggerService.logOnInfo(
        "sending notification to: $recipientUid, current booking: ${recipient.data()?['currentBooking']}, recipient: ${recipient.id}");
    if (recipient.data()?['currentBooking'] == bookingUid) {
      return;
    }

    final baseUrl = RemoteConfigService.getRemoteData.configs['env']
        ['notificationBaseUrl'] as String;

    await httpServiceRequester
        .postRequest(endpoint: "$baseUrl/send-notification", requestBody: {
      'message': message,
      'title': title,
      'bookingUid': bookingUid,
      'senderUid': senderUid,
      'recipientUid': recipientUid,
    });
  }
}
