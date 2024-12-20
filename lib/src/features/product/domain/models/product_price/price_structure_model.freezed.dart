// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'price_structure_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PriceStructureModel _$PriceStructureModelFromJson(Map<String, dynamic> json) {
  return _PriceStructureModel.fromJson(json);
}

/// @nodoc
mixin _$PriceStructureModel {
  int? get id => throw _privateConstructorUsedError;
  String? get externalId => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  int? get startDay => throw _privateConstructorUsedError;
  int? get endDay => throw _privateConstructorUsedError;

  /// Serializes this PriceStructureModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PriceStructureModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PriceStructureModelCopyWith<PriceStructureModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PriceStructureModelCopyWith<$Res> {
  factory $PriceStructureModelCopyWith(
          PriceStructureModel value, $Res Function(PriceStructureModel) then) =
      _$PriceStructureModelCopyWithImpl<$Res, PriceStructureModel>;
  @useResult
  $Res call(
      {int? id,
      String? externalId,
      String? name,
      String? description,
      int? startDay,
      int? endDay});
}

/// @nodoc
class _$PriceStructureModelCopyWithImpl<$Res, $Val extends PriceStructureModel>
    implements $PriceStructureModelCopyWith<$Res> {
  _$PriceStructureModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PriceStructureModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? externalId = freezed,
    Object? name = freezed,
    Object? description = freezed,
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
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
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
abstract class _$$PriceStructureModelImplCopyWith<$Res>
    implements $PriceStructureModelCopyWith<$Res> {
  factory _$$PriceStructureModelImplCopyWith(_$PriceStructureModelImpl value,
          $Res Function(_$PriceStructureModelImpl) then) =
      __$$PriceStructureModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? externalId,
      String? name,
      String? description,
      int? startDay,
      int? endDay});
}

/// @nodoc
class __$$PriceStructureModelImplCopyWithImpl<$Res>
    extends _$PriceStructureModelCopyWithImpl<$Res, _$PriceStructureModelImpl>
    implements _$$PriceStructureModelImplCopyWith<$Res> {
  __$$PriceStructureModelImplCopyWithImpl(_$PriceStructureModelImpl _value,
      $Res Function(_$PriceStructureModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PriceStructureModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? externalId = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? startDay = freezed,
    Object? endDay = freezed,
  }) {
    return _then(_$PriceStructureModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      externalId: freezed == externalId
          ? _value.externalId
          : externalId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
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
class _$PriceStructureModelImpl implements _PriceStructureModel {
  const _$PriceStructureModelImpl(
      {this.id,
      this.externalId,
      this.name,
      this.description,
      this.startDay,
      this.endDay});

  factory _$PriceStructureModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PriceStructureModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? externalId;
  @override
  final String? name;
  @override
  final String? description;
  @override
  final int? startDay;
  @override
  final int? endDay;

  @override
  String toString() {
    return 'PriceStructureModel(id: $id, externalId: $externalId, name: $name, description: $description, startDay: $startDay, endDay: $endDay)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PriceStructureModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.externalId, externalId) ||
                other.externalId == externalId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.startDay, startDay) ||
                other.startDay == startDay) &&
            (identical(other.endDay, endDay) || other.endDay == endDay));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, externalId, name, description, startDay, endDay);

  /// Create a copy of PriceStructureModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PriceStructureModelImplCopyWith<_$PriceStructureModelImpl> get copyWith =>
      __$$PriceStructureModelImplCopyWithImpl<_$PriceStructureModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PriceStructureModelImplToJson(
      this,
    );
  }
}

abstract class _PriceStructureModel implements PriceStructureModel {
  const factory _PriceStructureModel(
      {final int? id,
      final String? externalId,
      final String? name,
      final String? description,
      final int? startDay,
      final int? endDay}) = _$PriceStructureModelImpl;

  factory _PriceStructureModel.fromJson(Map<String, dynamic> json) =
      _$PriceStructureModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get externalId;
  @override
  String? get name;
  @override
  String? get description;
  @override
  int? get startDay;
  @override
  int? get endDay;

  /// Create a copy of PriceStructureModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PriceStructureModelImplCopyWith<_$PriceStructureModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
