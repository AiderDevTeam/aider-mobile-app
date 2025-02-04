// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageModelImpl _$$MessageModelImplFromJson(Map<String, dynamic> json) =>
    _$MessageModelImpl(
      uid: json['uid'] as String?,
      id: (json['id'] as num?)?.toInt(),
      externalId: json['externalId'] as String?,
      senderUid: json['senderUid'] as String?,
      receiverUid: json['receiverUid'] as String?,
      type: json['type'] as String?,
      bookingUid: json['bookingUid'] as String?,
      message: json['message'] as String?,
      sentAt: json['sentAt'] as String?,
      onGoing: json['onGoing'] as bool?,
    );

Map<String, dynamic> _$$MessageModelImplToJson(_$MessageModelImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'id': instance.id,
      'externalId': instance.externalId,
      'senderUid': instance.senderUid,
      'receiverUid': instance.receiverUid,
      'type': instance.type,
      'bookingUid': instance.bookingUid,
      'message': instance.message,
      'sentAt': instance.sentAt,
      'onGoing': instance.onGoing,
    };
