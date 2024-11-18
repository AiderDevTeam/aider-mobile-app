import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'price_structure_model.freezed.dart';
part 'price_structure_model.g.dart';


@freezed
class PriceStructureModel with _$PriceStructureModel {
  const factory PriceStructureModel({
    final int? id,
    final String? externalId,
    final String? name,
    final String? description,
    final int? startDay,
    final int? endDay,
  }) = _PriceStructureModel;

  factory PriceStructureModel.fromJson(Map<String, dynamic> json) =>
      _$PriceStructureModelFromJson(json);


  static String encode(List<PriceStructureModel> objects) => json.encode(
    objects.map<Map<String, dynamic>>((obj) => obj.toJson()).toList(),
  );

  static List<PriceStructureModel> decode(String objects) => objects.isEmpty ? [] :
  (json.decode(objects) as List<dynamic>)
      .map<PriceStructureModel>((obj) => PriceStructureModel.fromJson(obj)).toList();
}


class PriceStructureList {
  PriceStructureList({required this.list});
  final List<PriceStructureModel> list;

  factory PriceStructureList.fromJson(List parsedJson) {
    final list = parsedJson.map((obj) => PriceStructureModel.fromJson(obj) ).toList();
    return PriceStructureList(list: list);
  }

}
