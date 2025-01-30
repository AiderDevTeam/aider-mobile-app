import 'dart:collection';

import 'package:aider_mobile_app/core/constants/common.dart';
import 'package:aider_mobile_app/core/providers/base_provider.dart';
import 'package:aider_mobile_app/src/shared_widgets/modals/success_modal_content.dart';
import 'package:flutter/material.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/routing/app_navigator.dart';
import '../../../../../core/services/git_it_service_locator.dart';
import '../../../../../core/services/logger_service.dart';
import '../../../../../core/services/socket_service.dart';
import '../../../../../core/utils/app_dialog_util.dart';
import '../../../../shared_widgets/modals/error_modal_content.dart';
import '../../data/repositories/inbox_repository.dart';
import '../../domain/models/chat/chat_model.dart';
import '../../domain/models/message/message_model.dart';

class InboxViewModel extends BaseProvider {
  final _inboxRepository = sl.get<InboxRepository>();

  List<ChatModel> _sentChats = [];
  List<ChatModel> _receivedChats = [];
  List<MessageModel> _messages = [];

  /// INBOX
  void emitRenderConversations(String externalId) {
    // SocketService().emit('sendRenterConversation', {
    //   "externalId": externalId,
    // });
    ZLoggerService.logOnInfo('EMITTING RENTER CONVERSATIONS');
  }

  void emitVendorConversations(String externalId) {
    // SocketService().emit('sendVendorConversation', {
    //   "externalId": externalId,
    // });
    ZLoggerService.logOnInfo('EMITTING VENDOR CONVERSATIONS');
  }

  UnmodifiableListView<ChatModel> get getReceivedChats =>
      UnmodifiableListView(_receivedChats);

  void fetchVendorConversations() {
    try {
      setLoading(true, component: 'receivedInbox');
      // SocketService().once('fetchVendorConversation', (data) {
      //   ZLoggerService.logOnInfo(
      //       'FETCHING RECEIVED CONVERSATIONS \n ---- $data ---- \n${DateTime.now()}');
      //   if (data != null) {
      //   _receivedChats = ChatList.fromJson(data).list;
      //   notifyListeners();
      //   _persistReceivedChat();
      // }
      // });

      // SocketService().off('fetchVendorConversations');
    } catch (e) {
      // SocketService().off('fetchVendorConversations');
    } finally {
      setLoading(false, component: 'receivedInbox');
    }
  }

  UnmodifiableListView<ChatModel> get getSentChats =>
      UnmodifiableListView(_sentChats);

  void fetchRenterConversations() {
    try {
      setLoading(true, component: 'sentInbox');
      // SocketService().once('fetchRenterConversation', (data) {
      //   ZLoggerService.logOnInfo(
      //       'FETCHING SENT CONVERSATIONS \n ---- $data ---- \n${DateTime.now()}');
      //   if (data != null) {
      //     _sentChats = ChatList.fromJson(data).list;
      //     notifyListeners();
      //     _persistSentChat();
      //   }
      // });

      // SocketService().off('fetchRenterConversations');
    } catch (e) {
      // SocketService().off('fetchRenterConversations');
    } finally {
      setLoading(false, component: 'sentInbox');
    }
  }

  /// CHAT MESSAGES
  void emitMessages(int conversationId) {
    // SocketService().emit('sendMessages', {
    //   "conversationId": conversationId,
    // });
    ZLoggerService.logOnInfo('EMITTING MESSAGES');
  }

  UnmodifiableListView<MessageModel> get getMessages =>
      UnmodifiableListView(_messages);
  void clearMessages() {
    _messages.clear();
  }

  void fetchMessages() {
    try {
      setLoading(true, component: 'messages');
      clearMessages();
      // SocketService().on('fetchMessages', (data) {
      //   ZLoggerService.logOnInfo(
      //       'FETCHING MESSAGES \n ---- $data ---- \n${DateTime.now()}');

      //   if (data != null) {
      //     if (data.runtimeType != List) {
      //       final message = MessageModel.fromJson(data ?? {});
      //       final index = _messages.indexWhere((obj) =>
      //           obj.externalId == message.externalId &&
      //           obj.conversationId == message.conversationId);
      //     if (index >= 0) {
      //       _messages[index] = message;
      //     } else {
      //       final newIndex = _messages.indexWhere(
      //           (obj) => obj.conversationId == message.conversationId);

      //         if (newIndex >= 0) {
      //           _messages.insert(0, message);
      //         }
      //     }
      //     notifyListeners();
      //     return;
      //   }
      //   _messages = MessageList.fromJson(data).list;
      //   notifyListeners();
      // });
    } finally {
      setLoading(false, component: 'messages');
    }
  }

