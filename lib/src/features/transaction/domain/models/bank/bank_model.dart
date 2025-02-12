import 'dart:convert';

class BankModel {
  final int? id;
  final String? externalId;
  final String? code;
  final String? country;
  final String? currency;
  final String? longCode;
  final String? name;
  final String? sortCode;

  const BankModel({
    this.id,
    this.externalId,
    this.code,
    this.country,
    this.currency,
    this.longCode,
    this.name,
    this.sortCode,
  });

  factory BankModel.fromJson(Map<String, dynamic> json) {
    return BankModel(
      id: json['id'],
      externalId: json['external_id'],
      code: json['code'],
      country: json['country'],
      currency: json['currency'],
      longCode: json['long_code'],
      name: json['name'],
      sortCode: json['sort_code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'external_id': externalId,
      'code': code,
      'country': country,
      'currency': currency,
      'long_code': longCode,
      'name': name,
      'sort_code': sortCode,
    };
  }

  static String encode(List<BankModel> objects) => json.encode(
        objects.map<Map<String, dynamic>>((obj) => obj.toJson()).toList(),
      );

  static List<BankModel> decode(String objects) => objects.isEmpty
      ? []
      : (json.decode(objects) as List<dynamic>)
          .map<BankModel>((obj) => BankModel.fromJson(obj))
          .toList();
}

class BankList {
  BankList({required this.list});
  final List<BankModel> list;

  factory BankList.fromJson(List parsedJson) {
    final list = parsedJson.map((obj) => BankModel.fromJson(obj)).toList();
    return BankList(list: list);
  }
}
