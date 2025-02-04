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
  String? get uid => throw _privateConstructorUsedError;
  String? get externalId => throw _privateConstructorUsedError;
  BookingStatus? get status => throw _privateConstructorUsedError;
  num? get collectionAmount => throw _privateConstructorUsedError;
  BookingProgressStatus? get collectionStatus =>
      throw _privateConstructorUsedError;
  num? get disbursementAmount => throw _privateConstructorUsedError;
  BookingProgressStatus? get disbursementStatus =>
      throw _privateConstructorUsedError;
  BookingProgressStatus? get reversalStatus =>
      throw _privateConstructorUsedError;
  BookingProgressStatus? get bookingAcceptanceStatus =>
      throw _privateConstructorUsedError;
  BookingProgressStatus? get vendorPickupStatus =>
      throw _privateConstructorUsedError;
  BookingProgressStatus? get userPickupStatus =>
      throw _privateConstructorUsedError;
  BookingProgressStatus? get vendorDropOffStatus =>
      throw _privateConstructorUsedError;
  BookingProgressStatus? get userDropOffStatus =>
      throw _privateConstructorUsedError;
  String? get bookingNumber => throw _privateConstructorUsedError;
  String? get productUid => throw _privateConstructorUsedError;
  String? get userUid => throw _privateConstructorUsedError;
  String? get vendorUid => throw _privateConstructorUsedError;
  BookedProductModel? get bookedProduct => throw _privateConstructorUsedError;
  bool get userHasReported => throw _privateConstructorUsedError;
  bool get vendorHasReported => throw _privateConstructorUsedError;
  UserModel? get vendor => throw _privateConstructorUsedError;
  UserModel? get user => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this BookingModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BookingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
      String? uid,
      String? externalId,
      BookingStatus? status,
      num? collectionAmount,
      BookingProgressStatus? collectionStatus,
      num? disbursementAmount,
      BookingProgressStatus? disbursementStatus,
      BookingProgressStatus? reversalStatus,
      BookingProgressStatus? bookingAcceptanceStatus,
      BookingProgressStatus? vendorPickupStatus,
      BookingProgressStatus? userPickupStatus,
      BookingProgressStatus? vendorDropOffStatus,
      BookingProgressStatus? userDropOffStatus,
      String? bookingNumber,
      String? productUid,
      String? userUid,
      String? vendorUid,
      BookedProductModel? bookedProduct,
      bool userHasReported,
      bool vendorHasReported,
      UserModel? vendor,
      UserModel? user,
      DateTime? createdAt});

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

  /// Create a copy of BookingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? uid = freezed,
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
    Object? productUid = freezed,
    Object? userUid = freezed,
    Object? vendorUid = freezed,
    Object? bookedProduct = freezed,
    Object? userHasReported = null,
    Object? vendorHasReported = null,
    Object? vendor = freezed,
    Object? user = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      externalId: freezed == externalId
          ? _value.externalId
          : externalId // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as BookingStatus?,
      collectionAmount: freezed == collectionAmount
          ? _value.collectionAmount
          : collectionAmount // ignore: cast_nullable_to_non_nullable
              as num?,
      collectionStatus: freezed == collectionStatus
          ? _value.collectionStatus
          : collectionStatus // ignore: cast_nullable_to_non_nullable
              as BookingProgressStatus?,
      disbursementAmount: freezed == disbursementAmount
          ? _value.disbursementAmount
          : disbursementAmount // ignore: cast_nullable_to_non_nullable
              as num?,
      disbursementStatus: freezed == disbursementStatus
          ? _value.disbursementStatus
          : disbursementStatus // ignore: cast_nullable_to_non_nullable
              as BookingProgressStatus?,
      reversalStatus: freezed == reversalStatus
          ? _value.reversalStatus
          : reversalStatus // ignore: cast_nullable_to_non_nullable
              as BookingProgressStatus?,
      bookingAcceptanceStatus: freezed == bookingAcceptanceStatus
          ? _value.bookingAcceptanceStatus
          : bookingAcceptanceStatus // ignore: cast_nullable_to_non_nullable
              as BookingProgressStatus?,
      vendorPickupStatus: freezed == vendorPickupStatus
          ? _value.vendorPickupStatus
          : vendorPickupStatus // ignore: cast_nullable_to_non_nullable
              as BookingProgressStatus?,
      userPickupStatus: freezed == userPickupStatus
          ? _value.userPickupStatus
          : userPickupStatus // ignore: cast_nullable_to_non_nullable
              as BookingProgressStatus?,
      vendorDropOffStatus: freezed == vendorDropOffStatus
          ? _value.vendorDropOffStatus
          : vendorDropOffStatus // ignore: cast_nullable_to_non_nullable
              as BookingProgressStatus?,
      userDropOffStatus: freezed == userDropOffStatus
          ? _value.userDropOffStatus
          : userDropOffStatus // ignore: cast_nullable_to_non_nullable
              as BookingProgressStatus?,
      bookingNumber: freezed == bookingNumber
          ? _value.bookingNumber
          : bookingNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      productUid: freezed == productUid
          ? _value.productUid
          : productUid // ignore: cast_nullable_to_non_nullable
              as String?,
      userUid: freezed == userUid
          ? _value.userUid
          : userUid // ignore: cast_nullable_to_non_nullable
              as String?,
      vendorUid: freezed == vendorUid
          ? _value.vendorUid
          : vendorUid // ignore: cast_nullable_to_non_nullable
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
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  /// Create a copy of BookingModel
  /// with the given fields replaced by the non-null parameter values.
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

  /// Create a copy of BookingModel
  /// with the given fields replaced by the non-null parameter values.
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

  /// Create a copy of BookingModel
  /// with the given fields replaced by the non-null parameter values.
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
      String? uid,
      String? externalId,
      BookingStatus? status,
      num? collectionAmount,
      BookingProgressStatus? collectionStatus,
      num? disbursementAmount,
      BookingProgressStatus? disbursementStatus,
      BookingProgressStatus? reversalStatus,
      BookingProgressStatus? bookingAcceptanceStatus,
      BookingProgressStatus? vendorPickupStatus,
      BookingProgressStatus? userPickupStatus,
      BookingProgressStatus? vendorDropOffStatus,
      BookingProgressStatus? userDropOffStatus,
      String? bookingNumber,
      String? productUid,
      String? userUid,
      String? vendorUid,
      BookedProductModel? bookedProduct,
      bool userHasReported,
      bool vendorHasReported,
      UserModel? vendor,
      UserModel? user,
      DateTime? createdAt});

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

  /// Create a copy of BookingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? uid = freezed,
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
    Object? productUid = freezed,
    Object? userUid = freezed,
    Object? vendorUid = freezed,
    Object? bookedProduct = freezed,
    Object? userHasReported = null,
    Object? vendorHasReported = null,
    Object? vendor = freezed,
    Object? user = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$BookingModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      externalId: freezed == externalId
          ? _value.externalId
          : externalId // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as BookingStatus?,
      collectionAmount: freezed == collectionAmount
          ? _value.collectionAmount
          : collectionAmount // ignore: cast_nullable_to_non_nullable
              as num?,
      collectionStatus: freezed == collectionStatus
          ? _value.collectionStatus
          : collectionStatus // ignore: cast_nullable_to_non_nullable
              as BookingProgressStatus?,
      disbursementAmount: freezed == disbursementAmount
          ? _value.disbursementAmount
          : disbursementAmount // ignore: cast_nullable_to_non_nullable
              as num?,
      disbursementStatus: freezed == disbursementStatus
          ? _value.disbursementStatus
          : disbursementStatus // ignore: cast_nullable_to_non_nullable
              as BookingProgressStatus?,
      reversalStatus: freezed == reversalStatus
          ? _value.reversalStatus
          : reversalStatus // ignore: cast_nullable_to_non_nullable
              as BookingProgressStatus?,
      bookingAcceptanceStatus: freezed == bookingAcceptanceStatus
          ? _value.bookingAcceptanceStatus
          : bookingAcceptanceStatus // ignore: cast_nullable_to_non_nullable
              as BookingProgressStatus?,
      vendorPickupStatus: freezed == vendorPickupStatus
          ? _value.vendorPickupStatus
          : vendorPickupStatus // ignore: cast_nullable_to_non_nullable
              as BookingProgressStatus?,
      userPickupStatus: freezed == userPickupStatus
          ? _value.userPickupStatus
          : userPickupStatus // ignore: cast_nullable_to_non_nullable
              as BookingProgressStatus?,
      vendorDropOffStatus: freezed == vendorDropOffStatus
          ? _value.vendorDropOffStatus
          : vendorDropOffStatus // ignore: cast_nullable_to_non_nullable
              as BookingProgressStatus?,
      userDropOffStatus: freezed == userDropOffStatus
          ? _value.userDropOffStatus
          : userDropOffStatus // ignore: cast_nullable_to_non_nullable
              as BookingProgressStatus?,
      bookingNumber: freezed == bookingNumber
          ? _value.bookingNumber
          : bookingNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      productUid: freezed == productUid
          ? _value.productUid
          : productUid // ignore: cast_nullable_to_non_nullable
              as String?,
      userUid: freezed == userUid
          ? _value.userUid
          : userUid // ignore: cast_nullable_to_non_nullable
              as String?,
      vendorUid: freezed == vendorUid
          ? _value.vendorUid
          : vendorUid // ignore: cast_nullable_to_non_nullable
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
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BookingModelImpl extends _BookingModel {
  const _$BookingModelImpl(
      {this.id,
      this.uid,
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
      this.productUid,
      this.userUid,
      this.vendorUid,
      this.bookedProduct,
      this.userHasReported = false,
      this.vendorHasReported = false,
      this.vendor,
      this.user,
      this.createdAt})
      : super._();

  factory _$BookingModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookingModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? uid;
  @override
  final String? externalId;
  @override
  final BookingStatus? status;
  @override
  final num? collectionAmount;
  @override
  final BookingProgressStatus? collectionStatus;
  @override
  final num? disbursementAmount;
  @override
  final BookingProgressStatus? disbursementStatus;
  @override
  final BookingProgressStatus? reversalStatus;
  @override
  final BookingProgressStatus? bookingAcceptanceStatus;
  @override
  final BookingProgressStatus? vendorPickupStatus;
  @override
  final BookingProgressStatus? userPickupStatus;
  @override
  final BookingProgressStatus? vendorDropOffStatus;
  @override
  final BookingProgressStatus? userDropOffStatus;
  @override
  final String? bookingNumber;
  @override
  final String? productUid;
  @override
  final String? userUid;
  @override
  final String? vendorUid;
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
  final DateTime? createdAt;

  @override
  String toString() {
    return 'BookingModel(id: $id, uid: $uid, externalId: $externalId, status: $status, collectionAmount: $collectionAmount, collectionStatus: $collectionStatus, disbursementAmount: $disbursementAmount, disbursementStatus: $disbursementStatus, reversalStatus: $reversalStatus, bookingAcceptanceStatus: $bookingAcceptanceStatus, vendorPickupStatus: $vendorPickupStatus, userPickupStatus: $userPickupStatus, vendorDropOffStatus: $vendorDropOffStatus, userDropOffStatus: $userDropOffStatus, bookingNumber: $bookingNumber, productUid: $productUid, userUid: $userUid, vendorUid: $vendorUid, bookedProduct: $bookedProduct, userHasReported: $userHasReported, vendorHasReported: $vendorHasReported, vendor: $vendor, user: $user, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookingModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.uid, uid) || other.uid == uid) &&
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
            (identical(other.productUid, productUid) ||
                other.productUid == productUid) &&
            (identical(other.userUid, userUid) || other.userUid == userUid) &&
            (identical(other.vendorUid, vendorUid) ||
                other.vendorUid == vendorUid) &&
            (identical(other.bookedProduct, bookedProduct) ||
                other.bookedProduct == bookedProduct) &&
            (identical(other.userHasReported, userHasReported) ||
                other.userHasReported == userHasReported) &&
            (identical(other.vendorHasReported, vendorHasReported) ||
                other.vendorHasReported == vendorHasReported) &&
            (identical(other.vendor, vendor) || other.vendor == vendor) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        uid,
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
        productUid,
        userUid,
        vendorUid,
        bookedProduct,
        userHasReported,
        vendorHasReported,
        vendor,
        user,
        createdAt
      ]);

  /// Create a copy of BookingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
      final String? uid,
      final String? externalId,
      final BookingStatus? status,
      final num? collectionAmount,
      final BookingProgressStatus? collectionStatus,
      final num? disbursementAmount,
      final BookingProgressStatus? disbursementStatus,
      final BookingProgressStatus? reversalStatus,
      final BookingProgressStatus? bookingAcceptanceStatus,
      final BookingProgressStatus? vendorPickupStatus,
      final BookingProgressStatus? userPickupStatus,
      final BookingProgressStatus? vendorDropOffStatus,
      final BookingProgressStatus? userDropOffStatus,
      final String? bookingNumber,
      final String? productUid,
      final String? userUid,
      final String? vendorUid,
      final BookedProductModel? bookedProduct,
      final bool userHasReported,
      final bool vendorHasReported,
      final UserModel? vendor,
      final UserModel? user,
      final DateTime? createdAt}) = _$BookingModelImpl;
  const _BookingModel._() : super._();

  factory _BookingModel.fromJson(Map<String, dynamic> json) =
      _$BookingModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get uid;
  @override
  String? get externalId;
  @override
  BookingStatus? get status;
  @override
  num? get collectionAmount;
  @override
  BookingProgressStatus? get collectionStatus;
  @override
  num? get disbursementAmount;
  @override
  BookingProgressStatus? get disbursementStatus;
  @override
  BookingProgressStatus? get reversalStatus;
  @override
  BookingProgressStatus? get bookingAcceptanceStatus;
  @override
  BookingProgressStatus? get vendorPickupStatus;
  @override
  BookingProgressStatus? get userPickupStatus;
  @override
  BookingProgressStatus? get vendorDropOffStatus;
  @override
  BookingProgressStatus? get userDropOffStatus;
  @override
  String? get bookingNumber;
  @override
  String? get productUid;
  @override
  String? get userUid;
  @override
  String? get vendorUid;
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
  DateTime? get createdAt;

  /// Create a copy of BookingModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookingModelImplCopyWith<_$BookingModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