  void closeFetchMessage() {
    // SocketService().off('fetchMessages');
  }

  bool get canNudge =>
      getMessages.isNotEmpty &&
      getMessages.where((obj) => obj.type == kChatNudgeType).toList().length <
          2;

  bool _isAcceptingRequestLoading = false;

  /// INITIATE A REQUEST ACCEPT
  bool get isAcceptingRequestLoading => _isAcceptingRequestLoading;

  set setAcceptingRequestLoading(bool value) {
    _isAcceptingRequestLoading = value;
    notifyListeners();
  }

  /// BOOKING REQUEST ACCEPTANCE
  Future<void> approveBookingRequest(BuildContext context,
      {String? messageExternalId,
      required String bookingExternalId,
      required Map<String, dynamic> requestBody}) async {
    if (requestBody['status'] == 'canceled')
      AppDialogUtil.loadingDialog(context);
    if (requestBody['status'] == 'rejected')
      AppDialogUtil.loadingDialog(context);

    if (requestBody['status'] == 'accepted') setAcceptingRequestLoading = true;
    final result = await _inboxRepository.approveBookingRequest(
        bookingExternalId: bookingExternalId, requestBody: requestBody);
    if (context.mounted) {
      AppNavigator.pop(context);
    }

    result.fold((failure) {
      if (requestBody['status'] == 'accepted')
        setAcceptingRequestLoading = false;
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        AppDialogUtil.popUpModal(
          context,
          modalContent: ErrorModalContent(
            errorMessage: FailureToMessage.mapFailureToMessage(failure),
          ),
        );
      });
    }, (booking) {
      final index =
          _messages.indexWhere((obj) => obj.externalId == messageExternalId);
      if (index >= 0) {
        _messages[index] = _messages[index].copyWith(
          senderMessage: booking,
        );

        if (requestBody['status'] == 'accepted')
          setAcceptingRequestLoading = false;
      }

      if (requestBody['status'] == 'canceled') {
        Navigator.pop(context);
        return;
      }
      if (requestBody['status'] == 'rejected') {
        Navigator.pop(context);
        return;
      }
      notifyListeners();
    });
  }

  /// SEND NUDGE
  Future<void> sendNudge(BuildContext context,
      {String? conversationId,
      required Map<String, dynamic> requestBody}) async {
    AppDialogUtil.loadingDialog(context);
    final result = await _inboxRepository.sendNudge(
        conversationId: conversationId, requestBody: requestBody);
    if (context.mounted) {
      AppNavigator.pop(context);
    }

    result.fold((failure) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        AppDialogUtil.popUpModal(
          context,
          modalContent: ErrorModalContent(
            errorMessage: FailureToMessage.mapFailureToMessage(failure),
          ),
        );
      });
    }, (chat) {
      AppDialogUtil.popUpModal(
        context,
        modalContent: const SuccessModalContent(
          title: 'Nudged',
          message: 'You have nudged a vendor',
        ),
      );
    });
  }

  /// LOCAL DB
  void _persistSentChat() async {
    final _ = await _inboxRepository.persistSentChat(_sentChats);
  }

  void _persistReceivedChat() async {
    final _ = await _inboxRepository.persistReceivedChat(_receivedChats);
  }

  Future<void> _retrieveSentChat() async {
    final result = await _inboxRepository.retrieveSentChat();
    result.fold((l) => null, (chats) => _sentChats = chats);
  }

  Future<void> _retrieveReceivedChat() async {
    final result = await _inboxRepository.retrieveReceivedChat();
    result.fold((l) => null, (chats) => _receivedChats = chats);
  }

  Future<void> initState([bool notify = false]) async {
    await _retrieveReceivedChat();
    await _retrieveSentChat();
    if (notify) notifyListeners();
  }
}
