import 'dart:async';
import 'dart:collection';

import 'package:aider_mobile_app/core/constants/common.dart';
import 'package:aider_mobile_app/core/providers/base_provider.dart';
import 'package:aider_mobile_app/core/providers/user_provider.dart';
import 'package:aider_mobile_app/src/shared_widgets/modals/success_modal_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/routing/app_navigator.dart';
import '../../../../../core/services/git_it_service_locator.dart';
import '../../../../../core/services/logger_service.dart';
import '../../../../../core/utils/app_dialog_util.dart';
import '../../../../shared_widgets/modals/error_modal_content.dart';
import '../../../rentals/data/repositories/rental_repository.dart';
import '../../../rentals/domain/models/booking/booking_model.dart';
import '../../data/repositories/inbox_repository.dart';
import '../../domain/models/chat/chat_model.dart';
import '../../domain/models/message/message_model.dart';

class InboxViewModel extends BaseProvider {
  final _inboxRepository = sl.get<InboxRepository>();
  final _rentalRepository = sl.get<RentalRepository>();

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

  List<BookingModel> _sentBookings = [];
  List<BookingModel> _receivedBookings = [];

  set setSentBookings(List<BookingModel> value) {
    _sentBookings = value;
    notifyListeners();
  }

  set setReceivedBookings(List<BookingModel> value) {
    _receivedBookings = value;
    notifyListeners();
  }

  UnmodifiableListView<BookingModel> get getSentBookings =>
      UnmodifiableListView(_sentBookings);

  UnmodifiableListView<BookingModel> get getReceivedBookings =>
      UnmodifiableListView(_receivedBookings);

  void fetchVendorBookingRequests() async {
    try {
      setLoading(true, component: 'receivedInbox');
      final result = await _rentalRepository.fetchMyItems(
        queryParam: {
          'pageSize': kProductPerPage,
          'type': 'rented',
        },
      );
      result.fold((left) {
        setComponentErrorType = {
          'error': FailureToMessage.mapFailureToMessage(left),
          'component': 'receivedInbox'
        };
      }, (history) {
        setReceivedBookings = history.data;
      });
    } catch (e, s) {
      ZLoggerService.logOnError('error fetching rented items: $e');
      setComponentErrorType = {
        'error': FailureToMessage.returnLeftError(e, s),
        'component': 'receivedInbox'
      };
    } finally {
      setLoading(false, component: 'receivedInbox');
    }
  }

  UnmodifiableListView<ChatModel> get getSentChats =>
      UnmodifiableListView(_sentChats);

  void fetchRenterBookingRequests() async {
    try {
      setLoading(true, component: 'sentInbox');
      final result = await _rentalRepository.fetchRentedItems(
        queryParam: {
          'pageSize': kProductPerPage,
          'type': 'rented',
        },
        isCompleted: false,
      );
      result.fold((left) {
        setComponentErrorType = {
          'error': FailureToMessage.mapFailureToMessage(left),
          'component': 'sentInbox'
        };
      }, (history) {
        setSentBookings = history.data;
      });
    } catch (e) {
      setComponentErrorType = {'error': e.toString(), 'component': 'sentInbox'};
      ZLoggerService.logOnError('error fetching rented items: $e');
    } finally {
      setLoading(false, component: 'sentInbox');
    }
  }

  List<MessageModel> get getMessages => (_messages);
  void clearMessages() {
    _messages.clear();
  }

  void setMessages(List<MessageModel> messages) {
    _messages = messages;
    notifyListeners();
  }

  StreamSubscription<List<MessageModel>>? _messagesSubscription;

  void listenToMessages(String bookingUid) {
    try {
      ZLoggerService.logOnInfo(
          'listening to messages for booking: $bookingUid');
      clearMessages();

      _messagesSubscription?.cancel();
      _messagesSubscription =
          _inboxRepository.fetchMessagesStream(bookingUid).listen(
        (messages) {
          setMessages(messages);
        },
        onError: (error) {
          setComponentErrorType = {
            'error': error.toString(),
            'component': 'messages'
          };
        },
      );
    } catch (e) {
      setComponentErrorType = {'error': e.toString(), 'component': 'messages'};
    }
  }

  @override
  void dispose() {
    _messagesSubscription?.cancel();
    super.dispose();
  }

  void closeFetchMessage() {
    _messagesSubscription?.cancel();
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
      required BookingModel booking,
      required BookingProgressStatus status}) async {
    if (status != BookingProgressStatus.accepted) {
      AppDialogUtil.loadingDialog(context);
    }

    if (status == BookingProgressStatus.accepted) {
      setAcceptingRequestLoading = true;
    }

    final bookingUid = booking.uid!;
    final user = context.read<UserProvider>().getUser;

    final result = await _inboxRepository.approveBookingRequest(
        booking: booking, status: status);

    if (context.mounted && status != BookingProgressStatus.accepted) {
      AppNavigator.pop(context);
      AppNavigator.pop(context);
    }

    result.fold((failure) {
      if (status == BookingProgressStatus.accepted) {
        setAcceptingRequestLoading = false;
      }

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        AppDialogUtil.popUpModal(
          context,
          modalContent: ErrorModalContent(
            errorMessage: FailureToMessage.mapFailureToMessage(failure),
          ),
        );
      });
    }, (_) {
      sendNotification(
          message:
              '${user.firstName} has ${status == BookingProgressStatus.accepted ? 'accepted' : 'rejected'} booking',
          title: 'Booking confirmation',
          bookingUid: bookingUid,
          senderUid: user.uid!,
          recipientUid: booking.userUid!);

      if (status == BookingProgressStatus.accepted) {
        setAcceptingRequestLoading = false;
      }

      if (status == BookingProgressStatus.cancelled) {
        Navigator.pop(context);
        return;
      }
      if (status == BookingProgressStatus.rejected) {
        Navigator.pop(context);
        return;
      }
      notifyListeners();
    });
  }

  /// SEND NUDGE
  Future<void> sendNudge(BuildContext context,
      {required BookingModel booking}) async {
    AppDialogUtil.loadingDialog(context);

    final bookingUid = booking.uid!;
    final user = context.read<UserProvider>().getUser;

    final result = await _inboxRepository.sendNudge(booking: booking);
    // if (context.mounted) {
    //   AppNavigator.pop(context);
    // }

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
      sendNotification(
          message: '${user.firstName} sent you a nudge',
          title: 'Nudge',
          bookingUid: bookingUid,
          senderUid: user.uid!,
          recipientUid: booking.vendorUid!);
      AppDialogUtil.popUpModal(
        context,
        modalContent: const SuccessModalContent(
          title: 'Nudged',
          message: 'You have nudged a vendor',
        ),
      );
    });
  }

  int _totalUnread = 0;

  int get totalUnread => _totalUnread;

  set totalUnread(int value) {
    _totalUnread = value;
    notifyListeners();
  }

  listenToUnreadMessages() {
    _inboxRepository.getUnreadMessagesStream().listen((count) {
      totalUnread = count;
    });
  }

  Future<void> sendNotification(
      {required String message,
      required String title,
      required String bookingUid,
      required String senderUid,
      required String recipientUid}) {
    return _inboxRepository.sendNotification(
      message: message,
      title: title,
      bookingUid: bookingUid,
      senderUid: senderUid,
      recipientUid: recipientUid,
    );
  }

  /// LOCAL DB
  // void _persistSentChat() async {
  //   final _ = await _inboxRepository.persistSentChat(_sentChats);
  // }

  // void _persistReceivedChat() async {
  //   final _ = await _inboxRepository.persistReceivedChat(_receivedChats);
  // }

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
