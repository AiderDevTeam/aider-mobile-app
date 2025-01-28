import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'verification_model.freezed.dart';
part 'verification_model.g.dart';

@freezed
class VerificationModel with _$VerificationModel {
  const factory VerificationModel({
    final String? uid,
    final String? externalId,
    final String? idNumber,
    final String? documentUrl,
    final String? selfieUrl,
    final String? type,
    final String? status,
    final String? rejectionReason,
  }) = _VerificationModel;

  factory VerificationModel.fromJson(Map<String, dynamic> json) =>
      _$VerificationModelFromJson(json);

  static String encode(List<VerificationModel> objects) => json.encode(
        objects.map<Map<String, dynamic>>((obj) => obj.toJson()).toList(),
      );

  static List<VerificationModel> decode(String objects) => objects.isEmpty
      ? []
      : (json.decode(objects) as List<dynamic>)
          .map<VerificationModel>((obj) => VerificationModel.fromJson(obj))
          .toList();
}

class VerificationList {
  VerificationList({required this.list});
  final List<VerificationModel> list;

  factory VerificationList.fromJson(List parsedJson) {
    final list =
        parsedJson.map((obj) => VerificationModel.fromJson(obj)).toList();
    return VerificationList(list: list);
  }
}
