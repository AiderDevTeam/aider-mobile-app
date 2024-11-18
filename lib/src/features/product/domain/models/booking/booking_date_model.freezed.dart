// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_date_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BookingDateModel _$BookingDateModelFromJson(Map<String, dynamic> json) {
  return _BookingDateModel.fromJson(json);
}

/// @nodoc
mixin _$BookingDateModel {
  int? get id => throw _privateConstructorUsedError;
  String? get date => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BookingDateModelCopyWith<BookingDateModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingDateModelCopyWith<$Res> {
  factory $BookingDateModelCopyWith(
          BookingDateModel value, $Res Function(BookingDateModel) then) =
      _$BookingDateModelCopyWithImpl<$Res, BookingDateModel>;
  @useResult
  $Res call({int? id, String? date});
}

/// @nodoc
class _$BookingDateModelCopyWithImpl<$Res, $Val extends BookingDateModel>
    implements $BookingDateModelCopyWith<$Res> {
  _$BookingDateModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? date = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BookingDateModelImplCopyWith<$Res>
    implements $BookingDateModelCopyWith<$Res> {
  factory _$$BookingDateModelImplCopyWith(_$BookingDateModelImpl value,
          $Res Function(_$BookingDateModelImpl) then) =
      __$$BookingDateModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? date});
}

/// @nodoc
class __$$BookingDateModelImplCopyWithImpl<$Res>
    extends _$BookingDateModelCopyWithImpl<$Res, _$BookingDateModelImpl>
    implements _$$BookingDateModelImplCopyWith<$Res> {
  __$$BookingDateModelImplCopyWithImpl(_$BookingDateModelImpl _value,
      $Res Function(_$BookingDateModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? date = freezed,
  }) {
    return _then(_$BookingDateModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BookingDateModelImpl implements _BookingDateModel {
  const _$BookingDateModelImpl({this.id, this.date});

  factory _$BookingDateModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookingDateModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? date;

  @override
  String toString() {
    return 'BookingDateModel(id: $id, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookingDateModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, date);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BookingDateModelImplCopyWith<_$BookingDateModelImpl> get copyWith =>
      __$$BookingDateModelImplCopyWithImpl<_$BookingDateModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookingDateModelImplToJson(
      this,
    );
  }
}

abstract class _BookingDateModel implements BookingDateModel {
  const factory _BookingDateModel({final int? id, final String? date}) =
      _$BookingDateModelImpl;

  factory _BookingDateModel.fromJson(Map<String, dynamic> json) =
      _$BookingDateModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get date;
  @override
  @JsonKey(ignore: true)
  _$$BookingDateModelImplCopyWith<_$BookingDateModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
