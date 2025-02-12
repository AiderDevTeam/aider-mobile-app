class LocationPredictionModel {
  final String? description;
  final String? placeId;
  final Map<String, dynamic>? structuredFormatting;

  LocationPredictionModel({
    this.description,
    this.placeId,
    this.structuredFormatting,
  });

  factory LocationPredictionModel.fromJson(Map<String, dynamic> json) {
    return LocationPredictionModel(
      description: json['description'],
      placeId: json['place_id'],
      structuredFormatting: json['structured_formatting'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'place_id': placeId,
      'structured_formatting': structuredFormatting,
    };
  }
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
