// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'statistic_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StatisticModel _$StatisticModelFromJson(Map<String, dynamic> json) {
  return _StatisticModel.fromJson(json);
}

/// @nodoc
mixin _$StatisticModel {
  int? get id => throw _privateConstructorUsedError;
  int? get rentedItemsCount => throw _privateConstructorUsedError;
  int? get listedItemsCount => throw _privateConstructorUsedError;
  num? get vendorAverageRating => throw _privateConstructorUsedError;
  num? get renterAverageRating => throw _privateConstructorUsedError;
  int? get vendorReviewsCount => throw _privateConstructorUsedError;
  int? get renterReviewsCount => throw _privateConstructorUsedError;
  int? get pendingVendorBookingsCount => throw _privateConstructorUsedError;
  int? get pendingRenterBookingsCount => throw _privateConstructorUsedError;
  int? get vendorBookingsPendingAcceptanceCount =>
      throw _privateConstructorUsedError;
  VendorIndividualRatingCountsModel? get vendorIndividualRatingCounts =>
      throw _privateConstructorUsedError;
  RenterIndividualRatingCountsModel? get renterIndividualRatingCounts =>
      throw _privateConstructorUsedError;

  /// Serializes this StatisticModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StatisticModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StatisticModelCopyWith<StatisticModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatisticModelCopyWith<$Res> {
  factory $StatisticModelCopyWith(
          StatisticModel value, $Res Function(StatisticModel) then) =
      _$StatisticModelCopyWithImpl<$Res, StatisticModel>;
  @useResult
  $Res call(
      {int? id,
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
      RenterIndividualRatingCountsModel? renterIndividualRatingCounts});

  $VendorIndividualRatingCountsModelCopyWith<$Res>?
      get vendorIndividualRatingCounts;
  $RenterIndividualRatingCountsModelCopyWith<$Res>?
      get renterIndividualRatingCounts;
}

