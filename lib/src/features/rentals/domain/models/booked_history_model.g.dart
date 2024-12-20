// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booked_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BookedProductHistoryModelImpl _$$BookedProductHistoryModelImplFromJson(
        Map<String, dynamic> json) =>
    _$BookedProductHistoryModelImpl(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => BookingModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      meta: json['meta'] == null
          ? null
          : PaginationModel.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$BookedProductHistoryModelImplToJson(
        _$BookedProductHistoryModelImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
    };
