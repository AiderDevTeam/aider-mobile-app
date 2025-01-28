// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_type_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserTypeModel _$UserTypeModelFromJson(Map<String, dynamic> json) {
  return _UserTypeModel.fromJson(json);
}

/// @nodoc
mixin _$UserTypeModel {
  String? get uid => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  /// Serializes this UserTypeModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserTypeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserTypeModelCopyWith<UserTypeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserTypeModelCopyWith<$Res> {
  factory $UserTypeModelCopyWith(
          UserTypeModel value, $Res Function(UserTypeModel) then) =
      _$UserTypeModelCopyWithImpl<$Res, UserTypeModel>;
  @useResult
  $Res call({String? uid, String? name, String? description});
}

/// @nodoc
class _$UserTypeModelCopyWithImpl<$Res, $Val extends UserTypeModel>
    implements $UserTypeModelCopyWith<$Res> {
  _$UserTypeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserTypeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = freezed,
    Object? name = freezed,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserTypeModelImplCopyWith<$Res>
    implements $UserTypeModelCopyWith<$Res> {
  factory _$$UserTypeModelImplCopyWith(
          _$UserTypeModelImpl value, $Res Function(_$UserTypeModelImpl) then) =
      __$$UserTypeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? uid, String? name, String? description});
}

/// @nodoc
class __$$UserTypeModelImplCopyWithImpl<$Res>
    extends _$UserTypeModelCopyWithImpl<$Res, _$UserTypeModelImpl>
    implements _$$UserTypeModelImplCopyWith<$Res> {
  __$$UserTypeModelImplCopyWithImpl(
      _$UserTypeModelImpl _value, $Res Function(_$UserTypeModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserTypeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = freezed,
    Object? name = freezed,
    Object? description = freezed,
  }) {
    return _then(_$UserTypeModelImpl(
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserTypeModelImpl extends _UserTypeModel {
  _$UserTypeModelImpl({this.uid, this.name, this.description}) : super._();

  factory _$UserTypeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserTypeModelImplFromJson(json);

  @override
  final String? uid;
  @override
  final String? name;
  @override
  final String? description;

  @override
  String toString() {
    return 'UserTypeModel(uid: $uid, name: $name, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserTypeModelImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, uid, name, description);

  /// Create a copy of UserTypeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserTypeModelImplCopyWith<_$UserTypeModelImpl> get copyWith =>
      __$$UserTypeModelImplCopyWithImpl<_$UserTypeModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserTypeModelImplToJson(
      this,
    );
  }
}

abstract class _UserTypeModel extends UserTypeModel {
  factory _UserTypeModel(
      {final String? uid,
      final String? name,
      final String? description}) = _$UserTypeModelImpl;
  _UserTypeModel._() : super._();

  factory _UserTypeModel.fromJson(Map<String, dynamic> json) =
      _$UserTypeModelImpl.fromJson;

  @override
  String? get uid;
  @override
  String? get name;
  @override
  String? get description;

  /// Create a copy of UserTypeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserTypeModelImplCopyWith<_$UserTypeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
