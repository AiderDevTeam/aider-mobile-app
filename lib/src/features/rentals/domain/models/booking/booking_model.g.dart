// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BookingModelImpl _$$BookingModelImplFromJson(Map<String, dynamic> json) =>
    _$BookingModelImpl(
      id: (json['id'] as num?)?.toInt(),
      externalId: json['externalId'] as String?,
      status: json['status'] as String?,
      collectionAmount: json['collectionAmount'] as num?,
      collectionStatus: json['collectionStatus'] as String?,
      disbursementAmount: json['disbursementAmount'] as num?,
      disbursementStatus: json['disbursementStatus'] as String?,
      reversalStatus: json['reversalStatus'] as String?,
      bookingAcceptanceStatus: json['bookingAcceptanceStatus'] as String?,
      vendorPickupStatus: json['vendorPickupStatus'] as String?,
      userPickupStatus: json['userPickupStatus'] as String?,
      vendorDropOffStatus: json['vendorDropOffStatus'] as String?,
      userDropOffStatus: json['userDropOffStatus'] as String?,
      bookingNumber: json['bookingNumber'] as String?,
      bookedProduct: json['bookedProduct'] == null
          ? null
          : BookedProductModel.fromJson(
              json['bookedProduct'] as Map<String, dynamic>),
      userHasReported: json['userHasReported'] as bool? ?? false,
      vendorHasReported: json['vendorHasReported'] as bool? ?? false,
      vendor: json['vendor'] == null
          ? null
          : UserModel.fromJson(json['vendor'] as Map<String, dynamic>),
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$BookingModelImplToJson(_$BookingModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'externalId': instance.externalId,
      'status': instance.status,
      'collectionAmount': instance.collectionAmount,
      'collectionStatus': instance.collectionStatus,
      'disbursementAmount': instance.disbursementAmount,
      'disbursementStatus': instance.disbursementStatus,
      'reversalStatus': instance.reversalStatus,
      'bookingAcceptanceStatus': instance.bookingAcceptanceStatus,
      'vendorPickupStatus': instance.vendorPickupStatus,
      'userPickupStatus': instance.userPickupStatus,
      'vendorDropOffStatus': instance.vendorDropOffStatus,
      'userDropOffStatus': instance.userDropOffStatus,
      'bookingNumber': instance.bookingNumber,
      'bookedProduct': instance.bookedProduct,
      'userHasReported': instance.userHasReported,
      'vendorHasReported': instance.vendorHasReported,
      'vendor': instance.vendor,
      'user': instance.user,
    };
