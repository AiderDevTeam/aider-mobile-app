// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_photo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductPhotoModelImpl _$$ProductPhotoModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ProductPhotoModelImpl(
      id: (json['id'] as num?)?.toInt(),
      externalId: json['externalId'] as String?,
      photoUrl: json['photoUrl'] as String?,
    );

Map<String, dynamic> _$$ProductPhotoModelImplToJson(
        _$ProductPhotoModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'externalId': instance.externalId,
      'photoUrl': instance.photoUrl,
    };
