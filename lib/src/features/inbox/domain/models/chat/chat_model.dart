import 'dart:convert';

import '../../../../../../core/auth/domain/models/user/user_model.dart';
import '../message/message_model.dart';

class ChatModel {
  final int? id;
  final String? externalId;
  final String? createdAt;
  final List<MessageModel> messages;
  final UserModel? user;
  final UserModel? vendor;

  ChatModel({
    this.id,
    this.externalId,
    this.createdAt,
    this.messages = const [],
    this.user,
    this.vendor,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'],
      externalId: json['external_id'],
      createdAt: json['created_at'],
      messages: json['messages'],
      user: json['user'],
      vendor: json['vendor'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'external_id': externalId,
      'created_at': createdAt,
      'messages': messages,
      'user': user,
      'vendor': vendor,
    };
  }

  static String encode(List<ChatModel> objects) => json.encode(
        objects.map<Map<String, dynamic>>((obj) => obj.toJson()).toList(),
      );

  static List<ChatModel> decode(String objects) => objects.isEmpty
      ? []
      : (json.decode(objects) as List<dynamic>)
          .map<ChatModel>((obj) => ChatModel.fromJson(obj))
          .toList();
}

class ChatList {
  ChatList({required this.list});
  final List<ChatModel> list;

  factory ChatList.fromJson(List parsedJson) {
    final list = parsedJson.map((obj) => ChatModel.fromJson(obj)).toList();
    return ChatList(list: list);
  }
}
