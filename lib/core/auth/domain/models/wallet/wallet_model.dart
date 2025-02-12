import 'package:hive/hive.dart';

part 'wallet_model.g.dart';
@HiveType(typeId: 3)
class WalletModel {
  @HiveField(0)
  final String? uid;
  @HiveField(1)
  final String? userUid;
  @HiveField(2)
  final String? externalId;
  @HiveField(3)
  final String? bankName;
  @HiveField(4)
  final String? bankCode;
  @HiveField(5)
  final String? accountNumber;
  @HiveField(6)
  final String? accountName;
  @HiveField(7)
  final bool? isDefault;

  const WalletModel({
    this.uid,
    this.userUid,
    this.externalId,
    this.bankName,
    this.bankCode,
    this.accountNumber,
    this.accountName,
    this.isDefault,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      uid: json['uid'],
      userUid: json['userUid'],
      externalId: json['externalId'],
      bankName: json['bankName'],
      bankCode: json['bankCode'],
      accountNumber: json['accountNumber'],
      accountName: json['accountName'],
      isDefault: json['isDefault'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'userUid': userUid,
      'externalId': externalId,
      'bankName': bankName,
      'bankCode': bankCode,
      'accountNumber': accountNumber,
      'accountName': accountName,
      'isDefault': isDefault,
    };
  }

  WalletModel copyWith({
    String? uid,
    String? userUid,
    String? externalId,
    String? bankName,
    String? bankCode,
    String? accountNumber,
    String? accountName,
    bool? isDefault,
  }) {
    return WalletModel(
      uid: uid ?? this.uid,
      userUid: userUid ?? this.userUid,
      externalId: externalId ?? this.externalId,
      bankName: bankName ?? this.bankName,
      bankCode: bankCode ?? this.bankCode,
      accountNumber: accountNumber ?? this.accountNumber,
      accountName: accountName ?? this.accountName,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}

class WalletList {
  WalletList({required this.list});
  final List<WalletModel> list;

  factory WalletList.fromJson(List parsedJson) {
    final list = parsedJson.map((obj) => WalletModel.fromJson(obj)).toList();
    return WalletList(list: list);
  }
}
