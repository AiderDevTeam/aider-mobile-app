import 'dart:convert';
import 'package:hive/hive.dart';

part 'verification_model.g.dart';

@HiveType(typeId: 4)
class VerificationModel {
  @HiveField(0)
  final String? uid;
  @HiveField(1)
  final String? externalId;
  @HiveField(2)
  final String? idNumber;
  @HiveField(3)
  final String? documentUrl;
  @HiveField(4)
  final String? selfieUrl;
  @HiveField(5)
  final String? type;
  @HiveField(6)
  final String? status;
  @HiveField(7)
  final String? rejectionReason;

  VerificationModel({
    this.uid,
    this.externalId,
    this.idNumber,
    this.documentUrl,
    this.selfieUrl,
    this.type,
    this.status,
    this.rejectionReason,
  });

  factory VerificationModel.fromJson(Map<String, dynamic> json) {
    return VerificationModel(
      uid: json['uid'],
      externalId: json['external_id'],
      idNumber: json['id_number'],
      documentUrl: json['document_url'],
      selfieUrl: json['selfie_url'],
      type: json['type'],
      status: json['status'],
      rejectionReason: json['rejection_reason'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'external_id': externalId,
      'id_number': idNumber,
      'document_url': documentUrl,
      'selfie_url': selfieUrl,
      'type': type,
      'status': status,
      'rejection_reason': rejectionReason,
    };
  }

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
