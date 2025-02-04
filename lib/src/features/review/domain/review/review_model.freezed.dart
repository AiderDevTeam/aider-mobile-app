// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'review_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) {
  return _ReviewModel.fromJson(json);
}

/// @nodoc
mixin _$ReviewModel {
  int? get id => throw _privateConstructorUsedError;
  String? get externalId => throw _privateConstructorUsedError;
  int? get rating => throw _privateConstructorUsedError;
  String? get productUid => throw _privateConstructorUsedError;
  String? get renterUid => throw _privateConstructorUsedError;
  String? get vendorUid => throw _privateConstructorUsedError;
  String? get comment => throw _privateConstructorUsedError;
  String? get postedAt => throw _privateConstructorUsedError;
  String? get time => throw _privateConstructorUsedError;
  String? get date => throw _privateConstructorUsedError;
  UserModel? get reviewer => throw _privateConstructorUsedError;

  /// Serializes this ReviewModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReviewModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReviewModelCopyWith<ReviewModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReviewModelCopyWith<$Res> {
  factory $ReviewModelCopyWith(
          ReviewModel value, $Res Function(ReviewModel) then) =
      _$ReviewModelCopyWithImpl<$Res, ReviewModel>;
  @useResult
  $Res call(
      {int? id,
      String? externalId,
      int? rating,
      String? productUid,
      String? renterUid,
      String? vendorUid,
      String? comment,
      String? postedAt,
      String? time,
      String? date,
      UserModel? reviewer});

  $UserModelCopyWith<$Res>? get reviewer;
}

