// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_structure_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PriceStructureModelImpl _$$PriceStructureModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PriceStructureModelImpl(
      id: (json['id'] as num?)?.toInt(),
      externalId: json['externalId'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      startDay: (json['startDay'] as num?)?.toInt(),
      endDay: (json['endDay'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$PriceStructureModelImplToJson(
        _$PriceStructureModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'externalId': instance.externalId,
      'name': instance.name,
      'description': instance.description,
      'startDay': instance.startDay,
      'endDay': instance.endDay,
    };
