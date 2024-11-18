import 'package:freezed_annotation/freezed_annotation.dart';


part 'vendor_individual_rating_counts.freezed.dart';
part 'vendor_individual_rating_counts.g.dart';


@freezed
class VendorIndividualRatingCountsModel with _$VendorIndividualRatingCountsModel {
  const factory VendorIndividualRatingCountsModel({
    final int? id,
    final int? oneRating,
    final int? twoRating,
    final int? threeRating,
    final int? fourRating,
    final int? fiveRating,
  }) = _VendorIndividualRatingCountsModel;

  factory VendorIndividualRatingCountsModel.fromJson(Map<String, dynamic> json) =>
      _$VendorIndividualRatingCountsModelFromJson(json);
}