/// @nodoc
class _$ReviewModelCopyWithImpl<$Res, $Val extends ReviewModel>
    implements $ReviewModelCopyWith<$Res> {
  _$ReviewModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReviewModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? externalId = freezed,
    Object? rating = freezed,
    Object? productUid = freezed,
    Object? renterUid = freezed,
    Object? vendorUid = freezed,
    Object? comment = freezed,
    Object? postedAt = freezed,
    Object? time = freezed,
    Object? date = freezed,
    Object? reviewer = freezed,
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
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as int?,
      productUid: freezed == productUid
          ? _value.productUid
          : productUid // ignore: cast_nullable_to_non_nullable
              as String?,
      renterUid: freezed == renterUid
          ? _value.renterUid
          : renterUid // ignore: cast_nullable_to_non_nullable
              as String?,
      vendorUid: freezed == vendorUid
          ? _value.vendorUid
          : vendorUid // ignore: cast_nullable_to_non_nullable
              as String?,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      postedAt: freezed == postedAt
          ? _value.postedAt
          : postedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      time: freezed == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
      reviewer: freezed == reviewer
          ? _value.reviewer
          : reviewer // ignore: cast_nullable_to_non_nullable
              as UserModel?,
    ) as $Val);
  }

  /// Create a copy of ReviewModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res>? get reviewer {
    if (_value.reviewer == null) {
      return null;
    }

    return $UserModelCopyWith<$Res>(_value.reviewer!, (value) {
      return _then(_value.copyWith(reviewer: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ReviewModelImplCopyWith<$Res>
    implements $ReviewModelCopyWith<$Res> {
  factory _$$ReviewModelImplCopyWith(
          _$ReviewModelImpl value, $Res Function(_$ReviewModelImpl) then) =
      __$$ReviewModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? externalId,
      int? rating,
      String? productUid,
      String? renterUid,
      String? vendorUid,
      String? comment,
      String? postedAt,
      String? time,
      String? date,
      UserModel? reviewer});

  @override
  $UserModelCopyWith<$Res>? get reviewer;
}

/// @nodoc
class __$$ReviewModelImplCopyWithImpl<$Res>
    extends _$ReviewModelCopyWithImpl<$Res, _$ReviewModelImpl>
    implements _$$ReviewModelImplCopyWith<$Res> {
  __$$ReviewModelImplCopyWithImpl(
      _$ReviewModelImpl _value, $Res Function(_$ReviewModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReviewModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? externalId = freezed,
    Object? rating = freezed,
    Object? productUid = freezed,
    Object? renterUid = freezed,
    Object? vendorUid = freezed,
    Object? comment = freezed,
    Object? postedAt = freezed,
    Object? time = freezed,
    Object? date = freezed,
    Object? reviewer = freezed,
  }) {
    return _then(_$ReviewModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      externalId: freezed == externalId
          ? _value.externalId
          : externalId // ignore: cast_nullable_to_non_nullable
              as String?,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as int?,
      productUid: freezed == productUid
          ? _value.productUid
          : productUid // ignore: cast_nullable_to_non_nullable
              as String?,
      renterUid: freezed == renterUid
          ? _value.renterUid
          : renterUid // ignore: cast_nullable_to_non_nullable
              as String?,
      vendorUid: freezed == vendorUid
          ? _value.vendorUid
          : vendorUid // ignore: cast_nullable_to_non_nullable
              as String?,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      postedAt: freezed == postedAt
          ? _value.postedAt
          : postedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      time: freezed == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
      reviewer: freezed == reviewer
          ? _value.reviewer
          : reviewer // ignore: cast_nullable_to_non_nullable
              as UserModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReviewModelImpl implements _ReviewModel {
  const _$ReviewModelImpl(
      {this.id,
      this.externalId,
      this.rating,
      this.productUid,
      this.renterUid,
      this.vendorUid,
      this.comment,
      this.postedAt,
      this.time,
      this.date,
      this.reviewer});

  factory _$ReviewModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReviewModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? externalId;
  @override
  final int? rating;
  @override
  final String? productUid;
  @override
  final String? renterUid;
  @override
  final String? vendorUid;
  @override
  final String? comment;
  @override
  final String? postedAt;
  @override
  final String? time;
  @override
  final String? date;
  @override
  final UserModel? reviewer;

  @override
  String toString() {
    return 'ReviewModel(id: $id, externalId: $externalId, rating: $rating, productUid: $productUid, renterUid: $renterUid, vendorUid: $vendorUid, comment: $comment, postedAt: $postedAt, time: $time, date: $date, reviewer: $reviewer)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReviewModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.externalId, externalId) ||
                other.externalId == externalId) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.productUid, productUid) ||
                other.productUid == productUid) &&
            (identical(other.renterUid, renterUid) ||
                other.renterUid == renterUid) &&
            (identical(other.vendorUid, vendorUid) ||
                other.vendorUid == vendorUid) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.postedAt, postedAt) ||
                other.postedAt == postedAt) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.reviewer, reviewer) ||
                other.reviewer == reviewer));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      externalId,
      rating,
      productUid,
      renterUid,
      vendorUid,
      comment,
      postedAt,
      time,
      date,
      reviewer);

  /// Create a copy of ReviewModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReviewModelImplCopyWith<_$ReviewModelImpl> get copyWith =>
      __$$ReviewModelImplCopyWithImpl<_$ReviewModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReviewModelImplToJson(
      this,
    );
  }
}

abstract class _ReviewModel implements ReviewModel {
  const factory _ReviewModel(
      {final int? id,
      final String? externalId,
      final int? rating,
      final String? productUid,
      final String? renterUid,
      final String? vendorUid,
      final String? comment,
      final String? postedAt,
      final String? time,
      final String? date,
      final UserModel? reviewer}) = _$ReviewModelImpl;

  factory _ReviewModel.fromJson(Map<String, dynamic> json) =
      _$ReviewModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get externalId;
  @override
  int? get rating;
  @override
  String? get productUid;
  @override
  String? get renterUid;
  @override
  String? get vendorUid;
  @override
  String? get comment;
  @override
  String? get postedAt;
  @override
  String? get time;
  @override
  String? get date;
  @override
  UserModel? get reviewer;

  /// Create a copy of ReviewModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReviewModelImplCopyWith<_$ReviewModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
