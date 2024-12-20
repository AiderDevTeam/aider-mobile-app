import 'package:freezed_annotation/freezed_annotation.dart';

import '../renter_rating_counts/renter_individual_rating_counts.dart';
import '../vendor_rating_counts/vendor_individual_rating_counts.dart';


part 'statistic_model.freezed.dart';
part 'statistic_model.g.dart';


@freezed
class StatisticModel with _$StatisticModel {
  const StatisticModel._();
  const factory StatisticModel({
    final int? id,
    final int? rentedItemsCount,
    final int? listedItemsCount,
    final num? vendorAverageRating,
    final num? renterAverageRating,
    final int? vendorReviewsCount,
    final int? renterReviewsCount,
    final int? pendingVendorBookingsCount,
    final int? pendingRenterBookingsCount,
    final int? vendorBookingsPendingAcceptanceCount,
    final VendorIndividualRatingCountsModel? vendorIndividualRatingCounts,
    final RenterIndividualRatingCountsModel? renterIndividualRatingCounts,
  }) = _StatisticModel;

  factory StatisticModel.fromJson(Map<String, dynamic> json) =>
      _$StatisticModelFromJson(json);

  int get totalPendingBookingsCount =>
      (pendingVendorBookingsCount ?? 0) + (pendingRenterBookingsCount ?? 0);

  int get totalVendorBookingsPendingAcceptanceCount => (vendorBookingsPendingAcceptanceCount ?? 0);
}
