// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_price_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductPriceModelImpl _$$ProductPriceModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ProductPriceModelImpl(
      id: (json['id'] as num?)?.toInt(),
      externalId: json['externalId'] as String?,
      price: json['price'] as num?,
      startDay: (json['startDay'] as num?)?.toInt(),
      endDay: (json['endDay'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ProductPriceModelImplToJson(
        _$ProductPriceModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'externalId': instance.externalId,
      'price': instance.price,
      'startDay': instance.startDay,
      'endDay': instance.endDay,
    };
