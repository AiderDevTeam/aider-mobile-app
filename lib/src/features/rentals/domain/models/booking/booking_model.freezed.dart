// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BookingModel _$BookingModelFromJson(Map<String, dynamic> json) {
  return _BookingModel.fromJson(json);
}

/// @nodoc
mixin _$BookingModel {
  int? get id => throw _privateConstructorUsedError;
  String? get externalId => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  num? get collectionAmount => throw _privateConstructorUsedError;
  String? get collectionStatus => throw _privateConstructorUsedError;
  num? get disbursementAmount => throw _privateConstructorUsedError;
  String? get disbursementStatus => throw _privateConstructorUsedError;
  String? get reversalStatus => throw _privateConstructorUsedError;
  String? get bookingAcceptanceStatus => throw _privateConstructorUsedError;
  String? get vendorPickupStatus => throw _privateConstructorUsedError;
  String? get userPickupStatus => throw _privateConstructorUsedError;
  String? get vendorDropOffStatus => throw _privateConstructorUsedError;
  String? get userDropOffStatus => throw _privateConstructorUsedError;
  String? get bookingNumber => throw _privateConstructorUsedError;
  BookedProductModel? get bookedProduct => throw _privateConstructorUsedError;
  bool get userHasReported => throw _privateConstructorUsedError;
  bool get vendorHasReported => throw _privateConstructorUsedError;
  UserModel? get vendor => throw _privateConstructorUsedError;
  UserModel? get user => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BookingModelCopyWith<BookingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingModelCopyWith<$Res> {
  factory $BookingModelCopyWith(
          BookingModel value, $Res Function(BookingModel) then) =
      _$BookingModelCopyWithImpl<$Res, BookingModel>;
  @useResult
  $Res call(
      {int? id,
      String? externalId,
      String? status,
      num? collectionAmount,
      String? collectionStatus,
      num? disbursementAmount,
      String? disbursementStatus,
      String? reversalStatus,
      String? bookingAcceptanceStatus,
      String? vendorPickupStatus,
      String? userPickupStatus,
      String? vendorDropOffStatus,
      String? userDropOffStatus,
      String? bookingNumber,
      BookedProductModel? bookedProduct,
      bool userHasReported,
      bool vendorHasReported,
      UserModel? vendor,
      UserModel? user});

  $BookedProductModelCopyWith<$Res>? get bookedProduct;
  $UserModelCopyWith<$Res>? get vendor;
  $UserModelCopyWith<$Res>? get user;
}

/// @nodoc
class _$BookingModelCopyWithImpl<$Res, $Val extends BookingModel>
    implements $BookingModelCopyWith<$Res> {
  _$BookingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? externalId = freezed,
    Object? status = freezed,
    Object? collectionAmount = freezed,
    Object? collectionStatus = freezed,
    Object? disbursementAmount = freezed,
    Object? disbursementStatus = freezed,
    Object? reversalStatus = freezed,
    Object? bookingAcceptanceStatus = freezed,
    Object? vendorPickupStatus = freezed,
    Object? userPickupStatus = freezed,
    Object? vendorDropOffStatus = freezed,
    Object? userDropOffStatus = freezed,
    Object? bookingNumber = freezed,
    Object? bookedProduct = freezed,
    Object? userHasReported = null,
    Object? vendorHasReported = null,
    Object? vendor = freezed,
    Object? user = freezed,
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
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      collectionAmount: freezed == collectionAmount
          ? _value.collectionAmount
          : collectionAmount // ignore: cast_nullable_to_non_nullable
              as num?,
      collectionStatus: freezed == collectionStatus
          ? _value.collectionStatus
          : collectionStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      disbursementAmount: freezed == disbursementAmount
          ? _value.disbursementAmount
          : disbursementAmount // ignore: cast_nullable_to_non_nullable
              as num?,
      disbursementStatus: freezed == disbursementStatus
          ? _value.disbursementStatus
          : disbursementStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      reversalStatus: freezed == reversalStatus
          ? _value.reversalStatus
          : reversalStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      bookingAcceptanceStatus: freezed == bookingAcceptanceStatus
          ? _value.bookingAcceptanceStatus
          : bookingAcceptanceStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      vendorPickupStatus: freezed == vendorPickupStatus
          ? _value.vendorPickupStatus
          : vendorPickupStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      userPickupStatus: freezed == userPickupStatus
          ? _value.userPickupStatus
          : userPickupStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      vendorDropOffStatus: freezed == vendorDropOffStatus
          ? _value.vendorDropOffStatus
          : vendorDropOffStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      userDropOffStatus: freezed == userDropOffStatus
          ? _value.userDropOffStatus
          : userDropOffStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      bookingNumber: freezed == bookingNumber
          ? _value.bookingNumber
          : bookingNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      bookedProduct: freezed == bookedProduct
          ? _value.bookedProduct
          : bookedProduct // ignore: cast_nullable_to_non_nullable
              as BookedProductModel?,
      userHasReported: null == userHasReported
          ? _value.userHasReported
          : userHasReported // ignore: cast_nullable_to_non_nullable
              as bool,
      vendorHasReported: null == vendorHasReported
          ? _value.vendorHasReported
          : vendorHasReported // ignore: cast_nullable_to_non_nullable
              as bool,
      vendor: freezed == vendor
          ? _value.vendor
          : vendor // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $BookedProductModelCopyWith<$Res>? get bookedProduct {
    if (_value.bookedProduct == null) {
      return null;
    }

    return $BookedProductModelCopyWith<$Res>(_value.bookedProduct!, (value) {
      return _then(_value.copyWith(bookedProduct: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res>? get vendor {
    if (_value.vendor == null) {
      return null;
    }

    return $UserModelCopyWith<$Res>(_value.vendor!, (value) {
      return _then(_value.copyWith(vendor: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserModelCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BookingModelImplCopyWith<$Res>
    implements $BookingModelCopyWith<$Res> {
  factory _$$BookingModelImplCopyWith(
          _$BookingModelImpl value, $Res Function(_$BookingModelImpl) then) =
      __$$BookingModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? externalId,
      String? status,
      num? collectionAmount,
      String? collectionStatus,
      num? disbursementAmount,
      String? disbursementStatus,
      String? reversalStatus,
      String? bookingAcceptanceStatus,
      String? vendorPickupStatus,
      String? userPickupStatus,
      String? vendorDropOffStatus,
      String? userDropOffStatus,
      String? bookingNumber,
      BookedProductModel? bookedProduct,
      bool userHasReported,
      bool vendorHasReported,
      UserModel? vendor,
      UserModel? user});

  @override
  $BookedProductModelCopyWith<$Res>? get bookedProduct;
  @override
  $UserModelCopyWith<$Res>? get vendor;
  @override
  $UserModelCopyWith<$Res>? get user;
}

/// @nodoc
class __$$BookingModelImplCopyWithImpl<$Res>
    extends _$BookingModelCopyWithImpl<$Res, _$BookingModelImpl>
    implements _$$BookingModelImplCopyWith<$Res> {
  __$$BookingModelImplCopyWithImpl(
      _$BookingModelImpl _value, $Res Function(_$BookingModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? externalId = freezed,
    Object? status = freezed,
    Object? collectionAmount = freezed,
    Object? collectionStatus = freezed,
    Object? disbursementAmount = freezed,
    Object? disbursementStatus = freezed,
    Object? reversalStatus = freezed,
    Object? bookingAcceptanceStatus = freezed,
    Object? vendorPickupStatus = freezed,
    Object? userPickupStatus = freezed,
    Object? vendorDropOffStatus = freezed,
    Object? userDropOffStatus = freezed,
    Object? bookingNumber = freezed,
    Object? bookedProduct = freezed,
    Object? userHasReported = null,
    Object? vendorHasReported = null,
    Object? vendor = freezed,
    Object? user = freezed,
  }) {
    return _then(_$BookingModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      externalId: freezed == externalId
          ? _value.externalId
          : externalId // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      collectionAmount: freezed == collectionAmount
          ? _value.collectionAmount
          : collectionAmount // ignore: cast_nullable_to_non_nullable
              as num?,
      collectionStatus: freezed == collectionStatus
          ? _value.collectionStatus
          : collectionStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      disbursementAmount: freezed == disbursementAmount
          ? _value.disbursementAmount
          : disbursementAmount // ignore: cast_nullable_to_non_nullable
              as num?,
      disbursementStatus: freezed == disbursementStatus
          ? _value.disbursementStatus
          : disbursementStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      reversalStatus: freezed == reversalStatus
          ? _value.reversalStatus
          : reversalStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      bookingAcceptanceStatus: freezed == bookingAcceptanceStatus
          ? _value.bookingAcceptanceStatus
          : bookingAcceptanceStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      vendorPickupStatus: freezed == vendorPickupStatus
          ? _value.vendorPickupStatus
          : vendorPickupStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      userPickupStatus: freezed == userPickupStatus
          ? _value.userPickupStatus
          : userPickupStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      vendorDropOffStatus: freezed == vendorDropOffStatus
          ? _value.vendorDropOffStatus
          : vendorDropOffStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      userDropOffStatus: freezed == userDropOffStatus
          ? _value.userDropOffStatus
          : userDropOffStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      bookingNumber: freezed == bookingNumber
          ? _value.bookingNumber
          : bookingNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      bookedProduct: freezed == bookedProduct
          ? _value.bookedProduct
          : bookedProduct // ignore: cast_nullable_to_non_nullable
              as BookedProductModel?,
      userHasReported: null == userHasReported
          ? _value.userHasReported
          : userHasReported // ignore: cast_nullable_to_non_nullable
              as bool,
      vendorHasReported: null == vendorHasReported
          ? _value.vendorHasReported
          : vendorHasReported // ignore: cast_nullable_to_non_nullable
              as bool,
      vendor: freezed == vendor
          ? _value.vendor
          : vendor // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BookingModelImpl extends _BookingModel {
  const _$BookingModelImpl(
      {this.id,
      this.externalId,
      this.status,
      this.collectionAmount,
      this.collectionStatus,
      this.disbursementAmount,
      this.disbursementStatus,
      this.reversalStatus,
      this.bookingAcceptanceStatus,
      this.vendorPickupStatus,
      this.userPickupStatus,
      this.vendorDropOffStatus,
      this.userDropOffStatus,
      this.bookingNumber,
      this.bookedProduct,
      this.userHasReported = false,
      this.vendorHasReported = false,
      this.vendor,
      this.user})
      : super._();

  factory _$BookingModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookingModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? externalId;
  @override
  final String? status;
  @override
  final num? collectionAmount;
  @override
  final String? collectionStatus;
  @override
  final num? disbursementAmount;
  @override
  final String? disbursementStatus;
  @override
  final String? reversalStatus;
  @override
  final String? bookingAcceptanceStatus;
  @override
  final String? vendorPickupStatus;
  @override
  final String? userPickupStatus;
  @override
  final String? vendorDropOffStatus;
  @override
  final String? userDropOffStatus;
  @override
  final String? bookingNumber;
  @override
  final BookedProductModel? bookedProduct;
  @override
  @JsonKey()
  final bool userHasReported;
  @override
  @JsonKey()
  final bool vendorHasReported;
  @override
  final UserModel? vendor;
  @override
  final UserModel? user;

  @override
  String toString() {
    return 'BookingModel(id: $id, externalId: $externalId, status: $status, collectionAmount: $collectionAmount, collectionStatus: $collectionStatus, disbursementAmount: $disbursementAmount, disbursementStatus: $disbursementStatus, reversalStatus: $reversalStatus, bookingAcceptanceStatus: $bookingAcceptanceStatus, vendorPickupStatus: $vendorPickupStatus, userPickupStatus: $userPickupStatus, vendorDropOffStatus: $vendorDropOffStatus, userDropOffStatus: $userDropOffStatus, bookingNumber: $bookingNumber, bookedProduct: $bookedProduct, userHasReported: $userHasReported, vendorHasReported: $vendorHasReported, vendor: $vendor, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookingModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.externalId, externalId) ||
                other.externalId == externalId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.collectionAmount, collectionAmount) ||
                other.collectionAmount == collectionAmount) &&
            (identical(other.collectionStatus, collectionStatus) ||
                other.collectionStatus == collectionStatus) &&
            (identical(other.disbursementAmount, disbursementAmount) ||
                other.disbursementAmount == disbursementAmount) &&
            (identical(other.disbursementStatus, disbursementStatus) ||
                other.disbursementStatus == disbursementStatus) &&
            (identical(other.reversalStatus, reversalStatus) ||
                other.reversalStatus == reversalStatus) &&
            (identical(
                    other.bookingAcceptanceStatus, bookingAcceptanceStatus) ||
                other.bookingAcceptanceStatus == bookingAcceptanceStatus) &&
            (identical(other.vendorPickupStatus, vendorPickupStatus) ||
                other.vendorPickupStatus == vendorPickupStatus) &&
            (identical(other.userPickupStatus, userPickupStatus) ||
                other.userPickupStatus == userPickupStatus) &&
            (identical(other.vendorDropOffStatus, vendorDropOffStatus) ||
                other.vendorDropOffStatus == vendorDropOffStatus) &&
            (identical(other.userDropOffStatus, userDropOffStatus) ||
                other.userDropOffStatus == userDropOffStatus) &&
            (identical(other.bookingNumber, bookingNumber) ||
                other.bookingNumber == bookingNumber) &&
            (identical(other.bookedProduct, bookedProduct) ||
                other.bookedProduct == bookedProduct) &&
            (identical(other.userHasReported, userHasReported) ||
                other.userHasReported == userHasReported) &&
            (identical(other.vendorHasReported, vendorHasReported) ||
                other.vendorHasReported == vendorHasReported) &&
            (identical(other.vendor, vendor) || other.vendor == vendor) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        externalId,
        status,
        collectionAmount,
        collectionStatus,
        disbursementAmount,
        disbursementStatus,
        reversalStatus,
        bookingAcceptanceStatus,
        vendorPickupStatus,
        userPickupStatus,
        vendorDropOffStatus,
        userDropOffStatus,
        bookingNumber,
        bookedProduct,
        userHasReported,
        vendorHasReported,
        vendor,
        user
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BookingModelImplCopyWith<_$BookingModelImpl> get copyWith =>
      __$$BookingModelImplCopyWithImpl<_$BookingModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookingModelImplToJson(
      this,
    );
  }
}

abstract class _BookingModel extends BookingModel {
  const factory _BookingModel(
      {final int? id,
      final String? externalId,
      final String? status,
      final num? collectionAmount,
      final String? collectionStatus,
      final num? disbursementAmount,
      final String? disbursementStatus,
      final String? reversalStatus,
      final String? bookingAcceptanceStatus,
      final String? vendorPickupStatus,
      final String? userPickupStatus,
      final String? vendorDropOffStatus,
      final String? userDropOffStatus,
      final String? bookingNumber,
      final BookedProductModel? bookedProduct,
      final bool userHasReported,
      final bool vendorHasReported,
      final UserModel? vendor,
      final UserModel? user}) = _$BookingModelImpl;
  const _BookingModel._() : super._();

  factory _BookingModel.fromJson(Map<String, dynamic> json) =
      _$BookingModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get externalId;
  @override
  String? get status;
  @override
  num? get collectionAmount;
  @override
  String? get collectionStatus;
  @override
  num? get disbursementAmount;
  @override
  String? get disbursementStatus;
  @override
  String? get reversalStatus;
  @override
  String? get bookingAcceptanceStatus;
  @override
  String? get vendorPickupStatus;
  @override
  String? get userPickupStatus;
  @override
  String? get vendorDropOffStatus;
  @override
  String? get userDropOffStatus;
  @override
  String? get bookingNumber;
  @override
  BookedProductModel? get bookedProduct;
  @override
  bool get userHasReported;
  @override
  bool get vendorHasReported;
  @override
  UserModel? get vendor;
  @override
  UserModel? get user;
  @override
  @JsonKey(ignore: true)
  _$$BookingModelImplCopyWith<_$BookingModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
