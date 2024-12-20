// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_prediction_model.freezed.dart';

part 'location_prediction_model.g.dart';

@freezed
class LocationPredictionModel with _$LocationPredictionModel {
  const factory LocationPredictionModel({
    String? description,
    @JsonKey(name: 'place_id') String? placeId,
    @JsonKey(name: 'structured_formatting')
    Map<String, dynamic>? structuredFormatting,
  }) = _LocationPredictionModel;

  factory LocationPredictionModel.fromJson(Map<String, dynamic> json) =>
      _$LocationPredictionModelFromJson(json);
}

class LocationPredictionList {
  LocationPredictionList({required this.list});

  final List<LocationPredictionModel> list;

  factory LocationPredictionList.fromJson(List parsedJson) {
    final list =
    parsedJson.map((obj) => LocationPredictionModel.fromJson(obj)).toList();
    return LocationPredictionList(list: list);
  }
}
