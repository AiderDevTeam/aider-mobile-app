
import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'bank_model.freezed.dart';
part 'bank_model.g.dart';


@freezed
class BankModel with _$BankModel {
  const factory BankModel({
    final int? id,
    final String? externalId,
    final String? bankCode,
    final String? country,
    final String? currency,
    final String? longCode,
    final String? name,
    final String? sortCode,
  }) = _BankModel;

  factory BankModel.fromJson(Map<String, dynamic> json) =>
      _$BankModelFromJson(json);


  static String encode(List<BankModel> objects) => json.encode(
    objects.map<Map<String, dynamic>>((obj) => obj.toJson()).toList(),
  );

  static List<BankModel> decode(String objects) => objects.isEmpty ? [] :
  (json.decode(objects) as List<dynamic>)
      .map<BankModel>((obj) => BankModel.fromJson(obj)).toList();

}


class BankList {
  BankList({required this.list});
  final List<BankModel> list;

  factory BankList.fromJson(List parsedJson) {
    final list = parsedJson.map((obj) => BankModel.fromJson(obj) ).toList();
    return BankList(list: list);
  }

}