// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_prediction_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LocationPredictionDetailModelImpl
    _$$LocationPredictionDetailModelImplFromJson(Map<String, dynamic> json) =>
        _$LocationPredictionDetailModelImpl(
          geometry: json['geometry'] as Map<String, dynamic>?,
          addressComponents: json['address_components'] as List<dynamic>?,
        );

Map<String, dynamic> _$$LocationPredictionDetailModelImplToJson(
        _$LocationPredictionDetailModelImpl instance) =>
    <String, dynamic>{
      'geometry': instance.geometry,
      'address_components': instance.addressComponents,
    };
