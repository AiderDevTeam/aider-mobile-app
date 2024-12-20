// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransactionModelImpl _$$TransactionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TransactionModelImpl(
      id: (json['id'] as num?)?.toInt(),
      externalId: json['externalId'] as String?,
      amount: const NumToStringConverter().fromJson(json['amount']),
      accountNumber: json['accountNumber'] as String?,
      sortCode: json['sortCode'] as String?,
      type: json['type'] as String?,
      status: json['status'] as String?,
      stan: json['stan'] as String?,
    );

Map<String, dynamic> _$$TransactionModelImplToJson(
        _$TransactionModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'externalId': instance.externalId,
      'amount': _$JsonConverterToJson<dynamic, String>(
          instance.amount, const NumToStringConverter().toJson),
      'accountNumber': instance.accountNumber,
      'sortCode': instance.sortCode,
      'type': instance.type,
      'status': instance.status,
      'stan': instance.stan,
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
