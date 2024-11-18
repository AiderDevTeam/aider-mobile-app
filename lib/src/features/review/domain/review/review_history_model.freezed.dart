// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'review_history_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ReviewHistoryModel _$ReviewHistoryModelFromJson(Map<String, dynamic> json) {
  return _ReviewHistoryModel.fromJson(json);
}

/// @nodoc
mixin _$ReviewHistoryModel {
  List<ReviewModel> get data => throw _privateConstructorUsedError;
  PaginationModel? get meta => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReviewHistoryModelCopyWith<ReviewHistoryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReviewHistoryModelCopyWith<$Res> {
  factory $ReviewHistoryModelCopyWith(
          ReviewHistoryModel value, $Res Function(ReviewHistoryModel) then) =
      _$ReviewHistoryModelCopyWithImpl<$Res, ReviewHistoryModel>;
  @useResult
  $Res call({List<ReviewModel> data, PaginationModel? meta});

  $PaginationModelCopyWith<$Res>? get meta;
}

/// @nodoc
class _$ReviewHistoryModelCopyWithImpl<$Res, $Val extends ReviewHistoryModel>
    implements $ReviewHistoryModelCopyWith<$Res> {
  _$ReviewHistoryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
              as List<ReviewModel>,
      meta: freezed == meta
          ? _value.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as PaginationModel?,
    ) as $Val);
  }

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
abstract class _$$ReviewHistoryModelImplCopyWith<$Res>
    implements $ReviewHistoryModelCopyWith<$Res> {
  factory _$$ReviewHistoryModelImplCopyWith(_$ReviewHistoryModelImpl value,
          $Res Function(_$ReviewHistoryModelImpl) then) =
      __$$ReviewHistoryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ReviewModel> data, PaginationModel? meta});

  @override
  $PaginationModelCopyWith<$Res>? get meta;
}

/// @nodoc
class __$$ReviewHistoryModelImplCopyWithImpl<$Res>
    extends _$ReviewHistoryModelCopyWithImpl<$Res, _$ReviewHistoryModelImpl>
    implements _$$ReviewHistoryModelImplCopyWith<$Res> {
  __$$ReviewHistoryModelImplCopyWithImpl(_$ReviewHistoryModelImpl _value,
      $Res Function(_$ReviewHistoryModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? meta = freezed,
  }) {
    return _then(_$ReviewHistoryModelImpl(
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<ReviewModel>,
      meta: freezed == meta
          ? _value.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as PaginationModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReviewHistoryModelImpl implements _ReviewHistoryModel {
  const _$ReviewHistoryModelImpl(
      {final List<ReviewModel> data = const [], this.meta})
      : _data = data;

  factory _$ReviewHistoryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReviewHistoryModelImplFromJson(json);

  final List<ReviewModel> _data;
  @override
  @JsonKey()
  List<ReviewModel> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  final PaginationModel? meta;

  @override
  String toString() {
    return 'ReviewHistoryModel(data: $data, meta: $meta)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReviewHistoryModelImpl &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.meta, meta) || other.meta == meta));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_data), meta);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReviewHistoryModelImplCopyWith<_$ReviewHistoryModelImpl> get copyWith =>
      __$$ReviewHistoryModelImplCopyWithImpl<_$ReviewHistoryModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReviewHistoryModelImplToJson(
      this,
    );
  }
}

abstract class _ReviewHistoryModel implements ReviewHistoryModel {
  const factory _ReviewHistoryModel(
      {final List<ReviewModel> data,
      final PaginationModel? meta}) = _$ReviewHistoryModelImpl;

  factory _ReviewHistoryModel.fromJson(Map<String, dynamic> json) =
      _$ReviewHistoryModelImpl.fromJson;

  @override
  List<ReviewModel> get data;
  @override
  PaginationModel? get meta;
  @override
  @JsonKey(ignore: true)
  _$$ReviewHistoryModelImplCopyWith<_$ReviewHistoryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
