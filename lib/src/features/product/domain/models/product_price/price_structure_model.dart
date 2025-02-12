import 'dart:convert';

class PriceStructureModel {
  final int? id;
  final String? externalId;
  final String? name;
  final String? description;
  final int? startDay;
  final int? endDay;

  PriceStructureModel({
    this.id,
    this.externalId,
    this.name,
    this.description,
    this.startDay,
    this.endDay,
  });

  factory PriceStructureModel.fromJson(Map<String, dynamic> json) {
    return PriceStructureModel(
      id: json['id'],
      externalId: json['externalId'],
      name: json['name'],
      description: json['description'],
      startDay: json['startDay'],
      endDay: json['endDay'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'externalId': externalId,
      'name': name,
      'description': description,
      'startDay': startDay,
      'endDay': endDay,
    };
  }

  static String encode(List<PriceStructureModel> objects) => json.encode(
        objects.map<Map<String, dynamic>>((obj) => obj.toJson()).toList(),
      );

  static List<PriceStructureModel> decode(String objects) => objects.isEmpty
      ? []
      : (json.decode(objects) as List<dynamic>)
          .map<PriceStructureModel>((obj) => PriceStructureModel.fromJson(obj))
          .toList();
}

class PriceStructureList {
  PriceStructureList({required this.list});
  final List<PriceStructureModel> list;

  factory PriceStructureList.fromJson(List parsedJson) {
    final list =
        parsedJson.map((obj) => PriceStructureModel.fromJson(obj)).toList();
    return PriceStructureList(list: list);
  }
}
