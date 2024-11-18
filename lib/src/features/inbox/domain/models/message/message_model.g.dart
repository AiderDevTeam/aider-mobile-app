// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageModelImpl _$$MessageModelImplFromJson(Map<String, dynamic> json) =>
    _$MessageModelImpl(
      id: (json['id'] as num?)?.toInt(),
      externalId: json['externalId'] as String?,
      conversationId: (json['conversationId'] as num?)?.toInt(),
      senderExternalId: json['senderExternalId'] as String?,
      type: json['type'] as String?,
      senderMessage: json['senderMessage'],
      receiverMessage: json['receiverMessage'],
      sentAt: json['sentAt'] as String?,
      onGoing: json['onGoing'] as bool?,
    );

Map<String, dynamic> _$$MessageModelImplToJson(_$MessageModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'externalId': instance.externalId,
      'conversationId': instance.conversationId,
      'senderExternalId': instance.senderExternalId,
      'type': instance.type,
      'senderMessage': instance.senderMessage,
      'receiverMessage': instance.receiverMessage,
      'sentAt': instance.sentAt,
      'onGoing': instance.onGoing,
    };
