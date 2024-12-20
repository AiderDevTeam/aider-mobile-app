// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_history_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProductHistoryModel _$ProductHistoryModelFromJson(Map<String, dynamic> json) {
  return _ProductHistoryModel.fromJson(json);
}

/// @nodoc
mixin _$ProductHistoryModel {
  List<ProductModel> get data => throw _privateConstructorUsedError;
  PaginationModel? get meta => throw _privateConstructorUsedError;

  /// Serializes this ProductHistoryModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProductHistoryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductHistoryModelCopyWith<ProductHistoryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductHistoryModelCopyWith<$Res> {
  factory $ProductHistoryModelCopyWith(
          ProductHistoryModel value, $Res Function(ProductHistoryModel) then) =
      _$ProductHistoryModelCopyWithImpl<$Res, ProductHistoryModel>;
  @useResult
  $Res call({List<ProductModel> data, PaginationModel? meta});

  $PaginationModelCopyWith<$Res>? get meta;
}

/// @nodoc
class _$ProductHistoryModelCopyWithImpl<$Res, $Val extends ProductHistoryModel>
    implements $ProductHistoryModelCopyWith<$Res> {
  _$ProductHistoryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductHistoryModel
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
              as List<ProductModel>,
      meta: freezed == meta
          ? _value.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as PaginationModel?,
    ) as $Val);
  }

  /// Create a copy of ProductHistoryModel
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
abstract class _$$ProductHistoryModelImplCopyWith<$Res>
    implements $ProductHistoryModelCopyWith<$Res> {
  factory _$$ProductHistoryModelImplCopyWith(_$ProductHistoryModelImpl value,
          $Res Function(_$ProductHistoryModelImpl) then) =
      __$$ProductHistoryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ProductModel> data, PaginationModel? meta});

  @override
  $PaginationModelCopyWith<$Res>? get meta;
}

/// @nodoc
class __$$ProductHistoryModelImplCopyWithImpl<$Res>
    extends _$ProductHistoryModelCopyWithImpl<$Res, _$ProductHistoryModelImpl>
    implements _$$ProductHistoryModelImplCopyWith<$Res> {
  __$$ProductHistoryModelImplCopyWithImpl(_$ProductHistoryModelImpl _value,
      $Res Function(_$ProductHistoryModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductHistoryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? meta = freezed,
  }) {
    return _then(_$ProductHistoryModelImpl(
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<ProductModel>,
      meta: freezed == meta
          ? _value.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as PaginationModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductHistoryModelImpl implements _ProductHistoryModel {
  const _$ProductHistoryModelImpl(
      {final List<ProductModel> data = const [], this.meta})
      : _data = data;

  factory _$ProductHistoryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductHistoryModelImplFromJson(json);

  final List<ProductModel> _data;
  @override
  @JsonKey()
  List<ProductModel> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  final PaginationModel? meta;

  @override
  String toString() {
    return 'ProductHistoryModel(data: $data, meta: $meta)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductHistoryModelImpl &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.meta, meta) || other.meta == meta));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_data), meta);

  /// Create a copy of ProductHistoryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductHistoryModelImplCopyWith<_$ProductHistoryModelImpl> get copyWith =>
      __$$ProductHistoryModelImplCopyWithImpl<_$ProductHistoryModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductHistoryModelImplToJson(
      this,
    );
  }
}

abstract class _ProductHistoryModel implements ProductHistoryModel {
  const factory _ProductHistoryModel(
      {final List<ProductModel> data,
      final PaginationModel? meta}) = _$ProductHistoryModelImpl;

  factory _ProductHistoryModel.fromJson(Map<String, dynamic> json) =
      _$ProductHistoryModelImpl.fromJson;

  @override
  List<ProductModel> get data;
  @override
  PaginationModel? get meta;

  /// Create a copy of ProductHistoryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductHistoryModelImplCopyWith<_$ProductHistoryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
