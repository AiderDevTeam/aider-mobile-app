// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: (json['id'] as num?)?.toInt(),
      externalId: json['externalId'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      displayName: json['displayName'] as String?,
      gender: json['gender'] as String?,
      email: json['email'] as String?,
      callingCode: json['callingCode'] as String?,
      phone: json['phone'] as String?,
      birthday: json['birthday'] as String?,
      idVerificationStatus: json['idVerificationStatus'] as String?,
      idVerified: json['idVerified'] as bool?,
      joinedAt: json['joinedAt'] as String?,
      profilePhotoUrl: json['profilePhotoUrl'] as String?,
      addresses: (json['addresses'] as List<dynamic>?)
          ?.map((e) => AddressModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      statistics: json['statistics'] == null
          ? null
          : StatisticModel.fromJson(json['statistics'] as Map<String, dynamic>),
      wallets: (json['wallets'] as List<dynamic>?)
          ?.map((e) => WalletModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      userIdentifications: (json['userIdentifications'] as List<dynamic>?)
          ?.map((e) => VerificationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      canReceiveSMS: json['canReceiveSMS'] as bool?,
      canReceiveEmailUpdates: json['canReceiveEmailUpdates'] as bool?,
      canReceivePushNotifications: json['canReceivePushNotifications'] as bool?,
      hasDefaultWallet: json['hasDefaultWallet'] as bool?,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'externalId': instance.externalId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'displayName': instance.displayName,
      'gender': instance.gender,
      'email': instance.email,
      'callingCode': instance.callingCode,
      'phone': instance.phone,
      'birthday': instance.birthday,
      'idVerificationStatus': instance.idVerificationStatus,
      'idVerified': instance.idVerified,
      'joinedAt': instance.joinedAt,
      'profilePhotoUrl': instance.profilePhotoUrl,
      'addresses': instance.addresses,
      'statistics': instance.statistics,
      'wallets': instance.wallets,
      'userIdentifications': instance.userIdentifications,
      'canReceiveSMS': instance.canReceiveSMS,
      'canReceiveEmailUpdates': instance.canReceiveEmailUpdates,
      'canReceivePushNotifications': instance.canReceivePushNotifications,
      'hasDefaultWallet': instance.hasDefaultWallet,
    };
