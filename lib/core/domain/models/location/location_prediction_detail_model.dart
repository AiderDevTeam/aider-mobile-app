// ignore_for_file: invalid_annotation_target

class LocationPredictionDetailModel {
  final Map<String, dynamic>? geometry;
  final List? addressComponents;

  const LocationPredictionDetailModel({
    this.geometry,
    this.addressComponents,
  });

  factory LocationPredictionDetailModel.fromJson(Map<String, dynamic> json) {
    return LocationPredictionDetailModel(
      geometry: json['geometry'],
      addressComponents: json['address_components'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'geometry': geometry,
      'address_components': addressComponents,
    };
  }
}
