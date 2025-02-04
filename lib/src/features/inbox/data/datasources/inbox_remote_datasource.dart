import 'package:aider_mobile_app/core/constants/firestore_collections.dart';
import 'package:aider_mobile_app/core/services/http_service_requester.dart';
import 'package:aider_mobile_app/src/features/inbox/domain/models/message/message_model.dart';
import 'package:aider_mobile_app/src/features/rentals/domain/models/booking/booking_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../core/errors/error.dart';
import '../../../../../core/services/logger_service.dart';

abstract class InboxRemoteDatasource {
  Future<void> approveBookingRequest(
      {required BookingModel booking, required BookingProgressStatus status});
  Stream<List<MessageModel>> fetchMessagesStream(String bookingUid);

  Future<void> sendNudge({
    required BookingModel booking,
  });
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
  late final messageCollection = firestore.collection(kMessagesCollection);

  @override
  Future<void> approveBookingRequest(
      {required BookingModel booking,
      required BookingProgressStatus status}) async {
    final currentUser = firebaseAuth.currentUser!;

    if (booking.vendorUid != currentUser.uid) {
      throw const ServerException(
          message: "you don't have permission to approve this booking");
    }

    return bookingCollection
        .doc(booking.uid)
        .update({'bookingAcceptanceStatus': status.name});
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
}
