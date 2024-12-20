// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_photo_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProductPhotoModel _$ProductPhotoModelFromJson(Map<String, dynamic> json) {
  return _ProductPhotoModel.fromJson(json);
}

/// @nodoc
mixin _$ProductPhotoModel {
  int? get id => throw _privateConstructorUsedError;
  String? get externalId => throw _privateConstructorUsedError;
  String? get photoUrl => throw _privateConstructorUsedError;

  /// Serializes this ProductPhotoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProductPhotoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductPhotoModelCopyWith<ProductPhotoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductPhotoModelCopyWith<$Res> {
  factory $ProductPhotoModelCopyWith(
          ProductPhotoModel value, $Res Function(ProductPhotoModel) then) =
      _$ProductPhotoModelCopyWithImpl<$Res, ProductPhotoModel>;
  @useResult
  $Res call({int? id, String? externalId, String? photoUrl});
}

/// @nodoc
class _$ProductPhotoModelCopyWithImpl<$Res, $Val extends ProductPhotoModel>
    implements $ProductPhotoModelCopyWith<$Res> {
  _$ProductPhotoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductPhotoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? externalId = freezed,
    Object? photoUrl = freezed,
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
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductPhotoModelImplCopyWith<$Res>
    implements $ProductPhotoModelCopyWith<$Res> {
  factory _$$ProductPhotoModelImplCopyWith(_$ProductPhotoModelImpl value,
          $Res Function(_$ProductPhotoModelImpl) then) =
      __$$ProductPhotoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? externalId, String? photoUrl});
}

/// @nodoc
class __$$ProductPhotoModelImplCopyWithImpl<$Res>
    extends _$ProductPhotoModelCopyWithImpl<$Res, _$ProductPhotoModelImpl>
    implements _$$ProductPhotoModelImplCopyWith<$Res> {
  __$$ProductPhotoModelImplCopyWithImpl(_$ProductPhotoModelImpl _value,
      $Res Function(_$ProductPhotoModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductPhotoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? externalId = freezed,
    Object? photoUrl = freezed,
  }) {
    return _then(_$ProductPhotoModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      externalId: freezed == externalId
          ? _value.externalId
          : externalId // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductPhotoModelImpl implements _ProductPhotoModel {
  const _$ProductPhotoModelImpl({this.id, this.externalId, this.photoUrl});

  factory _$ProductPhotoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductPhotoModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? externalId;
  @override
  final String? photoUrl;

  @override
  String toString() {
    return 'ProductPhotoModel(id: $id, externalId: $externalId, photoUrl: $photoUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductPhotoModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.externalId, externalId) ||
                other.externalId == externalId) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, externalId, photoUrl);

  /// Create a copy of ProductPhotoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductPhotoModelImplCopyWith<_$ProductPhotoModelImpl> get copyWith =>
      __$$ProductPhotoModelImplCopyWithImpl<_$ProductPhotoModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductPhotoModelImplToJson(
      this,
    );
  }
}

abstract class _ProductPhotoModel implements ProductPhotoModel {
  const factory _ProductPhotoModel(
      {final int? id,
      final String? externalId,
      final String? photoUrl}) = _$ProductPhotoModelImpl;

  factory _ProductPhotoModel.fromJson(Map<String, dynamic> json) =
      _$ProductPhotoModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get externalId;
  @override
  String? get photoUrl;

  /// Create a copy of ProductPhotoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductPhotoModelImplCopyWith<_$ProductPhotoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
