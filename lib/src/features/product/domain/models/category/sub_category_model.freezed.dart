// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sub_category_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SubCategoryModel _$SubCategoryModelFromJson(Map<String, dynamic> json) {
  return _SubCategoryModel.fromJson(json);
}

/// @nodoc
mixin _$SubCategoryModel {
  int? get id => throw _privateConstructorUsedError;
  String? get externalId => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  CategoryModel? get category => throw _privateConstructorUsedError;
  List<SubCategoryItemModel>? get subCategoryItems =>
      throw _privateConstructorUsedError;

  /// Serializes this SubCategoryModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SubCategoryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubCategoryModelCopyWith<SubCategoryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubCategoryModelCopyWith<$Res> {
  factory $SubCategoryModelCopyWith(
          SubCategoryModel value, $Res Function(SubCategoryModel) then) =
      _$SubCategoryModelCopyWithImpl<$Res, SubCategoryModel>;
  @useResult
  $Res call(
      {int? id,
      String? externalId,
      String? name,
      CategoryModel? category,
      List<SubCategoryItemModel>? subCategoryItems});

  $CategoryModelCopyWith<$Res>? get category;
}

/// @nodoc
class _$SubCategoryModelCopyWithImpl<$Res, $Val extends SubCategoryModel>
    implements $SubCategoryModelCopyWith<$Res> {
  _$SubCategoryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubCategoryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? externalId = freezed,
    Object? name = freezed,
    Object? category = freezed,
    Object? subCategoryItems = freezed,
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
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as CategoryModel?,
      subCategoryItems: freezed == subCategoryItems
          ? _value.subCategoryItems
          : subCategoryItems // ignore: cast_nullable_to_non_nullable
              as List<SubCategoryItemModel>?,
    ) as $Val);
  }

  /// Create a copy of SubCategoryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CategoryModelCopyWith<$Res>? get category {
    if (_value.category == null) {
      return null;
    }

    return $CategoryModelCopyWith<$Res>(_value.category!, (value) {
      return _then(_value.copyWith(category: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SubCategoryModelImplCopyWith<$Res>
    implements $SubCategoryModelCopyWith<$Res> {
  factory _$$SubCategoryModelImplCopyWith(_$SubCategoryModelImpl value,
          $Res Function(_$SubCategoryModelImpl) then) =
      __$$SubCategoryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? externalId,
      String? name,
      CategoryModel? category,
      List<SubCategoryItemModel>? subCategoryItems});

  @override
  $CategoryModelCopyWith<$Res>? get category;
}

/// @nodoc
class __$$SubCategoryModelImplCopyWithImpl<$Res>
    extends _$SubCategoryModelCopyWithImpl<$Res, _$SubCategoryModelImpl>
    implements _$$SubCategoryModelImplCopyWith<$Res> {
  __$$SubCategoryModelImplCopyWithImpl(_$SubCategoryModelImpl _value,
      $Res Function(_$SubCategoryModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of SubCategoryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? externalId = freezed,
    Object? name = freezed,
    Object? category = freezed,
    Object? subCategoryItems = freezed,
  }) {
    return _then(_$SubCategoryModelImpl(
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
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as CategoryModel?,
      subCategoryItems: freezed == subCategoryItems
          ? _value._subCategoryItems
          : subCategoryItems // ignore: cast_nullable_to_non_nullable
              as List<SubCategoryItemModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SubCategoryModelImpl implements _SubCategoryModel {
  const _$SubCategoryModelImpl(
      {this.id,
      this.externalId,
      this.name,
      this.category,
      final List<SubCategoryItemModel>? subCategoryItems})
      : _subCategoryItems = subCategoryItems;

  factory _$SubCategoryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubCategoryModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? externalId;
  @override
  final String? name;
  @override
  final CategoryModel? category;
  final List<SubCategoryItemModel>? _subCategoryItems;
  @override
  List<SubCategoryItemModel>? get subCategoryItems {
    final value = _subCategoryItems;
    if (value == null) return null;
    if (_subCategoryItems is EqualUnmodifiableListView)
      return _subCategoryItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'SubCategoryModel(id: $id, externalId: $externalId, name: $name, category: $category, subCategoryItems: $subCategoryItems)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubCategoryModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.externalId, externalId) ||
                other.externalId == externalId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.category, category) ||
                other.category == category) &&
            const DeepCollectionEquality()
                .equals(other._subCategoryItems, _subCategoryItems));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, externalId, name, category,
      const DeepCollectionEquality().hash(_subCategoryItems));

  /// Create a copy of SubCategoryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubCategoryModelImplCopyWith<_$SubCategoryModelImpl> get copyWith =>
      __$$SubCategoryModelImplCopyWithImpl<_$SubCategoryModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubCategoryModelImplToJson(
      this,
    );
  }
}

abstract class _SubCategoryModel implements SubCategoryModel {
  const factory _SubCategoryModel(
          {final int? id,
          final String? externalId,
          final String? name,
          final CategoryModel? category,
          final List<SubCategoryItemModel>? subCategoryItems}) =
      _$SubCategoryModelImpl;

  factory _SubCategoryModel.fromJson(Map<String, dynamic> json) =
      _$SubCategoryModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get externalId;
  @override
  String? get name;
  @override
  CategoryModel? get category;
  @override
  List<SubCategoryItemModel>? get subCategoryItems;

  /// Create a copy of SubCategoryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubCategoryModelImplCopyWith<_$SubCategoryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
