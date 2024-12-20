// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_prediction_detail_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LocationPredictionDetailModel _$LocationPredictionDetailModelFromJson(
    Map<String, dynamic> json) {
  return _LocationPredictionDetailModel.fromJson(json);
}

/// @nodoc
mixin _$LocationPredictionDetailModel {
  @JsonKey(name: 'geometry')
  Map<String, dynamic>? get geometry => throw _privateConstructorUsedError;
  @JsonKey(name: 'address_components')
  List<dynamic>? get addressComponents => throw _privateConstructorUsedError;

  /// Serializes this LocationPredictionDetailModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LocationPredictionDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LocationPredictionDetailModelCopyWith<LocationPredictionDetailModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationPredictionDetailModelCopyWith<$Res> {
  factory $LocationPredictionDetailModelCopyWith(
          LocationPredictionDetailModel value,
          $Res Function(LocationPredictionDetailModel) then) =
      _$LocationPredictionDetailModelCopyWithImpl<$Res,
          LocationPredictionDetailModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'geometry') Map<String, dynamic>? geometry,
      @JsonKey(name: 'address_components') List<dynamic>? addressComponents});
}

/// @nodoc
class _$LocationPredictionDetailModelCopyWithImpl<$Res,
        $Val extends LocationPredictionDetailModel>
    implements $LocationPredictionDetailModelCopyWith<$Res> {
  _$LocationPredictionDetailModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LocationPredictionDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? geometry = freezed,
    Object? addressComponents = freezed,
  }) {
    return _then(_value.copyWith(
      geometry: freezed == geometry
          ? _value.geometry
          : geometry // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      addressComponents: freezed == addressComponents
          ? _value.addressComponents
          : addressComponents // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LocationPredictionDetailModelImplCopyWith<$Res>
    implements $LocationPredictionDetailModelCopyWith<$Res> {
  factory _$$LocationPredictionDetailModelImplCopyWith(
          _$LocationPredictionDetailModelImpl value,
          $Res Function(_$LocationPredictionDetailModelImpl) then) =
      __$$LocationPredictionDetailModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'geometry') Map<String, dynamic>? geometry,
      @JsonKey(name: 'address_components') List<dynamic>? addressComponents});
}

/// @nodoc
class __$$LocationPredictionDetailModelImplCopyWithImpl<$Res>
    extends _$LocationPredictionDetailModelCopyWithImpl<$Res,
        _$LocationPredictionDetailModelImpl>
    implements _$$LocationPredictionDetailModelImplCopyWith<$Res> {
  __$$LocationPredictionDetailModelImplCopyWithImpl(
      _$LocationPredictionDetailModelImpl _value,
      $Res Function(_$LocationPredictionDetailModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of LocationPredictionDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? geometry = freezed,
    Object? addressComponents = freezed,
  }) {
    return _then(_$LocationPredictionDetailModelImpl(
      geometry: freezed == geometry
          ? _value._geometry
          : geometry // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      addressComponents: freezed == addressComponents
          ? _value._addressComponents
          : addressComponents // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LocationPredictionDetailModelImpl
    implements _LocationPredictionDetailModel {
  const _$LocationPredictionDetailModelImpl(
      {@JsonKey(name: 'geometry') final Map<String, dynamic>? geometry,
      @JsonKey(name: 'address_components')
      final List<dynamic>? addressComponents})
      : _geometry = geometry,
        _addressComponents = addressComponents;

  factory _$LocationPredictionDetailModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$LocationPredictionDetailModelImplFromJson(json);

  final Map<String, dynamic>? _geometry;
  @override
  @JsonKey(name: 'geometry')
  Map<String, dynamic>? get geometry {
    final value = _geometry;
    if (value == null) return null;
    if (_geometry is EqualUnmodifiableMapView) return _geometry;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final List<dynamic>? _addressComponents;
  @override
  @JsonKey(name: 'address_components')
  List<dynamic>? get addressComponents {
    final value = _addressComponents;
    if (value == null) return null;
    if (_addressComponents is EqualUnmodifiableListView)
      return _addressComponents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'LocationPredictionDetailModel(geometry: $geometry, addressComponents: $addressComponents)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationPredictionDetailModelImpl &&
            const DeepCollectionEquality().equals(other._geometry, _geometry) &&
            const DeepCollectionEquality()
                .equals(other._addressComponents, _addressComponents));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_geometry),
      const DeepCollectionEquality().hash(_addressComponents));

  /// Create a copy of LocationPredictionDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationPredictionDetailModelImplCopyWith<
          _$LocationPredictionDetailModelImpl>
      get copyWith => __$$LocationPredictionDetailModelImplCopyWithImpl<
          _$LocationPredictionDetailModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LocationPredictionDetailModelImplToJson(
      this,
    );
  }
}

abstract class _LocationPredictionDetailModel
    implements LocationPredictionDetailModel {
  const factory _LocationPredictionDetailModel(
          {@JsonKey(name: 'geometry') final Map<String, dynamic>? geometry,
          @JsonKey(name: 'address_components')
          final List<dynamic>? addressComponents}) =
      _$LocationPredictionDetailModelImpl;

  factory _LocationPredictionDetailModel.fromJson(Map<String, dynamic> json) =
      _$LocationPredictionDetailModelImpl.fromJson;

  @override
  @JsonKey(name: 'geometry')
  Map<String, dynamic>? get geometry;
  @override
  @JsonKey(name: 'address_components')
  List<dynamic>? get addressComponents;

  /// Create a copy of LocationPredictionDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LocationPredictionDetailModelImplCopyWith<
          _$LocationPredictionDetailModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
