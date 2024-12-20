// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReviewModelImpl _$$ReviewModelImplFromJson(Map<String, dynamic> json) =>
    _$ReviewModelImpl(
      id: (json['id'] as num?)?.toInt(),
      externalId: json['externalId'] as String?,
      rating: (json['rating'] as num?)?.toInt(),
      comment: json['comment'] as String?,
      postedAt: json['postedAt'] as String?,
      time: json['time'] as String?,
      date: json['date'] as String?,
      reviewer: json['reviewer'] == null
          ? null
          : UserModel.fromJson(json['reviewer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ReviewModelImplToJson(_$ReviewModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'externalId': instance.externalId,
      'rating': instance.rating,
      'comment': instance.comment,
      'postedAt': instance.postedAt,
      'time': instance.time,
      'date': instance.date,
      'reviewer': instance.reviewer,
    };
