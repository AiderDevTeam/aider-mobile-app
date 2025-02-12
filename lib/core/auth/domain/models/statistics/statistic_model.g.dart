// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistic_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StatisticModelAdapter extends TypeAdapter<StatisticModel> {
  @override
  final int typeId = 2;

  @override
  StatisticModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StatisticModel(
      id: fields[0] as int?,
      rentedItemsCount: fields[1] as int?,
      listedItemsCount: fields[2] as int?,
      vendorAverageRating: fields[3] as num?,
      renterAverageRating: fields[4] as num?,
      vendorReviewsCount: fields[5] as int?,
      renterReviewsCount: fields[6] as int?,
      pendingVendorBookingsCount: fields[7] as int?,
      pendingRenterBookingsCount: fields[8] as int?,
      vendorBookingsPendingAcceptanceCount: fields[9] as int?,
      vendorIndividualRatingCounts:
          fields[10] as VendorIndividualRatingCountsModel?,
      renterIndividualRatingCounts:
          fields[11] as RenterIndividualRatingCountsModel?,
    );
  }

  @override
  void write(BinaryWriter writer, StatisticModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.rentedItemsCount)
      ..writeByte(2)
      ..write(obj.listedItemsCount)
      ..writeByte(3)
      ..write(obj.vendorAverageRating)
      ..writeByte(4)
      ..write(obj.renterAverageRating)
      ..writeByte(5)
      ..write(obj.vendorReviewsCount)
      ..writeByte(6)
      ..write(obj.renterReviewsCount)
      ..writeByte(7)
      ..write(obj.pendingVendorBookingsCount)
      ..writeByte(8)
      ..write(obj.pendingRenterBookingsCount)
      ..writeByte(9)
      ..write(obj.vendorBookingsPendingAcceptanceCount)
      ..writeByte(10)
      ..write(obj.vendorIndividualRatingCounts)
      ..writeByte(11)
      ..write(obj.renterIndividualRatingCounts);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatisticModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
