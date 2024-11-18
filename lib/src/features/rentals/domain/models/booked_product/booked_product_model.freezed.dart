// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booked_product_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BookedProductModel _$BookedProductModelFromJson(Map<String, dynamic> json) {
  return _BookedProductModel.fromJson(json);
}

/// @nodoc
mixin _$BookedProductModel {
  int? get id => throw _privateConstructorUsedError;
  String? get externalId => throw _privateConstructorUsedError;
  num? get amount => throw _privateConstructorUsedError;
  int? get quantity => throw _privateConstructorUsedError;
  num? get value => throw _privateConstructorUsedError;
  String? get startDate => throw _privateConstructorUsedError;
  String? get endDate => throw _privateConstructorUsedError;
  int? get duration => throw _privateConstructorUsedError;
  int? get daysSpan => throw _privateConstructorUsedError;
  bool? get isOverdue => throw _privateConstructorUsedError;
  bool? get returnedEarly => throw _privateConstructorUsedError;
  ProductModel? get product => throw _privateConstructorUsedError;
  bool? get isReviewed => throw _privateConstructorUsedError;
  ReviewModel? get review => throw _privateConstructorUsedError;
  ReviewModel? get renterReview => throw _privateConstructorUsedError;
  ExchangeScheduleModel? get exchangeSchedule =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BookedProductModelCopyWith<BookedProductModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookedProductModelCopyWith<$Res> {
  factory $BookedProductModelCopyWith(
          BookedProductModel value, $Res Function(BookedProductModel) then) =
      _$BookedProductModelCopyWithImpl<$Res, BookedProductModel>;
  @useResult
  $Res call(
      {int? id,
      String? externalId,
      num? amount,
      int? quantity,
      num? value,
      String? startDate,
      String? endDate,
      int? duration,
      int? daysSpan,
      bool? isOverdue,
      bool? returnedEarly,
      ProductModel? product,
      bool? isReviewed,
      ReviewModel? review,
      ReviewModel? renterReview,
      ExchangeScheduleModel? exchangeSchedule});

  $ProductModelCopyWith<$Res>? get product;
  $ReviewModelCopyWith<$Res>? get review;
  $ReviewModelCopyWith<$Res>? get renterReview;
  $ExchangeScheduleModelCopyWith<$Res>? get exchangeSchedule;
}

/// @nodoc
class _$BookedProductModelCopyWithImpl<$Res, $Val extends BookedProductModel>
    implements $BookedProductModelCopyWith<$Res> {
  _$BookedProductModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? externalId = freezed,
    Object? amount = freezed,
    Object? quantity = freezed,
    Object? value = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? duration = freezed,
    Object? daysSpan = freezed,
    Object? isOverdue = freezed,
    Object? returnedEarly = freezed,
    Object? product = freezed,
    Object? isReviewed = freezed,
    Object? review = freezed,
    Object? renterReview = freezed,
    Object? exchangeSchedule = freezed,
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
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as num?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int?,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as num?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String?,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int?,
      daysSpan: freezed == daysSpan
          ? _value.daysSpan
          : daysSpan // ignore: cast_nullable_to_non_nullable
              as int?,
      isOverdue: freezed == isOverdue
          ? _value.isOverdue
          : isOverdue // ignore: cast_nullable_to_non_nullable
              as bool?,
      returnedEarly: freezed == returnedEarly
          ? _value.returnedEarly
          : returnedEarly // ignore: cast_nullable_to_non_nullable
              as bool?,
      product: freezed == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as ProductModel?,
      isReviewed: freezed == isReviewed
          ? _value.isReviewed
          : isReviewed // ignore: cast_nullable_to_non_nullable
              as bool?,
      review: freezed == review
          ? _value.review
          : review // ignore: cast_nullable_to_non_nullable
              as ReviewModel?,
      renterReview: freezed == renterReview
          ? _value.renterReview
          : renterReview // ignore: cast_nullable_to_non_nullable
              as ReviewModel?,
      exchangeSchedule: freezed == exchangeSchedule
          ? _value.exchangeSchedule
          : exchangeSchedule // ignore: cast_nullable_to_non_nullable
              as ExchangeScheduleModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ProductModelCopyWith<$Res>? get product {
    if (_value.product == null) {
      return null;
    }

    return $ProductModelCopyWith<$Res>(_value.product!, (value) {
      return _then(_value.copyWith(product: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ReviewModelCopyWith<$Res>? get review {
    if (_value.review == null) {
      return null;
    }

    return $ReviewModelCopyWith<$Res>(_value.review!, (value) {
      return _then(_value.copyWith(review: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ReviewModelCopyWith<$Res>? get renterReview {
    if (_value.renterReview == null) {
      return null;
    }

    return $ReviewModelCopyWith<$Res>(_value.renterReview!, (value) {
      return _then(_value.copyWith(renterReview: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ExchangeScheduleModelCopyWith<$Res>? get exchangeSchedule {
    if (_value.exchangeSchedule == null) {
      return null;
    }

    return $ExchangeScheduleModelCopyWith<$Res>(_value.exchangeSchedule!,
        (value) {
      return _then(_value.copyWith(exchangeSchedule: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BookedProductModelImplCopyWith<$Res>
    implements $BookedProductModelCopyWith<$Res> {
  factory _$$BookedProductModelImplCopyWith(_$BookedProductModelImpl value,
          $Res Function(_$BookedProductModelImpl) then) =
      __$$BookedProductModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? externalId,
      num? amount,
      int? quantity,
      num? value,
      String? startDate,
      String? endDate,
      int? duration,
      int? daysSpan,
      bool? isOverdue,
      bool? returnedEarly,
      ProductModel? product,
      bool? isReviewed,
      ReviewModel? review,
      ReviewModel? renterReview,
      ExchangeScheduleModel? exchangeSchedule});

  @override
  $ProductModelCopyWith<$Res>? get product;
  @override
  $ReviewModelCopyWith<$Res>? get review;
  @override
  $ReviewModelCopyWith<$Res>? get renterReview;
  @override
  $ExchangeScheduleModelCopyWith<$Res>? get exchangeSchedule;
}

/// @nodoc
class __$$BookedProductModelImplCopyWithImpl<$Res>
    extends _$BookedProductModelCopyWithImpl<$Res, _$BookedProductModelImpl>
    implements _$$BookedProductModelImplCopyWith<$Res> {
  __$$BookedProductModelImplCopyWithImpl(_$BookedProductModelImpl _value,
      $Res Function(_$BookedProductModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? externalId = freezed,
    Object? amount = freezed,
    Object? quantity = freezed,
    Object? value = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? duration = freezed,
    Object? daysSpan = freezed,
    Object? isOverdue = freezed,
    Object? returnedEarly = freezed,
    Object? product = freezed,
    Object? isReviewed = freezed,
    Object? review = freezed,
    Object? renterReview = freezed,
    Object? exchangeSchedule = freezed,
  }) {
    return _then(_$BookedProductModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      externalId: freezed == externalId
          ? _value.externalId
          : externalId // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as num?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int?,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as num?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String?,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int?,
      daysSpan: freezed == daysSpan
          ? _value.daysSpan
          : daysSpan // ignore: cast_nullable_to_non_nullable
              as int?,
      isOverdue: freezed == isOverdue
          ? _value.isOverdue
          : isOverdue // ignore: cast_nullable_to_non_nullable
              as bool?,
      returnedEarly: freezed == returnedEarly
          ? _value.returnedEarly
          : returnedEarly // ignore: cast_nullable_to_non_nullable
              as bool?,
      product: freezed == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as ProductModel?,
      isReviewed: freezed == isReviewed
          ? _value.isReviewed
          : isReviewed // ignore: cast_nullable_to_non_nullable
              as bool?,
      review: freezed == review
          ? _value.review
          : review // ignore: cast_nullable_to_non_nullable
              as ReviewModel?,
      renterReview: freezed == renterReview
          ? _value.renterReview
          : renterReview // ignore: cast_nullable_to_non_nullable
              as ReviewModel?,
      exchangeSchedule: freezed == exchangeSchedule
          ? _value.exchangeSchedule
          : exchangeSchedule // ignore: cast_nullable_to_non_nullable
              as ExchangeScheduleModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BookedProductModelImpl extends _BookedProductModel {
  const _$BookedProductModelImpl(
      {this.id,
      this.externalId,
      this.amount,
      this.quantity,
      this.value,
      this.startDate,
      this.endDate,
      this.duration,
      this.daysSpan,
      this.isOverdue,
      this.returnedEarly,
      this.product,
      this.isReviewed,
      this.review,
      this.renterReview,
      this.exchangeSchedule})
      : super._();

  factory _$BookedProductModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookedProductModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? externalId;
  @override
  final num? amount;
  @override
  final int? quantity;
  @override
  final num? value;
  @override
  final String? startDate;
  @override
  final String? endDate;
  @override
  final int? duration;
  @override
  final int? daysSpan;
  @override
  final bool? isOverdue;
  @override
  final bool? returnedEarly;
  @override
  final ProductModel? product;
  @override
  final bool? isReviewed;
  @override
  final ReviewModel? review;
  @override
  final ReviewModel? renterReview;
  @override
  final ExchangeScheduleModel? exchangeSchedule;

  @override
  String toString() {
    return 'BookedProductModel(id: $id, externalId: $externalId, amount: $amount, quantity: $quantity, value: $value, startDate: $startDate, endDate: $endDate, duration: $duration, daysSpan: $daysSpan, isOverdue: $isOverdue, returnedEarly: $returnedEarly, product: $product, isReviewed: $isReviewed, review: $review, renterReview: $renterReview, exchangeSchedule: $exchangeSchedule)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookedProductModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.externalId, externalId) ||
                other.externalId == externalId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.daysSpan, daysSpan) ||
                other.daysSpan == daysSpan) &&
            (identical(other.isOverdue, isOverdue) ||
                other.isOverdue == isOverdue) &&
            (identical(other.returnedEarly, returnedEarly) ||
                other.returnedEarly == returnedEarly) &&
            (identical(other.product, product) || other.product == product) &&
            (identical(other.isReviewed, isReviewed) ||
                other.isReviewed == isReviewed) &&
            (identical(other.review, review) || other.review == review) &&
            (identical(other.renterReview, renterReview) ||
                other.renterReview == renterReview) &&
            (identical(other.exchangeSchedule, exchangeSchedule) ||
                other.exchangeSchedule == exchangeSchedule));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      externalId,
      amount,
      quantity,
      value,
      startDate,
      endDate,
      duration,
      daysSpan,
      isOverdue,
      returnedEarly,
      product,
      isReviewed,
      review,
      renterReview,
      exchangeSchedule);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BookedProductModelImplCopyWith<_$BookedProductModelImpl> get copyWith =>
      __$$BookedProductModelImplCopyWithImpl<_$BookedProductModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookedProductModelImplToJson(
      this,
    );
  }
}

abstract class _BookedProductModel extends BookedProductModel {
  const factory _BookedProductModel(
          {final int? id,
          final String? externalId,
          final num? amount,
          final int? quantity,
          final num? value,
          final String? startDate,
          final String? endDate,
          final int? duration,
          final int? daysSpan,
          final bool? isOverdue,
          final bool? returnedEarly,
          final ProductModel? product,
          final bool? isReviewed,
          final ReviewModel? review,
          final ReviewModel? renterReview,
          final ExchangeScheduleModel? exchangeSchedule}) =
      _$BookedProductModelImpl;
  const _BookedProductModel._() : super._();

  factory _BookedProductModel.fromJson(Map<String, dynamic> json) =
      _$BookedProductModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get externalId;
  @override
  num? get amount;
  @override
  int? get quantity;
  @override
  num? get value;
  @override
  String? get startDate;
  @override
  String? get endDate;
  @override
  int? get duration;
  @override
  int? get daysSpan;
  @override
  bool? get isOverdue;
  @override
  bool? get returnedEarly;
  @override
  ProductModel? get product;
  @override
  bool? get isReviewed;
  @override
  ReviewModel? get review;
  @override
  ReviewModel? get renterReview;
  @override
  ExchangeScheduleModel? get exchangeSchedule;
  @override
  @JsonKey(ignore: true)
  _$$BookedProductModelImplCopyWith<_$BookedProductModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
