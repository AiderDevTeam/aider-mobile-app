
import 'package:aider_mobile_app/core/services/local_storage_service.dart';

import '../../../../../core/services/logger_service.dart';
import '../../domain/models/chat/chat_model.dart';

abstract class InboxLocalDatasource{
  Future<List<ChatModel>> retrieveSentChat();
  Future<void> persistSentChat(List<ChatModel> sentChats);
  Future<List<ChatModel>> retrieveReceivedChat();
  Future<void> persistReceivedChat(List<ChatModel> receivedChats);
}

class InboxLocalDatasourceImpl extends InboxLocalDatasource{

  InboxLocalDatasourceImpl({required this.localStorageService,});

  final LocalStorageService localStorageService;

  @override
  Future<List<ChatModel>> retrieveSentChat() async{
    var data = await localStorageService.read('sentChats');
    ZLoggerService.logOnInfo('RETRIEVING SENT CHATS');
    return ChatModel.decode(data?? '');
  }

  @override
  Future<void> persistSentChat(List<ChatModel> sentChats) async{
    await localStorageService.write('sentChats', ChatModel.encode(sentChats));
    ZLoggerService.logOnInfo('PERSISTED SENT CHATS');
  }

  @override
  Future<void> persistReceivedChat(List<ChatModel> receivedChats) async{
    await localStorageService.write('receivedChats', ChatModel.encode(receivedChats));
    ZLoggerService.logOnInfo('PERSISTED RECEIVED CHATS');
  }

  @override
  Future<List<ChatModel>> retrieveReceivedChat() async{
    var data = await localStorageService.read('receivedChats');
    ZLoggerService.logOnInfo('RETRIEVING RECEIVED CHATS');
    return ChatModel.decode(data?? '');
  }

}
