// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_prediction_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LocationPredictionModel _$LocationPredictionModelFromJson(
    Map<String, dynamic> json) {
  return _LocationPredictionModel.fromJson(json);
}

/// @nodoc
mixin _$LocationPredictionModel {
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'place_id')
  String? get placeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'structured_formatting')
  Map<String, dynamic>? get structuredFormatting =>
      throw _privateConstructorUsedError;

  /// Serializes this LocationPredictionModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LocationPredictionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LocationPredictionModelCopyWith<LocationPredictionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationPredictionModelCopyWith<$Res> {
  factory $LocationPredictionModelCopyWith(LocationPredictionModel value,
          $Res Function(LocationPredictionModel) then) =
      _$LocationPredictionModelCopyWithImpl<$Res, LocationPredictionModel>;
  @useResult
  $Res call(
      {String? description,
      @JsonKey(name: 'place_id') String? placeId,
      @JsonKey(name: 'structured_formatting')
      Map<String, dynamic>? structuredFormatting});
}

/// @nodoc
class _$LocationPredictionModelCopyWithImpl<$Res,
        $Val extends LocationPredictionModel>
    implements $LocationPredictionModelCopyWith<$Res> {
  _$LocationPredictionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LocationPredictionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = freezed,
    Object? placeId = freezed,
    Object? structuredFormatting = freezed,
  }) {
    return _then(_value.copyWith(
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      placeId: freezed == placeId
          ? _value.placeId
          : placeId // ignore: cast_nullable_to_non_nullable
              as String?,
      structuredFormatting: freezed == structuredFormatting
          ? _value.structuredFormatting
          : structuredFormatting // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LocationPredictionModelImplCopyWith<$Res>
    implements $LocationPredictionModelCopyWith<$Res> {
  factory _$$LocationPredictionModelImplCopyWith(
          _$LocationPredictionModelImpl value,
          $Res Function(_$LocationPredictionModelImpl) then) =
      __$$LocationPredictionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? description,
      @JsonKey(name: 'place_id') String? placeId,
      @JsonKey(name: 'structured_formatting')
      Map<String, dynamic>? structuredFormatting});
}

/// @nodoc
class __$$LocationPredictionModelImplCopyWithImpl<$Res>
    extends _$LocationPredictionModelCopyWithImpl<$Res,
        _$LocationPredictionModelImpl>
    implements _$$LocationPredictionModelImplCopyWith<$Res> {
  __$$LocationPredictionModelImplCopyWithImpl(
      _$LocationPredictionModelImpl _value,
      $Res Function(_$LocationPredictionModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of LocationPredictionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = freezed,
    Object? placeId = freezed,
    Object? structuredFormatting = freezed,
  }) {
    return _then(_$LocationPredictionModelImpl(
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      placeId: freezed == placeId
          ? _value.placeId
          : placeId // ignore: cast_nullable_to_non_nullable
              as String?,
      structuredFormatting: freezed == structuredFormatting
          ? _value._structuredFormatting
          : structuredFormatting // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LocationPredictionModelImpl implements _LocationPredictionModel {
  const _$LocationPredictionModelImpl(
      {this.description,
      @JsonKey(name: 'place_id') this.placeId,
      @JsonKey(name: 'structured_formatting')
      final Map<String, dynamic>? structuredFormatting})
      : _structuredFormatting = structuredFormatting;

  factory _$LocationPredictionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LocationPredictionModelImplFromJson(json);

  @override
  final String? description;
  @override
  @JsonKey(name: 'place_id')
  final String? placeId;
  final Map<String, dynamic>? _structuredFormatting;
  @override
  @JsonKey(name: 'structured_formatting')
  Map<String, dynamic>? get structuredFormatting {
    final value = _structuredFormatting;
    if (value == null) return null;
    if (_structuredFormatting is EqualUnmodifiableMapView)
      return _structuredFormatting;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'LocationPredictionModel(description: $description, placeId: $placeId, structuredFormatting: $structuredFormatting)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationPredictionModelImpl &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.placeId, placeId) || other.placeId == placeId) &&
            const DeepCollectionEquality()
                .equals(other._structuredFormatting, _structuredFormatting));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, description, placeId,
      const DeepCollectionEquality().hash(_structuredFormatting));

  /// Create a copy of LocationPredictionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationPredictionModelImplCopyWith<_$LocationPredictionModelImpl>
      get copyWith => __$$LocationPredictionModelImplCopyWithImpl<
          _$LocationPredictionModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LocationPredictionModelImplToJson(
      this,
    );
  }
}

abstract class _LocationPredictionModel implements LocationPredictionModel {
  const factory _LocationPredictionModel(
          {final String? description,
          @JsonKey(name: 'place_id') final String? placeId,
          @JsonKey(name: 'structured_formatting')
          final Map<String, dynamic>? structuredFormatting}) =
      _$LocationPredictionModelImpl;

  factory _LocationPredictionModel.fromJson(Map<String, dynamic> json) =
      _$LocationPredictionModelImpl.fromJson;

  @override
  String? get description;
  @override
  @JsonKey(name: 'place_id')
  String? get placeId;
  @override
  @JsonKey(name: 'structured_formatting')
  Map<String, dynamic>? get structuredFormatting;

  /// Create a copy of LocationPredictionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LocationPredictionModelImplCopyWith<_$LocationPredictionModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
