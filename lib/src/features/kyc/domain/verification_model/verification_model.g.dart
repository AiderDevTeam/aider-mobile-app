// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verification_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VerificationModelAdapter extends TypeAdapter<VerificationModel> {
  @override
  final int typeId = 4;

  @override
  VerificationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VerificationModel(
      uid: fields[0] as String?,
      externalId: fields[1] as String?,
      idNumber: fields[2] as String?,
      documentUrl: fields[3] as String?,
      selfieUrl: fields[4] as String?,
      type: fields[5] as String?,
      status: fields[6] as String?,
      rejectionReason: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, VerificationModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.externalId)
      ..writeByte(2)
      ..write(obj.idNumber)
      ..writeByte(3)
      ..write(obj.documentUrl)
      ..writeByte(4)
      ..write(obj.selfieUrl)
      ..writeByte(5)
      ..write(obj.type)
      ..writeByte(6)
      ..write(obj.status)
      ..writeByte(7)
      ..write(obj.rejectionReason);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VerificationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
