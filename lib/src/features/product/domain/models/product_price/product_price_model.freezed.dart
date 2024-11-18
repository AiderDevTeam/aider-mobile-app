// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_price_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProductPriceModel _$ProductPriceModelFromJson(Map<String, dynamic> json) {
  return _ProductPriceModel.fromJson(json);
}

/// @nodoc
mixin _$ProductPriceModel {
  int? get id => throw _privateConstructorUsedError;
  String? get externalId => throw _privateConstructorUsedError;
  num? get price => throw _privateConstructorUsedError;
  int? get startDay => throw _privateConstructorUsedError;
  int? get endDay => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductPriceModelCopyWith<ProductPriceModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductPriceModelCopyWith<$Res> {
  factory $ProductPriceModelCopyWith(
          ProductPriceModel value, $Res Function(ProductPriceModel) then) =
      _$ProductPriceModelCopyWithImpl<$Res, ProductPriceModel>;
  @useResult
  $Res call(
      {int? id, String? externalId, num? price, int? startDay, int? endDay});
}

/// @nodoc
class _$ProductPriceModelCopyWithImpl<$Res, $Val extends ProductPriceModel>
    implements $ProductPriceModelCopyWith<$Res> {
  _$ProductPriceModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? externalId = freezed,
    Object? price = freezed,
    Object? startDay = freezed,
    Object? endDay = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      externalId: freezed == externalId
          ? _value.externalId
          : externalId // ignore: cast_nullable_to_non_nullable
              as String?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as num?,
      startDay: freezed == startDay
          ? _value.startDay
          : startDay // ignore: cast_nullable_to_non_nullable
              as int?,
      endDay: freezed == endDay
          ? _value.endDay
          : endDay // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductPriceModelImplCopyWith<$Res>
    implements $ProductPriceModelCopyWith<$Res> {
  factory _$$ProductPriceModelImplCopyWith(_$ProductPriceModelImpl value,
          $Res Function(_$ProductPriceModelImpl) then) =
      __$$ProductPriceModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id, String? externalId, num? price, int? startDay, int? endDay});
}

/// @nodoc
class __$$ProductPriceModelImplCopyWithImpl<$Res>
    extends _$ProductPriceModelCopyWithImpl<$Res, _$ProductPriceModelImpl>
    implements _$$ProductPriceModelImplCopyWith<$Res> {
  __$$ProductPriceModelImplCopyWithImpl(_$ProductPriceModelImpl _value,
      $Res Function(_$ProductPriceModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? externalId = freezed,
    Object? price = freezed,
    Object? startDay = freezed,
    Object? endDay = freezed,
  }) {
    return _then(_$ProductPriceModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      externalId: freezed == externalId
          ? _value.externalId
          : externalId // ignore: cast_nullable_to_non_nullable
              as String?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as num?,
      startDay: freezed == startDay
          ? _value.startDay
          : startDay // ignore: cast_nullable_to_non_nullable
              as int?,
      endDay: freezed == endDay
          ? _value.endDay
          : endDay // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductPriceModelImpl implements _ProductPriceModel {
  const _$ProductPriceModelImpl(
      {this.id, this.externalId, this.price, this.startDay, this.endDay});

  factory _$ProductPriceModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductPriceModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? externalId;
  @override
  final num? price;
  @override
  final int? startDay;
  @override
  final int? endDay;

  @override
  String toString() {
    return 'ProductPriceModel(id: $id, externalId: $externalId, price: $price, startDay: $startDay, endDay: $endDay)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductPriceModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.externalId, externalId) ||
                other.externalId == externalId) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.startDay, startDay) ||
                other.startDay == startDay) &&
            (identical(other.endDay, endDay) || other.endDay == endDay));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, externalId, price, startDay, endDay);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductPriceModelImplCopyWith<_$ProductPriceModelImpl> get copyWith =>
      __$$ProductPriceModelImplCopyWithImpl<_$ProductPriceModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductPriceModelImplToJson(
      this,
    );
  }
}

abstract class _ProductPriceModel implements ProductPriceModel {
  const factory _ProductPriceModel(
      {final int? id,
      final String? externalId,
      final num? price,
      final int? startDay,
      final int? endDay}) = _$ProductPriceModelImpl;

  factory _ProductPriceModel.fromJson(Map<String, dynamic> json) =
      _$ProductPriceModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get externalId;
  @override
  num? get price;
  @override
  int? get startDay;
  @override
  int? get endDay;
  @override
  @JsonKey(ignore: true)
  _$$ProductPriceModelImplCopyWith<_$ProductPriceModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
