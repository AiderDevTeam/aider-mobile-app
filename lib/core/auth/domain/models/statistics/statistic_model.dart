import 'package:hive/hive.dart';

import '../renter_rating_counts/renter_individual_rating_counts.dart';
import '../vendor_rating_counts/vendor_individual_rating_counts.dart';

part 'statistic_model.g.dart';

@HiveType(typeId: 2)
class StatisticModel {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final int? rentedItemsCount;
  @HiveField(2)
  final int? listedItemsCount;
  @HiveField(3)
  final num? vendorAverageRating;
  @HiveField(4)
  final num? renterAverageRating;
  @HiveField(5)
  final int? vendorReviewsCount;
  @HiveField(6)
  final int? renterReviewsCount;
  @HiveField(7)
  final int? pendingVendorBookingsCount;
  @HiveField(8)
  final int? pendingRenterBookingsCount;
  @HiveField(9)
  final int? vendorBookingsPendingAcceptanceCount;
  @HiveField(10)
  final VendorIndividualRatingCountsModel? vendorIndividualRatingCounts;
  @HiveField(11)
  final RenterIndividualRatingCountsModel? renterIndividualRatingCounts;

  StatisticModel({
    this.id,
    this.rentedItemsCount,
    this.listedItemsCount,
    this.vendorAverageRating,
    this.renterAverageRating,
    this.vendorReviewsCount,
    this.renterReviewsCount,
    this.pendingVendorBookingsCount,
    this.pendingRenterBookingsCount,
    this.vendorBookingsPendingAcceptanceCount,
    this.vendorIndividualRatingCounts,
    this.renterIndividualRatingCounts,
  });

  StatisticModel copyWith({
    int? id,
    int? rentedItemsCount,
    int? listedItemsCount,
    num? vendorAverageRating,
    num? renterAverageRating,
    int? vendorReviewsCount,
    int? renterReviewsCount,
    int? pendingVendorBookingsCount,
    int? pendingRenterBookingsCount,
    int? vendorBookingsPendingAcceptanceCount,
    VendorIndividualRatingCountsModel? vendorIndividualRatingCounts,
    RenterIndividualRatingCountsModel? renterIndividualRatingCounts,
  }) {
    return StatisticModel(
      id: id ?? this.id,
      rentedItemsCount: rentedItemsCount ?? this.rentedItemsCount,
      listedItemsCount: listedItemsCount ?? this.listedItemsCount,
      vendorAverageRating: vendorAverageRating ?? this.vendorAverageRating,
      renterAverageRating: renterAverageRating ?? this.renterAverageRating,
      vendorReviewsCount: vendorReviewsCount ?? this.vendorReviewsCount,
      renterReviewsCount: renterReviewsCount ?? this.renterReviewsCount,
      pendingVendorBookingsCount:
          pendingVendorBookingsCount ?? this.pendingVendorBookingsCount,
      pendingRenterBookingsCount:
          pendingRenterBookingsCount ?? this.pendingRenterBookingsCount,
      vendorBookingsPendingAcceptanceCount:
          vendorBookingsPendingAcceptanceCount ??
              this.vendorBookingsPendingAcceptanceCount,
      vendorIndividualRatingCounts:
          vendorIndividualRatingCounts ?? this.vendorIndividualRatingCounts,
      renterIndividualRatingCounts:
          renterIndividualRatingCounts ?? this.renterIndividualRatingCounts,
    );
  }

  factory StatisticModel.fromJson(Map<String, dynamic> json) {
    return StatisticModel(
      id: json['id'] as int?,
      rentedItemsCount: json['rentedItemsCount'] as int?,
      listedItemsCount: json['listedItemsCount'] as int?,
      vendorAverageRating: json['vendorAverageRating'] as num?,
      renterAverageRating: json['renterAverageRating'] as num?,
      vendorReviewsCount: json['vendorReviewsCount'] as int?,
      renterReviewsCount: json['renterReviewsCount'] as int?,
      pendingVendorBookingsCount: json['pendingVendorBookingsCount'] as int?,
      pendingRenterBookingsCount: json['pendingRenterBookingsCount'] as int?,
      vendorBookingsPendingAcceptanceCount:
          json['vendorBookingsPendingAcceptanceCount'] as int?,
      vendorIndividualRatingCounts: VendorIndividualRatingCountsModel.fromJson(
          json['vendorIndividualRatingCounts']),
      renterIndividualRatingCounts: RenterIndividualRatingCountsModel.fromJson(
          json['renterIndividualRatingCounts']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'rentedItemsCount': rentedItemsCount,
      'listedItemsCount': listedItemsCount,
      'vendorAverageRating': vendorAverageRating,
      'renterAverageRating': renterAverageRating,
      'vendorReviewsCount': vendorReviewsCount,
      'renterReviewsCount': renterReviewsCount,
      'pendingVendorBookingsCount': pendingVendorBookingsCount,
      'pendingRenterBookingsCount': pendingRenterBookingsCount,
      'vendorBookingsPendingAcceptanceCount':
          vendorBookingsPendingAcceptanceCount,
      'vendorIndividualRatingCounts': vendorIndividualRatingCounts?.toJson(),
      'renterIndividualRatingCounts': renterIndividualRatingCounts?.toJson(),
    };
  }

  int get totalPendingBookingsCount =>
      (pendingVendorBookingsCount ?? 0) + (pendingRenterBookingsCount ?? 0);

  int get totalVendorBookingsPendingAcceptanceCount =>
      (vendorBookingsPendingAcceptanceCount ?? 0);
}
