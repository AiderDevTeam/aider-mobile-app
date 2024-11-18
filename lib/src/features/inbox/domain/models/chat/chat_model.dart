
import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../core/auth/domain/models/user/user_model.dart';
import '../message/message_model.dart';

part 'chat_model.freezed.dart';
part 'chat_model.g.dart';


@freezed
class ChatModel with _$ChatModel {
  const factory ChatModel({
    final int? id,
    final String? externalId,
    final String? createdAt,
    @Default([]) final List<MessageModel> messages,
    final UserModel? user,
    final UserModel? vendor,
  }) = _ChatModel;

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);


  static String encode(List<ChatModel> objects) => json.encode(
    objects.map<Map<String, dynamic>>((obj) => obj.toJson()).toList(),
  );

  static List<ChatModel> decode(String objects) => objects.isEmpty ? [] :
  (json.decode(objects) as List<dynamic>)
      .map<ChatModel>((obj) => ChatModel.fromJson(obj)).toList();
}



class ChatList {
  ChatList({required this.list});
  final List<ChatModel> list;

  factory ChatList.fromJson(List parsedJson) {
    final list = parsedJson.map((obj) => ChatModel.fromJson(obj) ).toList();
    return ChatList(list: list);
  }

}