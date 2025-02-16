import 'package:aider_mobile_app/core/auth/domain/models/statistics/statistic_model.dart';
import 'package:aider_mobile_app/src/features/kyc/domain/verification_model/verification_model.dart';
import 'package:hive/hive.dart';

import '../../../../domain/models/address/address_model.dart';
import '../wallet/wallet_model.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? uid;
  @HiveField(2)
  final String? externalId;
  @HiveField(3)
  final String? firstName;
  @HiveField(4)
  final String? lastName;
  @HiveField(5)
  final String? displayName;
  @HiveField(6)
  final String? gender;
  @HiveField(7)
  final String? email;
  @HiveField(8)
  final String? password;
  @HiveField(9)
  final String? callingCode;
  @HiveField(10)
  final String? phone;
  @HiveField(11)
  final String? birthday;
  @HiveField(12)
  final String? idVerificationStatus;
  @HiveField(13)
  final bool? idVerified;
  @HiveField(14)
  final String? profilePhotoUrl;
  @HiveField(15)
  final int? itemsListed;
  @HiveField(16)
  final List<AddressModel>? addresses;
  @HiveField(17)
  final StatisticModel? statistics;
  @HiveField(18)
  final List<WalletModel>? wallets;
  @HiveField(19)
  final List<VerificationModel>? userIdentifications;
  @HiveField(20)
  final bool? canReceiveSMS;
  @HiveField(21)
  final bool? canReceiveEmailUpdates;
  @HiveField(22)
  final bool? canReceivePushNotifications;
  @HiveField(23)
  final bool? hasDefaultWallet;
  @HiveField(24)
  final String? pushNotificationToken;
  @HiveField(25)
  final String? userTypeId;
  @HiveField(26)
  final bool? termsAndConditions;
  @HiveField(27)
  final String? deviceOs;

  const UserModel({
    this.id,
    this.uid,
    this.externalId,
    this.firstName,
    this.lastName,
    this.displayName,
    this.gender,
    this.email,
    this.password,
    this.callingCode,
    this.phone,
    this.birthday,
    this.idVerificationStatus,
    this.idVerified,
    this.profilePhotoUrl,
    this.itemsListed,
    this.addresses,
    this.statistics,
    this.wallets,
    this.userIdentifications,
    this.canReceiveSMS,
    this.canReceiveEmailUpdates,
    this.canReceivePushNotifications,
    this.hasDefaultWallet,
    this.pushNotificationToken,
    this.userTypeId,
    this.termsAndConditions,
    this.deviceOs,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      uid: json['uid'],
      externalId: json['externalId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      displayName: json['displayName'],
      gender: json['gender'],
      email: json['email'],
      password: json['password'],
      callingCode: json['callingCode'],
      phone: json['phone'],
      birthday: json['birthday'],
      idVerificationStatus: json['idVerificationStatus'],
      idVerified: json['idVerified'],
      profilePhotoUrl: json['profilePhotoUrl'],
      itemsListed: json['itemsListed'],
      addresses: (json['addresses'] as List<dynamic>?)
          ?.map((e) => AddressModel.fromJson(e))
          .toList(),
      statistics: (json['statistics'] as Map<String, dynamic>?) != null
          ? StatisticModel.fromJson(json['statistics'])
          : null,
      wallets: (json['wallets'] as List<dynamic>?)
          ?.map((e) => WalletModel.fromJson(e))
          .toList(),
      userIdentifications: (json['userIdentifications'] as List<dynamic>?)
          ?.map((e) => VerificationModel.fromJson(e))
          .toList(),
      canReceiveSMS: json['canReceiveSMS'],
      canReceiveEmailUpdates: json['canReceiveEmailUpdates'],
      canReceivePushNotifications: json['canReceivePushNotifications'],
      hasDefaultWallet: json['hasDefaultWallet'],
      pushNotificationToken: json['pushNotificationToken'],
      userTypeId: json['userTypeId'],
      termsAndConditions: json['termsAndConditions'],
      deviceOs: json['deviceOs'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uid': uid,
      'externalId': externalId,
      'firstName': firstName,
      'lastName': lastName,
      'displayName': displayName,
      'gender': gender,
      'email': email,
      'password': password,
      'callingCode': callingCode,
      'phone': phone,
      'birthday': birthday,
      'idVerificationStatus': idVerificationStatus,
      'idVerified': idVerified,
      'profilePhotoUrl': profilePhotoUrl,
      'itemsListed': itemsListed,
      'addresses': addresses?.map((e) => e.toJson()).toList(),
      'statistics': statistics?.toJson(),
      'wallets': wallets?.map((e) => e.toJson()).toList(),
      'userIdentifications':
          userIdentifications?.map((e) => e.toJson()).toList(),
      'canReceiveSMS': canReceiveSMS,
      'canReceiveEmailUpdates': canReceiveEmailUpdates,
      'canReceivePushNotifications': canReceivePushNotifications,
      'hasDefaultWallet': hasDefaultWallet,
      'pushNotificationToken': pushNotificationToken,
      'userTypeId': userTypeId,
      'termsAndConditions': termsAndConditions,
      'deviceOs': deviceOs,
    };
  }

  UserModel copyWith({
    String? uid,
    String? externalId,
    String? firstName,
    String? lastName,
    String? displayName,
    String? gender,
    String? email,
    String? password,
    String? callingCode,
    String? phone,
    String? birthday,
    String? idVerificationStatus,
    bool? idVerified,
    String? profilePhotoUrl,
    int? itemsListed,
    List<AddressModel>? addresses,
    StatisticModel? statistics,
    List<WalletModel>? wallets,
    List<VerificationModel>? userIdentifications,
    bool? canReceiveSMS,
    bool? canReceiveEmailUpdates,
    bool? canReceivePushNotifications,
    bool? hasDefaultWallet,
    String? pushNotificationToken,
    String? userTypeId,
    bool? termsAndConditions,
    String? deviceOs,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      externalId: externalId ?? this.externalId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      displayName: displayName ?? this.displayName,
      gender: gender ?? this.gender,
      email: email ?? this.email,
      password: password ?? this.password,
      callingCode: callingCode ?? this.callingCode,
      phone: phone ?? this.phone,
      birthday: birthday ?? this.birthday,
      idVerificationStatus: idVerificationStatus ?? this.idVerificationStatus,
      idVerified: idVerified ?? this.idVerified,
      profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
      itemsListed: itemsListed ?? this.itemsListed,
      addresses: addresses ?? this.addresses,
      statistics: statistics ?? this.statistics,
      wallets: wallets ?? this.wallets,
      userIdentifications: userIdentifications ?? this.userIdentifications,
      canReceiveSMS: canReceiveSMS ?? this.canReceiveSMS,
      canReceiveEmailUpdates:
          canReceiveEmailUpdates ?? this.canReceiveEmailUpdates,
      canReceivePushNotifications:
          canReceivePushNotifications ?? this.canReceivePushNotifications,
      hasDefaultWallet: hasDefaultWallet ?? this.hasDefaultWallet,
      pushNotificationToken:
          pushNotificationToken ?? this.pushNotificationToken,
      userTypeId: userTypeId ?? this.userTypeId,
      termsAndConditions: termsAndConditions ?? this.termsAndConditions,
      deviceOs: deviceOs ?? this.deviceOs,
    );
  }

  AddressModel? get address => addresses?.first;

  VerificationModel? get userIdentification => userIdentifications?.first;

  String get fullName => '${firstName ?? ''} ${lastName ?? ''}';

  String get greetingName {
    if ((firstName ?? '').isEmpty) return '';
    final splitNameList = (firstName ?? '').replaceAll('-', ' ').split(' ');
    return splitNameList.first;
  }

  bool get hasProfilePhoto => (profilePhotoUrl ?? '').isNotEmpty;

  bool get userHasWallet => hasDefaultWallet ?? false;

  // static String? _timestampToString(dynamic timestamp) {
  //   if (timestamp == null) return null;
  //   if (timestamp is Timestamp) {
  //     return timestamp.toDate().toIso8601String();
  //   }
  //   return timestamp as String?;
  // }

  // static dynamic _stringToTimestamp(String? date) {
  //   if (date == null) return null;
  //   return Timestamp.fromDate(DateTime.parse(date));
  // }
}
