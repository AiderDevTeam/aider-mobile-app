// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddressModelAdapter extends TypeAdapter<AddressModel> {
  @override
  final int typeId = 1;

  @override
  AddressModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddressModel(
      id: fields[0] as int?,
      uid: fields[1] as String?,
      externalId: fields[2] as String?,
      city: fields[3] as String?,
      originName: fields[4] as String?,
      country: fields[5] as String?,
      countryCode: fields[6] as String?,
      latitude: fields[7] as double?,
      longitude: fields[8] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, AddressModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.uid)
      ..writeByte(2)
      ..write(obj.externalId)
      ..writeByte(3)
      ..write(obj.city)
      ..writeByte(4)
      ..write(obj.originName)
      ..writeByte(5)
      ..write(obj.country)
      ..writeByte(6)
      ..write(obj.countryCode)
      ..writeByte(7)
      ..write(obj.latitude)
      ..writeByte(8)
      ..write(obj.longitude);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddressModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
