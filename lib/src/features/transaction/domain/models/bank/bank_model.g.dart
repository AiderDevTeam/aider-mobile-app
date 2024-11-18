// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BankModelImpl _$$BankModelImplFromJson(Map<String, dynamic> json) =>
    _$BankModelImpl(
      id: (json['id'] as num?)?.toInt(),
      externalId: json['externalId'] as String?,
      bankCode: json['bankCode'] as String?,
      country: json['country'] as String?,
      currency: json['currency'] as String?,
      longCode: json['longCode'] as String?,
      name: json['name'] as String?,
      sortCode: json['sortCode'] as String?,
    );

Map<String, dynamic> _$$BankModelImplToJson(_$BankModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'externalId': instance.externalId,
      'bankCode': instance.bankCode,
      'country': instance.country,
      'currency': instance.currency,
      'longCode': instance.longCode,
      'name': instance.name,
      'sortCode': instance.sortCode,
    };
