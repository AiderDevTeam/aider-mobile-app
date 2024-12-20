// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CategoryModelImpl _$$CategoryModelImplFromJson(Map<String, dynamic> json) =>
    _$CategoryModelImpl(
      id: (json['id'] as num?)?.toInt(),
      externalId: json['externalId'] as String?,
      name: json['name'] as String?,
      imageUrl: json['imageUrl'] as String?,
      status: json['status'] as String?,
      subCategories: (json['subCategories'] as List<dynamic>?)
          ?.map((e) => SubCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$CategoryModelImplToJson(_$CategoryModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'externalId': instance.externalId,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'status': instance.status,
      'subCategories': instance.subCategories,
    };
