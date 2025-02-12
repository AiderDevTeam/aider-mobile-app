import 'package:aider_mobile_app/core/extensions/date_extension.dart';

class MessageModel {
  final String? uid;
  final String? externalId;
  final String? senderUid;
  final String? receiverUid;
  final String? type;
  final String? bookingUid;
  final String? message;
  final String? sentAt;
  final bool? onGoing;

  MessageModel({
    this.uid,
    this.externalId,
    this.senderUid,
    this.receiverUid,
    this.type,
    this.bookingUid,
    this.message,
    this.sentAt,
    this.onGoing,
  });

  String get getSentAt =>
      DateTime.parse(sentAt ?? DateTime.now().toString()).timeFormat('');
  bool get isOngoing => onGoing ?? true;

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      uid: json['uid'],
      externalId: json['externalId'],
      senderUid: json['senderUid'],
      receiverUid: json['receiverUid'],
      type: json['type'],
      bookingUid: json['bookingUid'],
      message: json['message'],
      sentAt: json['sentAt'],
      onGoing: json['onGoing'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'externalId': externalId,
      'senderUid': senderUid,
      'receiverUid': receiverUid,
      'type': type,
      'bookingUid': bookingUid,
      'message': message,
      'sentAt': sentAt,
      'onGoing': onGoing,
    };
  }
}

class MessageList {
  MessageList({required this.list});
  final List<MessageModel> list;

  factory MessageList.fromJson(List parsedJson) {
    final list = parsedJson.map((obj) => MessageModel.fromJson(obj)).toList();
    return MessageList(list: list);
  }
}
