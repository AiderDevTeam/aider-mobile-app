// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_prediction_detail_model.freezed.dart';
part 'location_prediction_detail_model.g.dart';

@freezed
class LocationPredictionDetailModel with _$LocationPredictionDetailModel{
  const factory LocationPredictionDetailModel({
    @JsonKey(name: 'geometry') Map<String, dynamic>? geometry,
    @JsonKey(name: 'address_components') List? addressComponents,

  }) = _LocationPredictionDetailModel;

  factory LocationPredictionDetailModel.fromJson(Map<String, dynamic> json) => _$LocationPredictionDetailModelFromJson(json);
}

