// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_prediction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LocationPredictionModelImpl _$$LocationPredictionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$LocationPredictionModelImpl(
      description: json['description'] as String?,
      placeId: json['place_id'] as String?,
      structuredFormatting:
          json['structured_formatting'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$LocationPredictionModelImplToJson(
        _$LocationPredictionModelImpl instance) =>
    <String, dynamic>{
      'description': instance.description,
      'place_id': instance.placeId,
      'structured_formatting': instance.structuredFormatting,
    };
