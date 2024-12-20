// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_category_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SubCategoryItemModelImpl _$$SubCategoryItemModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SubCategoryItemModelImpl(
      id: (json['id'] as num?)?.toInt(),
      externalId: json['externalId'] as String?,
      name: json['name'] as String?,
      subCategory: json['subCategory'] == null
          ? null
          : SubCategoryModel.fromJson(
              json['subCategory'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SubCategoryItemModelImplToJson(
        _$SubCategoryItemModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'externalId': instance.externalId,
      'name': instance.name,
      'subCategory': instance.subCategory,
    };
