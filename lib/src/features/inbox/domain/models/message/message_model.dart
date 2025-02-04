import 'package:aider_mobile_app/core/extensions/date_extension.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

@freezed
class MessageModel with _$MessageModel {
  const MessageModel._();
  const factory MessageModel({
    final String? uid,
    final int? id,
    final String? externalId,
    final String? senderUid,
    final String? receiverUid,
    final String? type,
    final String? bookingUid,
    final String? message,
    final String? sentAt,
    final bool? onGoing,
  }) = _MessageModel;

  String get getSentAt =>
      DateTime.parse(sentAt ?? DateTime.now().toString()).timeFormat('');
  bool get isOngoing => onGoing ?? true;

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);
}

class MessageList {
  MessageList({required this.list});
  final List<MessageModel> list;

  factory MessageList.fromJson(List parsedJson) {
    final list = parsedJson.map((obj) => MessageModel.fromJson(obj)).toList();
    return MessageList(list: list);
  }
}
