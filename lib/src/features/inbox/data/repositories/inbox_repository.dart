import 'package:aider_mobile_app/core/services/logger_service.dart';
import 'package:aider_mobile_app/src/features/inbox/domain/models/message/message_model.dart';
import 'package:aider_mobile_app/src/features/rentals/domain/models/booking/booking_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/services/crash_service.dart';
import '../../domain/models/chat/chat_model.dart';
import '../datasources/inbox_local_datasource.dart';
import '../datasources/inbox_remote_datasource.dart';

abstract class InboxRepository {
  Future<Either<Failure, void>> approveBookingRequest(
      {required BookingModel booking, required BookingProgressStatus status});

  Future<Either<Failure, void>> sendNudge({
    required BookingModel booking,
  });
  Stream<List<MessageModel>> fetchMessagesStream(String bookingUid);
  Stream<int> getUnreadMessagesStream({String? bookingUid});
  Future<Either<Failure, void>> sendNotification(
      {required String message,
      required String title,
      required String bookingUid,
      required String senderUid,
      required String recipientUid});

  /// LOCAL DB
  Future<Either<Failure, bool>> persistSentChat(List<ChatModel> sentChats);
  Future<Either<Failure, List<ChatModel>>> retrieveSentChat();
  Future<Either<Failure, bool>> persistReceivedChat(
      List<ChatModel> receivedChats);
  Future<Either<Failure, List<ChatModel>>> retrieveReceivedChat();
}

class InboxRepositoryImpl extends InboxRepository {
  InboxRepositoryImpl({
    required this.inboxRemoteDatasource,
    required this.inboxLocalDatasource,
  });

  final InboxRemoteDatasource inboxRemoteDatasource;
  final InboxLocalDatasource inboxLocalDatasource;

  @override
  Future<Either<Failure, bool>> persistSentChat(
      List<ChatModel> sentChats) async {
    try {
      await inboxLocalDatasource.persistSentChat(sentChats);
      return const Right(true);
    } catch (e, s) {
      CrashService.setCrashKey('chat', 'persisting sent chats');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, List<ChatModel>>> retrieveSentChat() async {
    try {
      final response = await inboxLocalDatasource.retrieveSentChat();
      return Right(response);
    } catch (e, s) {
      CrashService.setCrashKey('chat', 'retrieving sent chats');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, bool>> persistReceivedChat(
      List<ChatModel> receivedChats) async {
    try {
      await inboxLocalDatasource.persistReceivedChat(receivedChats);
      return const Right(true);
    } catch (e, s) {
      CrashService.setCrashKey('chat', 'persisting received chats');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, List<ChatModel>>> retrieveReceivedChat() async {
    try {
      final response = await inboxLocalDatasource.retrieveReceivedChat();
      return Right(response);
    } catch (e, s) {
      CrashService.setCrashKey('chat', 'retrieving received chats');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, void>> approveBookingRequest(
      {required BookingModel booking,
      required BookingProgressStatus status}) async {
    try {
      final response = await inboxRemoteDatasource.approveBookingRequest(
          booking: booking, status: status);
      return Right(response);
    } catch (e, s) {
      CrashService.setCrashKey('booking', 'booking request approvals');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, void>> sendNudge(
      {required BookingModel booking}) async {
    try {
      final response = await inboxRemoteDatasource.sendNudge(booking: booking);
      return Right(response);
    } catch (e, s) {
      CrashService.setCrashKey('nudge', 'sending a nudge');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Stream<List<MessageModel>> fetchMessagesStream(String bookingUid) {
    try {
      final response = inboxRemoteDatasource.fetchMessagesStream(bookingUid);
      return response;
    } catch (e, s) {
      ZLoggerService.logOnError('error fetching messages: $e');
      CrashService.setCrashKey('chat', 'fetching messages');
      return Stream.error(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Stream<int> getUnreadMessagesStream({String? bookingUid}) {
    return inboxRemoteDatasource.getUnreadMessagesStream(
        bookingUid: bookingUid);
  }

  @override
  Future<Either<Failure, void>> sendNotification(
      {required String message,
      required String title,
      required String bookingUid,
      required String senderUid,
      required String recipientUid}) async {
    try {
      await inboxRemoteDatasource.sendNotification(
          message: message,
          title: title,
          bookingUid: bookingUid,
          senderUid: senderUid,
          recipientUid: recipientUid);
      return const Right(null);
    } catch (e) {
      CrashService.setCrashKey('notification', 'sending a notification');
      return Left(FailureToMessage.returnLeftError(e));
    }
  }
}