/// @nodoc
class _$StatisticModelCopyWithImpl<$Res, $Val extends StatisticModel>
    implements $StatisticModelCopyWith<$Res> {
  _$StatisticModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StatisticModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? rentedItemsCount = freezed,
    Object? listedItemsCount = freezed,
    Object? vendorAverageRating = freezed,
    Object? renterAverageRating = freezed,
    Object? vendorReviewsCount = freezed,
    Object? renterReviewsCount = freezed,
    Object? pendingVendorBookingsCount = freezed,
    Object? pendingRenterBookingsCount = freezed,
    Object? vendorBookingsPendingAcceptanceCount = freezed,
    Object? vendorIndividualRatingCounts = freezed,
    Object? renterIndividualRatingCounts = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      rentedItemsCount: freezed == rentedItemsCount
          ? _value.rentedItemsCount
          : rentedItemsCount // ignore: cast_nullable_to_non_nullable
              as int?,
      listedItemsCount: freezed == listedItemsCount
          ? _value.listedItemsCount
          : listedItemsCount // ignore: cast_nullable_to_non_nullable
              as int?,
      vendorAverageRating: freezed == vendorAverageRating
          ? _value.vendorAverageRating
          : vendorAverageRating // ignore: cast_nullable_to_non_nullable
              as num?,
      renterAverageRating: freezed == renterAverageRating
          ? _value.renterAverageRating
          : renterAverageRating // ignore: cast_nullable_to_non_nullable
              as num?,
      vendorReviewsCount: freezed == vendorReviewsCount
          ? _value.vendorReviewsCount
          : vendorReviewsCount // ignore: cast_nullable_to_non_nullable
              as int?,
      renterReviewsCount: freezed == renterReviewsCount
          ? _value.renterReviewsCount
          : renterReviewsCount // ignore: cast_nullable_to_non_nullable
              as int?,
      pendingVendorBookingsCount: freezed == pendingVendorBookingsCount
          ? _value.pendingVendorBookingsCount
          : pendingVendorBookingsCount // ignore: cast_nullable_to_non_nullable
              as int?,
      pendingRenterBookingsCount: freezed == pendingRenterBookingsCount
          ? _value.pendingRenterBookingsCount
          : pendingRenterBookingsCount // ignore: cast_nullable_to_non_nullable
              as int?,
      vendorBookingsPendingAcceptanceCount: freezed ==
              vendorBookingsPendingAcceptanceCount
          ? _value.vendorBookingsPendingAcceptanceCount
          : vendorBookingsPendingAcceptanceCount // ignore: cast_nullable_to_non_nullable
              as int?,
      vendorIndividualRatingCounts: freezed == vendorIndividualRatingCounts
          ? _value.vendorIndividualRatingCounts
          : vendorIndividualRatingCounts // ignore: cast_nullable_to_non_nullable
              as VendorIndividualRatingCountsModel?,
      renterIndividualRatingCounts: freezed == renterIndividualRatingCounts
          ? _value.renterIndividualRatingCounts
          : renterIndividualRatingCounts // ignore: cast_nullable_to_non_nullable
              as RenterIndividualRatingCountsModel?,
    ) as $Val);
  }

  /// Create a copy of StatisticModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $VendorIndividualRatingCountsModelCopyWith<$Res>?
      get vendorIndividualRatingCounts {
    if (_value.vendorIndividualRatingCounts == null) {
      return null;
    }

    return $VendorIndividualRatingCountsModelCopyWith<$Res>(
        _value.vendorIndividualRatingCounts!, (value) {
      return _then(
          _value.copyWith(vendorIndividualRatingCounts: value) as $Val);
    });
  }

  /// Create a copy of StatisticModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RenterIndividualRatingCountsModelCopyWith<$Res>?
      get renterIndividualRatingCounts {
    if (_value.renterIndividualRatingCounts == null) {
      return null;
    }

    return $RenterIndividualRatingCountsModelCopyWith<$Res>(
        _value.renterIndividualRatingCounts!, (value) {
      return _then(
          _value.copyWith(renterIndividualRatingCounts: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$StatisticModelImplCopyWith<$Res>
    implements $StatisticModelCopyWith<$Res> {
  factory _$$StatisticModelImplCopyWith(_$StatisticModelImpl value,
          $Res Function(_$StatisticModelImpl) then) =
      __$$StatisticModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
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
      RenterIndividualRatingCountsModel? renterIndividualRatingCounts});

  @override
  $VendorIndividualRatingCountsModelCopyWith<$Res>?
      get vendorIndividualRatingCounts;
  @override
  $RenterIndividualRatingCountsModelCopyWith<$Res>?
      get renterIndividualRatingCounts;
}

/// @nodoc
class __$$StatisticModelImplCopyWithImpl<$Res>
    extends _$StatisticModelCopyWithImpl<$Res, _$StatisticModelImpl>
    implements _$$StatisticModelImplCopyWith<$Res> {
  __$$StatisticModelImplCopyWithImpl(
      _$StatisticModelImpl _value, $Res Function(_$StatisticModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of StatisticModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? rentedItemsCount = freezed,
    Object? listedItemsCount = freezed,
    Object? vendorAverageRating = freezed,
    Object? renterAverageRating = freezed,
    Object? vendorReviewsCount = freezed,
    Object? renterReviewsCount = freezed,
    Object? pendingVendorBookingsCount = freezed,
    Object? pendingRenterBookingsCount = freezed,
    Object? vendorBookingsPendingAcceptanceCount = freezed,
    Object? vendorIndividualRatingCounts = freezed,
    Object? renterIndividualRatingCounts = freezed,
  }) {
    return _then(_$StatisticModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      rentedItemsCount: freezed == rentedItemsCount
          ? _value.rentedItemsCount
          : rentedItemsCount // ignore: cast_nullable_to_non_nullable
              as int?,
      listedItemsCount: freezed == listedItemsCount
          ? _value.listedItemsCount
          : listedItemsCount // ignore: cast_nullable_to_non_nullable
              as int?,
      vendorAverageRating: freezed == vendorAverageRating
          ? _value.vendorAverageRating
          : vendorAverageRating // ignore: cast_nullable_to_non_nullable
              as num?,
      renterAverageRating: freezed == renterAverageRating
          ? _value.renterAverageRating
          : renterAverageRating // ignore: cast_nullable_to_non_nullable
              as num?,
      vendorReviewsCount: freezed == vendorReviewsCount
          ? _value.vendorReviewsCount
          : vendorReviewsCount // ignore: cast_nullable_to_non_nullable
              as int?,
      renterReviewsCount: freezed == renterReviewsCount
          ? _value.renterReviewsCount
          : renterReviewsCount // ignore: cast_nullable_to_non_nullable
              as int?,
      pendingVendorBookingsCount: freezed == pendingVendorBookingsCount
          ? _value.pendingVendorBookingsCount
          : pendingVendorBookingsCount // ignore: cast_nullable_to_non_nullable
              as int?,
      pendingRenterBookingsCount: freezed == pendingRenterBookingsCount
          ? _value.pendingRenterBookingsCount
          : pendingRenterBookingsCount // ignore: cast_nullable_to_non_nullable
              as int?,
      vendorBookingsPendingAcceptanceCount: freezed ==
              vendorBookingsPendingAcceptanceCount
          ? _value.vendorBookingsPendingAcceptanceCount
          : vendorBookingsPendingAcceptanceCount // ignore: cast_nullable_to_non_nullable
              as int?,
      vendorIndividualRatingCounts: freezed == vendorIndividualRatingCounts
          ? _value.vendorIndividualRatingCounts
          : vendorIndividualRatingCounts // ignore: cast_nullable_to_non_nullable
              as VendorIndividualRatingCountsModel?,
      renterIndividualRatingCounts: freezed == renterIndividualRatingCounts
          ? _value.renterIndividualRatingCounts
          : renterIndividualRatingCounts // ignore: cast_nullable_to_non_nullable
              as RenterIndividualRatingCountsModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StatisticModelImpl extends _StatisticModel {
  const _$StatisticModelImpl(
      {this.id,
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
      this.renterIndividualRatingCounts})
      : super._();

  factory _$StatisticModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$StatisticModelImplFromJson(json);

  @override
  final int? id;
  @override
  final int? rentedItemsCount;
  @override
  final int? listedItemsCount;
  @override
  final num? vendorAverageRating;
  @override
  final num? renterAverageRating;
  @override
  final int? vendorReviewsCount;
  @override
  final int? renterReviewsCount;
  @override
  final int? pendingVendorBookingsCount;
  @override
  final int? pendingRenterBookingsCount;
  @override
  final int? vendorBookingsPendingAcceptanceCount;
  @override
  final VendorIndividualRatingCountsModel? vendorIndividualRatingCounts;
  @override
  final RenterIndividualRatingCountsModel? renterIndividualRatingCounts;

  @override
  String toString() {
    return 'StatisticModel(id: $id, rentedItemsCount: $rentedItemsCount, listedItemsCount: $listedItemsCount, vendorAverageRating: $vendorAverageRating, renterAverageRating: $renterAverageRating, vendorReviewsCount: $vendorReviewsCount, renterReviewsCount: $renterReviewsCount, pendingVendorBookingsCount: $pendingVendorBookingsCount, pendingRenterBookingsCount: $pendingRenterBookingsCount, vendorBookingsPendingAcceptanceCount: $vendorBookingsPendingAcceptanceCount, vendorIndividualRatingCounts: $vendorIndividualRatingCounts, renterIndividualRatingCounts: $renterIndividualRatingCounts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatisticModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.rentedItemsCount, rentedItemsCount) ||
                other.rentedItemsCount == rentedItemsCount) &&
            (identical(other.listedItemsCount, listedItemsCount) ||
                other.listedItemsCount == listedItemsCount) &&
            (identical(other.vendorAverageRating, vendorAverageRating) ||
                other.vendorAverageRating == vendorAverageRating) &&
            (identical(other.renterAverageRating, renterAverageRating) ||
                other.renterAverageRating == renterAverageRating) &&
            (identical(other.vendorReviewsCount, vendorReviewsCount) ||
                other.vendorReviewsCount == vendorReviewsCount) &&
            (identical(other.renterReviewsCount, renterReviewsCount) ||
                other.renterReviewsCount == renterReviewsCount) &&
            (identical(other.pendingVendorBookingsCount,
                    pendingVendorBookingsCount) ||
                other.pendingVendorBookingsCount ==
                    pendingVendorBookingsCount) &&
            (identical(other.pendingRenterBookingsCount,
                    pendingRenterBookingsCount) ||
                other.pendingRenterBookingsCount ==
                    pendingRenterBookingsCount) &&
            (identical(other.vendorBookingsPendingAcceptanceCount,
                    vendorBookingsPendingAcceptanceCount) ||
                other.vendorBookingsPendingAcceptanceCount ==
                    vendorBookingsPendingAcceptanceCount) &&
            (identical(other.vendorIndividualRatingCounts,
                    vendorIndividualRatingCounts) ||
                other.vendorIndividualRatingCounts ==
                    vendorIndividualRatingCounts) &&
            (identical(other.renterIndividualRatingCounts,
                    renterIndividualRatingCounts) ||
                other.renterIndividualRatingCounts ==
                    renterIndividualRatingCounts));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      rentedItemsCount,
      listedItemsCount,
      vendorAverageRating,
      renterAverageRating,
      vendorReviewsCount,
      renterReviewsCount,
      pendingVendorBookingsCount,
      pendingRenterBookingsCount,
      vendorBookingsPendingAcceptanceCount,
      vendorIndividualRatingCounts,
      renterIndividualRatingCounts);

  /// Create a copy of StatisticModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StatisticModelImplCopyWith<_$StatisticModelImpl> get copyWith =>
      __$$StatisticModelImplCopyWithImpl<_$StatisticModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StatisticModelImplToJson(
      this,
    );
  }
}

abstract class _StatisticModel extends StatisticModel {
  const factory _StatisticModel(
      {final int? id,
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
      final RenterIndividualRatingCountsModel?
          renterIndividualRatingCounts}) = _$StatisticModelImpl;
  const _StatisticModel._() : super._();

  factory _StatisticModel.fromJson(Map<String, dynamic> json) =
      _$StatisticModelImpl.fromJson;

  @override
  int? get id;
  @override
  int? get rentedItemsCount;
  @override
  int? get listedItemsCount;
  @override
  num? get vendorAverageRating;
  @override
  num? get renterAverageRating;
  @override
  int? get vendorReviewsCount;
  @override
  int? get renterReviewsCount;
  @override
  int? get pendingVendorBookingsCount;
  @override
  int? get pendingRenterBookingsCount;
  @override
  int? get vendorBookingsPendingAcceptanceCount;
  @override
  VendorIndividualRatingCountsModel? get vendorIndividualRatingCounts;
  @override
  RenterIndividualRatingCountsModel? get renterIndividualRatingCounts;

  /// Create a copy of StatisticModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StatisticModelImplCopyWith<_$StatisticModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
