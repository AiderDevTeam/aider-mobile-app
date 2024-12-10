// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sub_category_item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SubCategoryItemModel _$SubCategoryItemModelFromJson(Map<String, dynamic> json) {
  return _SubCategoryItemModel.fromJson(json);
}

/// @nodoc
mixin _$SubCategoryItemModel {
  int? get id => throw _privateConstructorUsedError;
  String? get externalId => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  SubCategoryModel? get subCategory => throw _privateConstructorUsedError;

  /// Serializes this SubCategoryItemModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SubCategoryItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubCategoryItemModelCopyWith<SubCategoryItemModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubCategoryItemModelCopyWith<$Res> {
  factory $SubCategoryItemModelCopyWith(SubCategoryItemModel value,
          $Res Function(SubCategoryItemModel) then) =
      _$SubCategoryItemModelCopyWithImpl<$Res, SubCategoryItemModel>;
  @useResult
  $Res call(
      {int? id,
      String? externalId,
      String? name,
      SubCategoryModel? subCategory});

  $SubCategoryModelCopyWith<$Res>? get subCategory;
}

/// @nodoc
class _$SubCategoryItemModelCopyWithImpl<$Res,
        $Val extends SubCategoryItemModel>
    implements $SubCategoryItemModelCopyWith<$Res> {
  _$SubCategoryItemModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubCategoryItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? externalId = freezed,
    Object? name = freezed,
    Object? subCategory = freezed,
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
      subCategory: freezed == subCategory
          ? _value.subCategory
          : subCategory // ignore: cast_nullable_to_non_nullable
              as SubCategoryModel?,
    ) as $Val);
  }

  /// Create a copy of SubCategoryItemModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SubCategoryModelCopyWith<$Res>? get subCategory {
    if (_value.subCategory == null) {
      return null;
    }

    return $SubCategoryModelCopyWith<$Res>(_value.subCategory!, (value) {
      return _then(_value.copyWith(subCategory: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SubCategoryItemModelImplCopyWith<$Res>
    implements $SubCategoryItemModelCopyWith<$Res> {
  factory _$$SubCategoryItemModelImplCopyWith(_$SubCategoryItemModelImpl value,
          $Res Function(_$SubCategoryItemModelImpl) then) =
      __$$SubCategoryItemModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? externalId,
      String? name,
      SubCategoryModel? subCategory});

  @override
  $SubCategoryModelCopyWith<$Res>? get subCategory;
}

/// @nodoc
class __$$SubCategoryItemModelImplCopyWithImpl<$Res>
    extends _$SubCategoryItemModelCopyWithImpl<$Res, _$SubCategoryItemModelImpl>
    implements _$$SubCategoryItemModelImplCopyWith<$Res> {
  __$$SubCategoryItemModelImplCopyWithImpl(_$SubCategoryItemModelImpl _value,
      $Res Function(_$SubCategoryItemModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of SubCategoryItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? externalId = freezed,
    Object? name = freezed,
    Object? subCategory = freezed,
  }) {
    return _then(_$SubCategoryItemModelImpl(
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
      subCategory: freezed == subCategory
          ? _value.subCategory
          : subCategory // ignore: cast_nullable_to_non_nullable
              as SubCategoryModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SubCategoryItemModelImpl implements _SubCategoryItemModel {
  const _$SubCategoryItemModelImpl(
      {this.id, this.externalId, this.name, this.subCategory});

  factory _$SubCategoryItemModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubCategoryItemModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? externalId;
  @override
  final String? name;
  @override
  final SubCategoryModel? subCategory;

  @override
  String toString() {
    return 'SubCategoryItemModel(id: $id, externalId: $externalId, name: $name, subCategory: $subCategory)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubCategoryItemModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.externalId, externalId) ||
                other.externalId == externalId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.subCategory, subCategory) ||
                other.subCategory == subCategory));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, externalId, name, subCategory);

  /// Create a copy of SubCategoryItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubCategoryItemModelImplCopyWith<_$SubCategoryItemModelImpl>
      get copyWith =>
          __$$SubCategoryItemModelImplCopyWithImpl<_$SubCategoryItemModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubCategoryItemModelImplToJson(
      this,
    );
  }
}

abstract class _SubCategoryItemModel implements SubCategoryItemModel {
  const factory _SubCategoryItemModel(
      {final int? id,
      final String? externalId,
      final String? name,
      final SubCategoryModel? subCategory}) = _$SubCategoryItemModelImpl;

  factory _SubCategoryItemModel.fromJson(Map<String, dynamic> json) =
      _$SubCategoryItemModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get externalId;
  @override
  String? get name;
  @override
  SubCategoryModel? get subCategory;

  /// Create a copy of SubCategoryItemModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubCategoryItemModelImplCopyWith<_$SubCategoryItemModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
