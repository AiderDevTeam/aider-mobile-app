// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booked_product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BookedProductModelImpl _$$BookedProductModelImplFromJson(
        Map<String, dynamic> json) =>
    _$BookedProductModelImpl(
      id: (json['id'] as num?)?.toInt(),
      externalId: json['externalId'] as String?,
      amount: json['amount'] as num?,
      quantity: (json['quantity'] as num?)?.toInt(),
      value: json['value'] as num?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      duration: (json['duration'] as num?)?.toInt(),
      returnedEarly: json['returnedEarly'] as bool?,
      product: json['product'] == null
          ? null
          : ProductModel.fromJson(json['product'] as Map<String, dynamic>),
      isReviewed: json['isReviewed'] as bool?,
      review: json['review'] == null
          ? null
          : ReviewModel.fromJson(json['review'] as Map<String, dynamic>),
      renterReview: json['renterReview'] == null
          ? null
          : ReviewModel.fromJson(json['renterReview'] as Map<String, dynamic>),
      exchangeSchedule: json['exchangeSchedule'] == null
          ? null
          : ExchangeScheduleModel.fromJson(
              json['exchangeSchedule'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$BookedProductModelImplToJson(
        _$BookedProductModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'externalId': instance.externalId,
      'amount': instance.amount,
      'quantity': instance.quantity,
      'value': instance.value,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'duration': instance.duration,
      'returnedEarly': instance.returnedEarly,
      'product': instance.product,
      'isReviewed': instance.isReviewed,
      'review': instance.review,
      'renterReview': instance.renterReview,
      'exchangeSchedule': instance.exchangeSchedule,
    };
