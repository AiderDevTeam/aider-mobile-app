// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VerificationModelImpl _$$VerificationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$VerificationModelImpl(
      uid: json['uid'] as String?,
      externalId: json['externalId'] as String?,
      idNumber: json['idNumber'] as String?,
      documentUrl: json['documentUrl'] as String?,
      selfieUrl: json['selfieUrl'] as String?,
      type: json['type'] as String?,
      status: json['status'] as String?,
      rejectionReason: json['rejectionReason'] as String?,
    );

Map<String, dynamic> _$$VerificationModelImplToJson(
        _$VerificationModelImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'externalId': instance.externalId,
      'idNumber': instance.idNumber,
      'documentUrl': instance.documentUrl,
      'selfieUrl': instance.selfieUrl,
      'type': instance.type,
      'status': instance.status,
      'rejectionReason': instance.rejectionReason,
    };
