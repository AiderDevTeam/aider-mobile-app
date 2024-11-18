// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistic_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StatisticModelImpl _$$StatisticModelImplFromJson(Map<String, dynamic> json) =>
    _$StatisticModelImpl(
      id: (json['id'] as num?)?.toInt(),
      rentedItemsCount: (json['rentedItemsCount'] as num?)?.toInt(),
      listedItemsCount: (json['listedItemsCount'] as num?)?.toInt(),
      vendorAverageRating: json['vendorAverageRating'] as num?,
      renterAverageRating: json['renterAverageRating'] as num?,
      vendorReviewsCount: (json['vendorReviewsCount'] as num?)?.toInt(),
      renterReviewsCount: (json['renterReviewsCount'] as num?)?.toInt(),
      pendingVendorBookingsCount:
          (json['pendingVendorBookingsCount'] as num?)?.toInt(),
      pendingRenterBookingsCount:
          (json['pendingRenterBookingsCount'] as num?)?.toInt(),
      vendorBookingsPendingAcceptanceCount:
          (json['vendorBookingsPendingAcceptanceCount'] as num?)?.toInt(),
      vendorIndividualRatingCounts: json['vendorIndividualRatingCounts'] == null
          ? null
          : VendorIndividualRatingCountsModel.fromJson(
              json['vendorIndividualRatingCounts'] as Map<String, dynamic>),
      renterIndividualRatingCounts: json['renterIndividualRatingCounts'] == null
          ? null
          : RenterIndividualRatingCountsModel.fromJson(
              json['renterIndividualRatingCounts'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$StatisticModelImplToJson(
        _$StatisticModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'rentedItemsCount': instance.rentedItemsCount,
      'listedItemsCount': instance.listedItemsCount,
      'vendorAverageRating': instance.vendorAverageRating,
      'renterAverageRating': instance.renterAverageRating,
      'vendorReviewsCount': instance.vendorReviewsCount,
      'renterReviewsCount': instance.renterReviewsCount,
      'pendingVendorBookingsCount': instance.pendingVendorBookingsCount,
      'pendingRenterBookingsCount': instance.pendingRenterBookingsCount,
      'vendorBookingsPendingAcceptanceCount':
          instance.vendorBookingsPendingAcceptanceCount,
      'vendorIndividualRatingCounts': instance.vendorIndividualRatingCounts,
      'renterIndividualRatingCounts': instance.renterIndividualRatingCounts,
    };
