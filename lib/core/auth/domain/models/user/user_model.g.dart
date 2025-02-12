// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 0;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      id: fields[0] as int?,
      uid: fields[1] as String?,
      externalId: fields[2] as String?,
      firstName: fields[3] as String?,
      lastName: fields[4] as String?,
      displayName: fields[5] as String?,
      gender: fields[6] as String?,
      email: fields[7] as String?,
      password: fields[8] as String?,
      callingCode: fields[9] as String?,
      phone: fields[10] as String?,
      birthday: fields[11] as String?,
      idVerificationStatus: fields[12] as String?,
      idVerified: fields[13] as bool?,
      profilePhotoUrl: fields[14] as String?,
      itemsListed: fields[15] as int?,
      addresses: (fields[16] as List?)?.cast<AddressModel>(),
      statistics: fields[17] as StatisticModel?,
      wallets: (fields[18] as List?)?.cast<WalletModel>(),
      userIdentifications: (fields[19] as List?)?.cast<VerificationModel>(),
      canReceiveSMS: fields[20] as bool?,
      canReceiveEmailUpdates: fields[21] as bool?,
      canReceivePushNotifications: fields[22] as bool?,
      hasDefaultWallet: fields[23] as bool?,
      pushNotificationToken: fields[24] as String?,
      userTypeId: fields[25] as String?,
      termsAndConditions: fields[26] as bool?,
      deviceOs: fields[27] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(28)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.uid)
      ..writeByte(2)
      ..write(obj.externalId)
      ..writeByte(3)
      ..write(obj.firstName)
      ..writeByte(4)
      ..write(obj.lastName)
      ..writeByte(5)
      ..write(obj.displayName)
      ..writeByte(6)
      ..write(obj.gender)
      ..writeByte(7)
      ..write(obj.email)
      ..writeByte(8)
      ..write(obj.password)
      ..writeByte(9)
      ..write(obj.callingCode)
      ..writeByte(10)
      ..write(obj.phone)
      ..writeByte(11)
      ..write(obj.birthday)
      ..writeByte(12)
      ..write(obj.idVerificationStatus)
      ..writeByte(13)
      ..write(obj.idVerified)
      ..writeByte(14)
      ..write(obj.profilePhotoUrl)
      ..writeByte(15)
      ..write(obj.itemsListed)
      ..writeByte(16)
      ..write(obj.addresses)
      ..writeByte(17)
      ..write(obj.statistics)
      ..writeByte(18)
      ..write(obj.wallets)
      ..writeByte(19)
      ..write(obj.userIdentifications)
      ..writeByte(20)
      ..write(obj.canReceiveSMS)
      ..writeByte(21)
      ..write(obj.canReceiveEmailUpdates)
      ..writeByte(22)
      ..write(obj.canReceivePushNotifications)
      ..writeByte(23)
      ..write(obj.hasDefaultWallet)
      ..writeByte(24)
      ..write(obj.pushNotificationToken)
      ..writeByte(25)
      ..write(obj.userTypeId)
      ..writeByte(26)
      ..write(obj.termsAndConditions)
      ..writeByte(27)
      ..write(obj.deviceOs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
