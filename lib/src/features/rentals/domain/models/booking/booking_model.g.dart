// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BookingModelImpl _$$BookingModelImplFromJson(Map<String, dynamic> json) =>
    _$BookingModelImpl(
      id: (json['id'] as num?)?.toInt(),
      uid: json['uid'] as String?,
      externalId: json['externalId'] as String?,
      status: $enumDecodeNullable(_$BookingStatusEnumMap, json['status']),
      collectionAmount: json['collectionAmount'] as num?,
      collectionStatus: $enumDecodeNullable(
          _$BookingProgressStatusEnumMap, json['collectionStatus']),
      disbursementAmount: json['disbursementAmount'] as num?,
      disbursementStatus: $enumDecodeNullable(
          _$BookingProgressStatusEnumMap, json['disbursementStatus']),
      reversalStatus: $enumDecodeNullable(
          _$BookingProgressStatusEnumMap, json['reversalStatus']),
      bookingAcceptanceStatus: $enumDecodeNullable(
          _$BookingProgressStatusEnumMap, json['bookingAcceptanceStatus']),
      vendorPickupStatus: $enumDecodeNullable(
          _$BookingProgressStatusEnumMap, json['vendorPickupStatus']),
      userPickupStatus: $enumDecodeNullable(
          _$BookingProgressStatusEnumMap, json['userPickupStatus']),
      vendorDropOffStatus: $enumDecodeNullable(
          _$BookingProgressStatusEnumMap, json['vendorDropOffStatus']),
      userDropOffStatus: $enumDecodeNullable(
          _$BookingProgressStatusEnumMap, json['userDropOffStatus']),
      bookingNumber: json['bookingNumber'] as String?,
      productUid: json['productUid'] as String?,
      userUid: json['userUid'] as String?,
      vendorUid: json['vendorUid'] as String?,
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
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$BookingModelImplToJson(_$BookingModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'externalId': instance.externalId,
      'status': _$BookingStatusEnumMap[instance.status],
      'collectionAmount': instance.collectionAmount,
      'collectionStatus':
          _$BookingProgressStatusEnumMap[instance.collectionStatus],
      'disbursementAmount': instance.disbursementAmount,
      'disbursementStatus':
          _$BookingProgressStatusEnumMap[instance.disbursementStatus],
      'reversalStatus': _$BookingProgressStatusEnumMap[instance.reversalStatus],
      'bookingAcceptanceStatus':
          _$BookingProgressStatusEnumMap[instance.bookingAcceptanceStatus],
      'vendorPickupStatus':
          _$BookingProgressStatusEnumMap[instance.vendorPickupStatus],
      'userPickupStatus':
          _$BookingProgressStatusEnumMap[instance.userPickupStatus],
      'vendorDropOffStatus':
          _$BookingProgressStatusEnumMap[instance.vendorDropOffStatus],
      'userDropOffStatus':
          _$BookingProgressStatusEnumMap[instance.userDropOffStatus],
      'bookingNumber': instance.bookingNumber,
      'productUid': instance.productUid,
      'userUid': instance.userUid,
      'vendorUid': instance.vendorUid,
      'bookedProduct': instance.bookedProduct,
      'userHasReported': instance.userHasReported,
      'vendorHasReported': instance.vendorHasReported,
      'vendor': instance.vendor,
      'user': instance.user,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

const _$BookingStatusEnumMap = {
  BookingStatus.awaitingAcceptance: 'awaitingAcceptance',
  BookingStatus.awaitingCollection: 'awaitingCollection',
  BookingStatus.awaitingDropOff: 'awaitingDropOff',
  BookingStatus.awaitingPickup: 'awaitingPickup',
  BookingStatus.awaitingReturn: 'awaitingReturn',
  BookingStatus.completed: 'completed',
  BookingStatus.cancelled: 'cancelled',
};

const _$BookingProgressStatusEnumMap = {
  BookingProgressStatus.notStarted: 'notStarted',
  BookingProgressStatus.pending: 'pending',
  BookingProgressStatus.accepted: 'accepted',
  BookingProgressStatus.rejected: 'rejected',
  BookingProgressStatus.cancelled: 'cancelled',
  BookingProgressStatus.abandoned: 'abandoned',
  BookingProgressStatus.failed: 'failed',
  BookingProgressStatus.success: 'success',
};
