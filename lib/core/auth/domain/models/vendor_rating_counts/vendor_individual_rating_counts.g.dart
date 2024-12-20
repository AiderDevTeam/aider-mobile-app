// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor_individual_rating_counts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VendorIndividualRatingCountsModelImpl
    _$$VendorIndividualRatingCountsModelImplFromJson(
            Map<String, dynamic> json) =>
        _$VendorIndividualRatingCountsModelImpl(
          id: (json['id'] as num?)?.toInt(),
          oneRating: (json['oneRating'] as num?)?.toInt(),
          twoRating: (json['twoRating'] as num?)?.toInt(),
          threeRating: (json['threeRating'] as num?)?.toInt(),
          fourRating: (json['fourRating'] as num?)?.toInt(),
          fiveRating: (json['fiveRating'] as num?)?.toInt(),
        );

Map<String, dynamic> _$$VendorIndividualRatingCountsModelImplToJson(
        _$VendorIndividualRatingCountsModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'oneRating': instance.oneRating,
      'twoRating': instance.twoRating,
      'threeRating': instance.threeRating,
      'fourRating': instance.fourRating,
      'fiveRating': instance.fiveRating,
    };
