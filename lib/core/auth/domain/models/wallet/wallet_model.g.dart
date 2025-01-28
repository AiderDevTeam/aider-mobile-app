// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WalletModelImpl _$$WalletModelImplFromJson(Map<String, dynamic> json) =>
    _$WalletModelImpl(
      uid: json['uid'] as String?,
      userId: json['userId'] as String?,
      externalId: json['externalId'] as String?,
      bankName: json['bankName'] as String?,
      bankCode: json['bankCode'] as String?,
      accountNumber: json['accountNumber'] as String?,
      accountName: json['accountName'] as String?,
      isDefault: json['isDefault'] as bool?,
    );

Map<String, dynamic> _$$WalletModelImplToJson(_$WalletModelImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'userId': instance.userId,
      'externalId': instance.externalId,
      'bankName': instance.bankName,
      'bankCode': instance.bankCode,
      'accountNumber': instance.accountNumber,
      'accountName': instance.accountName,
      'isDefault': instance.isDefault,
    };
