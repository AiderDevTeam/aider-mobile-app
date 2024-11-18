// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exchange_schedule_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ExchangeScheduleModel _$ExchangeScheduleModelFromJson(
    Map<String, dynamic> json) {
  return _ExchangeScheduleModel.fromJson(json);
}

/// @nodoc
mixin _$ExchangeScheduleModel {
  String? get externalId => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  String? get countryCode => throw _privateConstructorUsedError;
  String? get originName => throw _privateConstructorUsedError;
  String? get timeOfExchange => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExchangeScheduleModelCopyWith<ExchangeScheduleModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExchangeScheduleModelCopyWith<$Res> {
  factory $ExchangeScheduleModelCopyWith(ExchangeScheduleModel value,
          $Res Function(ExchangeScheduleModel) then) =
      _$ExchangeScheduleModelCopyWithImpl<$Res, ExchangeScheduleModel>;
  @useResult
  $Res call(
      {String? externalId,
      String? city,
      String? status,
      String? country,
      String? countryCode,
      String? originName,
      String? timeOfExchange});
}

/// @nodoc
class _$ExchangeScheduleModelCopyWithImpl<$Res,
        $Val extends ExchangeScheduleModel>
    implements $ExchangeScheduleModelCopyWith<$Res> {
  _$ExchangeScheduleModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? externalId = freezed,
    Object? city = freezed,
    Object? status = freezed,
    Object? country = freezed,
    Object? countryCode = freezed,
    Object? originName = freezed,
    Object? timeOfExchange = freezed,
  }) {
    return _then(_value.copyWith(
      externalId: freezed == externalId
          ? _value.externalId
          : externalId // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      countryCode: freezed == countryCode
          ? _value.countryCode
          : countryCode // ignore: cast_nullable_to_non_nullable
              as String?,
      originName: freezed == originName
          ? _value.originName
          : originName // ignore: cast_nullable_to_non_nullable
              as String?,
      timeOfExchange: freezed == timeOfExchange
          ? _value.timeOfExchange
          : timeOfExchange // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExchangeScheduleModelImplCopyWith<$Res>
    implements $ExchangeScheduleModelCopyWith<$Res> {
  factory _$$ExchangeScheduleModelImplCopyWith(
          _$ExchangeScheduleModelImpl value,
          $Res Function(_$ExchangeScheduleModelImpl) then) =
      __$$ExchangeScheduleModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? externalId,
      String? city,
      String? status,
      String? country,
      String? countryCode,
      String? originName,
      String? timeOfExchange});
}

/// @nodoc
class __$$ExchangeScheduleModelImplCopyWithImpl<$Res>
    extends _$ExchangeScheduleModelCopyWithImpl<$Res,
        _$ExchangeScheduleModelImpl>
    implements _$$ExchangeScheduleModelImplCopyWith<$Res> {
  __$$ExchangeScheduleModelImplCopyWithImpl(_$ExchangeScheduleModelImpl _value,
      $Res Function(_$ExchangeScheduleModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? externalId = freezed,
    Object? city = freezed,
    Object? status = freezed,
    Object? country = freezed,
    Object? countryCode = freezed,
    Object? originName = freezed,
    Object? timeOfExchange = freezed,
  }) {
    return _then(_$ExchangeScheduleModelImpl(
      externalId: freezed == externalId
          ? _value.externalId
          : externalId // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      countryCode: freezed == countryCode
          ? _value.countryCode
          : countryCode // ignore: cast_nullable_to_non_nullable
              as String?,
      originName: freezed == originName
          ? _value.originName
          : originName // ignore: cast_nullable_to_non_nullable
              as String?,
      timeOfExchange: freezed == timeOfExchange
          ? _value.timeOfExchange
          : timeOfExchange // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExchangeScheduleModelImpl extends _ExchangeScheduleModel {
  const _$ExchangeScheduleModelImpl(
      {this.externalId,
      this.city,
      this.status,
      this.country,
      this.countryCode,
      this.originName,
      this.timeOfExchange})
      : super._();

  factory _$ExchangeScheduleModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExchangeScheduleModelImplFromJson(json);

  @override
  final String? externalId;
  @override
  final String? city;
  @override
  final String? status;
  @override
  final String? country;
  @override
  final String? countryCode;
  @override
  final String? originName;
  @override
  final String? timeOfExchange;

  @override
  String toString() {
    return 'ExchangeScheduleModel(externalId: $externalId, city: $city, status: $status, country: $country, countryCode: $countryCode, originName: $originName, timeOfExchange: $timeOfExchange)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExchangeScheduleModelImpl &&
            (identical(other.externalId, externalId) ||
                other.externalId == externalId) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.countryCode, countryCode) ||
                other.countryCode == countryCode) &&
            (identical(other.originName, originName) ||
                other.originName == originName) &&
            (identical(other.timeOfExchange, timeOfExchange) ||
                other.timeOfExchange == timeOfExchange));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, externalId, city, status,
      country, countryCode, originName, timeOfExchange);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExchangeScheduleModelImplCopyWith<_$ExchangeScheduleModelImpl>
      get copyWith => __$$ExchangeScheduleModelImplCopyWithImpl<
          _$ExchangeScheduleModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExchangeScheduleModelImplToJson(
      this,
    );
  }
}

abstract class _ExchangeScheduleModel extends ExchangeScheduleModel {
  const factory _ExchangeScheduleModel(
      {final String? externalId,
      final String? city,
      final String? status,
      final String? country,
      final String? countryCode,
      final String? originName,
      final String? timeOfExchange}) = _$ExchangeScheduleModelImpl;
  const _ExchangeScheduleModel._() : super._();

  factory _ExchangeScheduleModel.fromJson(Map<String, dynamic> json) =
      _$ExchangeScheduleModelImpl.fromJson;

  @override
  String? get externalId;
  @override
  String? get city;
  @override
  String? get status;
  @override
  String? get country;
  @override
  String? get countryCode;
  @override
  String? get originName;
  @override
  String? get timeOfExchange;
  @override
  @JsonKey(ignore: true)
  _$$ExchangeScheduleModelImplCopyWith<_$ExchangeScheduleModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
