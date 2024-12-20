// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReviewHistoryModelImpl _$$ReviewHistoryModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ReviewHistoryModelImpl(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      meta: json['meta'] == null
          ? null
          : PaginationModel.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ReviewHistoryModelImplToJson(
        _$ReviewHistoryModelImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
    };
