
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/services/crash_service.dart';
import '../../domain/models/chat/chat_model.dart';
import '../datasources/inbox_local_datasource.dart';
import '../datasources/inbox_remote_datasource.dart';

abstract class InboxRepository{
  Future<Either<Failure, Map<String, dynamic>>> approveBookingRequest({required String bookingExternalId, required Map<String, dynamic> requestBody});
  Future<Either<Failure, ChatModel>> sendNudge({String? conversationId, required Map<String, dynamic> requestBody});

  /// LOCAL DB
  Future<Either<Failure, bool>> persistSentChat(List<ChatModel> sentChats);
  Future<Either<Failure, List<ChatModel>>> retrieveSentChat();
  Future<Either<Failure, bool>> persistReceivedChat(List<ChatModel> receivedChats);
  Future<Either<Failure, List<ChatModel>>> retrieveReceivedChat();
}

class InboxRepositoryImpl extends InboxRepository{
  InboxRepositoryImpl({required this.inboxRemoteDatasource, required this.inboxLocalDatasource,});

  final InboxRemoteDatasource inboxRemoteDatasource;
  final InboxLocalDatasource inboxLocalDatasource;

  @override
  Future<Either<Failure, bool>> persistSentChat(List<ChatModel> sentChats) async{
    try{
      await inboxLocalDatasource.persistSentChat(sentChats);
      return const Right(true);
    }catch(e, s){
      CrashService.setCrashKey('chat', 'persisting sent chats');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, List<ChatModel>>> retrieveSentChat() async{
    try{
      final response = await inboxLocalDatasource.retrieveSentChat();
      return Right(response);
    }catch(e, s){
      CrashService.setCrashKey('chat', 'retrieving sent chats');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, bool>> persistReceivedChat(List<ChatModel> receivedChats) async{
    try{
      await inboxLocalDatasource.persistReceivedChat(receivedChats);
      return const Right(true);
    }catch(e, s){
      CrashService.setCrashKey('chat', 'persisting received chats');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, List<ChatModel>>> retrieveReceivedChat() async{
    try{
      final response = await inboxLocalDatasource.retrieveReceivedChat();
      return Right(response);
    }catch(e, s){
      CrashService.setCrashKey('chat', 'retrieving received chats');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> approveBookingRequest({required String bookingExternalId, required Map<String, dynamic> requestBody}) async{
    try{
      final response = await inboxRemoteDatasource.approveBookingRequest(bookingExternalId:bookingExternalId, requestBody:requestBody);
      return Right(response);
    }catch(e, s){
      CrashService.setCrashKey('booking', 'booking request approvals');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, ChatModel>> sendNudge({String? conversationId, required Map<String, dynamic> requestBody}) async{
    try{
      final response = await inboxRemoteDatasource.sendNudge(conversationId:conversationId, requestBody:requestBody);
      return Right(response);
    }catch(e, s){
      CrashService.setCrashKey('nudge', 'sending a nudge');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

}