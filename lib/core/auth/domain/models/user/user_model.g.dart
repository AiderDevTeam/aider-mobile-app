// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: (json['id'] as num?)?.toInt(),
      uid: json['uid'] as String?,
      externalId: json['externalId'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      displayName: json['displayName'] as String?,
      gender: json['gender'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      callingCode: json['callingCode'] as String?,
      phone: json['phone'] as String?,
      birthday: json['birthday'] as String?,
      idVerificationStatus: json['idVerificationStatus'] as String?,
      idVerified: json['idVerified'] as bool?,
      profilePhotoUrl: json['profilePhotoUrl'] as String?,
      itemsListed: (json['itemsListed'] as num?)?.toInt(),
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
      pushNotificationToken: json['pushNotificationToken'] as String?,
      userTypeId: json['userTypeId'] as String?,
      termsAndConditions: json['termsAndConditions'] as bool?,
      deviceOs: json['deviceOs'] as String?,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'externalId': instance.externalId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'displayName': instance.displayName,
      'gender': instance.gender,
      'email': instance.email,
      'password': instance.password,
      'callingCode': instance.callingCode,
      'phone': instance.phone,
      'birthday': instance.birthday,
      'idVerificationStatus': instance.idVerificationStatus,
      'idVerified': instance.idVerified,
      'profilePhotoUrl': instance.profilePhotoUrl,
      'itemsListed': instance.itemsListed,
      'addresses': instance.addresses,
      'statistics': instance.statistics,
      'wallets': instance.wallets,
      'userIdentifications': instance.userIdentifications,
      'canReceiveSMS': instance.canReceiveSMS,
      'canReceiveEmailUpdates': instance.canReceiveEmailUpdates,
      'canReceivePushNotifications': instance.canReceivePushNotifications,
      'hasDefaultWallet': instance.hasDefaultWallet,
      'pushNotificationToken': instance.pushNotificationToken,
      'userTypeId': instance.userTypeId,
      'termsAndConditions': instance.termsAndConditions,
      'deviceOs': instance.deviceOs,
    };
