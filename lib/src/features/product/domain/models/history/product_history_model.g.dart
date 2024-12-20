// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductHistoryModelImpl _$$ProductHistoryModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ProductHistoryModelImpl(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      meta: json['meta'] == null
          ? null
          : PaginationModel.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ProductHistoryModelImplToJson(
        _$ProductHistoryModelImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
    };
