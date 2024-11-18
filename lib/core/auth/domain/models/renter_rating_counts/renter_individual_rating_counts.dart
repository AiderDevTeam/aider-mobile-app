import 'package:freezed_annotation/freezed_annotation.dart';


part 'renter_individual_rating_counts.freezed.dart';
part 'renter_individual_rating_counts.g.dart';


@freezed
class RenterIndividualRatingCountsModel with _$RenterIndividualRatingCountsModel {
  const factory RenterIndividualRatingCountsModel({
    final int? id,
    final int? oneRating,
    final int? twoRating,
    final int? threeRating,
    final int? fourRating,
    final int? fiveRating,
  }) = _RenterIndividualRatingCountsModel;

  factory RenterIndividualRatingCountsModel.fromJson(Map<String, dynamic> json) =>
      _$RenterIndividualRatingCountsModelFromJson(json);
}