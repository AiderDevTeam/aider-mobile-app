// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booked_history_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BookedProductHistoryModel _$BookedProductHistoryModelFromJson(
    Map<String, dynamic> json) {
  return _BookedProductHistoryModel.fromJson(json);
}

/// @nodoc
mixin _$BookedProductHistoryModel {
  List<BookingModel> get data => throw _privateConstructorUsedError;
  PaginationModel? get meta => throw _privateConstructorUsedError;

  /// Serializes this BookedProductHistoryModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BookedProductHistoryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookedProductHistoryModelCopyWith<BookedProductHistoryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookedProductHistoryModelCopyWith<$Res> {
  factory $BookedProductHistoryModelCopyWith(BookedProductHistoryModel value,
          $Res Function(BookedProductHistoryModel) then) =
      _$BookedProductHistoryModelCopyWithImpl<$Res, BookedProductHistoryModel>;
  @useResult
  $Res call({List<BookingModel> data, PaginationModel? meta});

  $PaginationModelCopyWith<$Res>? get meta;
}

/// @nodoc
class _$BookedProductHistoryModelCopyWithImpl<$Res,
        $Val extends BookedProductHistoryModel>
    implements $BookedProductHistoryModelCopyWith<$Res> {
  _$BookedProductHistoryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookedProductHistoryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? meta = freezed,
  }) {
    return _then(_value.copyWith(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<BookingModel>,
      meta: freezed == meta
          ? _value.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as PaginationModel?,
    ) as $Val);
  }

  /// Create a copy of BookedProductHistoryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaginationModelCopyWith<$Res>? get meta {
    if (_value.meta == null) {
      return null;
    }

    return $PaginationModelCopyWith<$Res>(_value.meta!, (value) {
      return _then(_value.copyWith(meta: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BookedProductHistoryModelImplCopyWith<$Res>
    implements $BookedProductHistoryModelCopyWith<$Res> {
  factory _$$BookedProductHistoryModelImplCopyWith(
          _$BookedProductHistoryModelImpl value,
          $Res Function(_$BookedProductHistoryModelImpl) then) =
      __$$BookedProductHistoryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<BookingModel> data, PaginationModel? meta});

  @override
  $PaginationModelCopyWith<$Res>? get meta;
}

/// @nodoc
class __$$BookedProductHistoryModelImplCopyWithImpl<$Res>
    extends _$BookedProductHistoryModelCopyWithImpl<$Res,
        _$BookedProductHistoryModelImpl>
    implements _$$BookedProductHistoryModelImplCopyWith<$Res> {
  __$$BookedProductHistoryModelImplCopyWithImpl(
      _$BookedProductHistoryModelImpl _value,
      $Res Function(_$BookedProductHistoryModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookedProductHistoryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? meta = freezed,
  }) {
    return _then(_$BookedProductHistoryModelImpl(
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<BookingModel>,
      meta: freezed == meta
          ? _value.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as PaginationModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BookedProductHistoryModelImpl implements _BookedProductHistoryModel {
  const _$BookedProductHistoryModelImpl(
      {final List<BookingModel> data = const [], this.meta})
      : _data = data;

  factory _$BookedProductHistoryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookedProductHistoryModelImplFromJson(json);

  final List<BookingModel> _data;
  @override
  @JsonKey()
  List<BookingModel> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  final PaginationModel? meta;

  @override
  String toString() {
    return 'BookedProductHistoryModel(data: $data, meta: $meta)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookedProductHistoryModelImpl &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.meta, meta) || other.meta == meta));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_data), meta);

  /// Create a copy of BookedProductHistoryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookedProductHistoryModelImplCopyWith<_$BookedProductHistoryModelImpl>
      get copyWith => __$$BookedProductHistoryModelImplCopyWithImpl<
          _$BookedProductHistoryModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookedProductHistoryModelImplToJson(
      this,
    );
  }
}

abstract class _BookedProductHistoryModel implements BookedProductHistoryModel {
  const factory _BookedProductHistoryModel(
      {final List<BookingModel> data,
      final PaginationModel? meta}) = _$BookedProductHistoryModelImpl;

  factory _BookedProductHistoryModel.fromJson(Map<String, dynamic> json) =
      _$BookedProductHistoryModelImpl.fromJson;

  @override
  List<BookingModel> get data;
  @override
  PaginationModel? get meta;

  /// Create a copy of BookedProductHistoryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookedProductHistoryModelImplCopyWith<_$BookedProductHistoryModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
