// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exchange_schedule_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExchangeScheduleModelImpl _$$ExchangeScheduleModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ExchangeScheduleModelImpl(
      externalId: json['externalId'] as String?,
      city: json['city'] as String?,
      status: json['status'] as String?,
      country: json['country'] as String?,
      countryCode: json['countryCode'] as String?,
      originName: json['originName'] as String?,
      timeOfExchange: json['timeOfExchange'] as String?,
    );

Map<String, dynamic> _$$ExchangeScheduleModelImplToJson(
        _$ExchangeScheduleModelImpl instance) =>
    <String, dynamic>{
      'externalId': instance.externalId,
      'city': instance.city,
      'status': instance.status,
      'country': instance.country,
      'countryCode': instance.countryCode,
      'originName': instance.originName,
      'timeOfExchange': instance.timeOfExchange,
    };
