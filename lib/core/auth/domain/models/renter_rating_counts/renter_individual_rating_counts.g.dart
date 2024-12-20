// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'renter_individual_rating_counts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RenterIndividualRatingCountsModelImpl
    _$$RenterIndividualRatingCountsModelImplFromJson(
            Map<String, dynamic> json) =>
        _$RenterIndividualRatingCountsModelImpl(
          id: (json['id'] as num?)?.toInt(),
          oneRating: (json['oneRating'] as num?)?.toInt(),
          twoRating: (json['twoRating'] as num?)?.toInt(),
          threeRating: (json['threeRating'] as num?)?.toInt(),
          fourRating: (json['fourRating'] as num?)?.toInt(),
          fiveRating: (json['fiveRating'] as num?)?.toInt(),
        );

Map<String, dynamic> _$$RenterIndividualRatingCountsModelImplToJson(
        _$RenterIndividualRatingCountsModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'oneRating': instance.oneRating,
      'twoRating': instance.twoRating,
      'threeRating': instance.threeRating,
      'fourRating': instance.fourRating,
      'fiveRating': instance.fiveRating,
    };
