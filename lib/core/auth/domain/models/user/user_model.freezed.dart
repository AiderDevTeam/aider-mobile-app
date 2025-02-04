// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  int? get id => throw _privateConstructorUsedError;
  String? get uid => throw _privateConstructorUsedError;
  String? get externalId => throw _privateConstructorUsedError;
  String? get firstName => throw _privateConstructorUsedError;
  String? get lastName => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get password => throw _privateConstructorUsedError;
  String? get callingCode => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get birthday => throw _privateConstructorUsedError;
  String? get idVerificationStatus => throw _privateConstructorUsedError;
  bool? get idVerified => throw _privateConstructorUsedError;
  String? get profilePhotoUrl => throw _privateConstructorUsedError;
  int? get itemsListed => throw _privateConstructorUsedError;
  List<AddressModel>? get addresses => throw _privateConstructorUsedError;
  StatisticModel? get statistics => throw _privateConstructorUsedError;
  List<WalletModel>? get wallets => throw _privateConstructorUsedError;
  List<VerificationModel>? get userIdentifications =>
      throw _privateConstructorUsedError;
  bool? get canReceiveSMS => throw _privateConstructorUsedError;
  bool? get canReceiveEmailUpdates => throw _privateConstructorUsedError;
  bool? get canReceivePushNotifications => throw _privateConstructorUsedError;
  bool? get hasDefaultWallet => throw _privateConstructorUsedError;
  String? get pushNotificationToken => throw _privateConstructorUsedError;
  String? get userTypeId => throw _privateConstructorUsedError;
  bool? get termsAndConditions => throw _privateConstructorUsedError;
  String? get deviceOs => throw _privateConstructorUsedError;

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call(
      {int? id,
      String? uid,
      String? externalId,
      String? firstName,
      String? lastName,
      String? displayName,
      String? gender,
      String? email,
      String? password,
      String? callingCode,
      String? phone,
      String? birthday,
      String? idVerificationStatus,
      bool? idVerified,
      String? profilePhotoUrl,
      int? itemsListed,
      List<AddressModel>? addresses,
      StatisticModel? statistics,
      List<WalletModel>? wallets,
      List<VerificationModel>? userIdentifications,
      bool? canReceiveSMS,
      bool? canReceiveEmailUpdates,
      bool? canReceivePushNotifications,
      bool? hasDefaultWallet,
      String? pushNotificationToken,
      String? userTypeId,
      bool? termsAndConditions,
      String? deviceOs});

  $StatisticModelCopyWith<$Res>? get statistics;
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? uid = freezed,
    Object? externalId = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? displayName = freezed,
    Object? gender = freezed,
    Object? email = freezed,
    Object? password = freezed,
    Object? callingCode = freezed,
    Object? phone = freezed,
    Object? birthday = freezed,
    Object? idVerificationStatus = freezed,
    Object? idVerified = freezed,
    Object? profilePhotoUrl = freezed,
    Object? itemsListed = freezed,
    Object? addresses = freezed,
    Object? statistics = freezed,
    Object? wallets = freezed,
    Object? userIdentifications = freezed,
    Object? canReceiveSMS = freezed,
    Object? canReceiveEmailUpdates = freezed,
    Object? canReceivePushNotifications = freezed,
    Object? hasDefaultWallet = freezed,
    Object? pushNotificationToken = freezed,
    Object? userTypeId = freezed,
    Object? termsAndConditions = freezed,
    Object? deviceOs = freezed,
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
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      callingCode: freezed == callingCode
          ? _value.callingCode
          : callingCode // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      birthday: freezed == birthday
          ? _value.birthday
          : birthday // ignore: cast_nullable_to_non_nullable
              as String?,
      idVerificationStatus: freezed == idVerificationStatus
          ? _value.idVerificationStatus
          : idVerificationStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      idVerified: freezed == idVerified
          ? _value.idVerified
          : idVerified // ignore: cast_nullable_to_non_nullable
              as bool?,
      profilePhotoUrl: freezed == profilePhotoUrl
          ? _value.profilePhotoUrl
          : profilePhotoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      itemsListed: freezed == itemsListed
          ? _value.itemsListed
          : itemsListed // ignore: cast_nullable_to_non_nullable
              as int?,
      addresses: freezed == addresses
          ? _value.addresses
          : addresses // ignore: cast_nullable_to_non_nullable
              as List<AddressModel>?,
      statistics: freezed == statistics
          ? _value.statistics
          : statistics // ignore: cast_nullable_to_non_nullable
              as StatisticModel?,
      wallets: freezed == wallets
          ? _value.wallets
          : wallets // ignore: cast_nullable_to_non_nullable
              as List<WalletModel>?,
      userIdentifications: freezed == userIdentifications
          ? _value.userIdentifications
          : userIdentifications // ignore: cast_nullable_to_non_nullable
              as List<VerificationModel>?,
      canReceiveSMS: freezed == canReceiveSMS
          ? _value.canReceiveSMS
          : canReceiveSMS // ignore: cast_nullable_to_non_nullable
              as bool?,
      canReceiveEmailUpdates: freezed == canReceiveEmailUpdates
          ? _value.canReceiveEmailUpdates
          : canReceiveEmailUpdates // ignore: cast_nullable_to_non_nullable
              as bool?,
      canReceivePushNotifications: freezed == canReceivePushNotifications
          ? _value.canReceivePushNotifications
          : canReceivePushNotifications // ignore: cast_nullable_to_non_nullable
              as bool?,
      hasDefaultWallet: freezed == hasDefaultWallet
          ? _value.hasDefaultWallet
          : hasDefaultWallet // ignore: cast_nullable_to_non_nullable
              as bool?,
      pushNotificationToken: freezed == pushNotificationToken
          ? _value.pushNotificationToken
          : pushNotificationToken // ignore: cast_nullable_to_non_nullable
              as String?,
      userTypeId: freezed == userTypeId
          ? _value.userTypeId
          : userTypeId // ignore: cast_nullable_to_non_nullable
              as String?,
      termsAndConditions: freezed == termsAndConditions
          ? _value.termsAndConditions
          : termsAndConditions // ignore: cast_nullable_to_non_nullable
              as bool?,
      deviceOs: freezed == deviceOs
          ? _value.deviceOs
          : deviceOs // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StatisticModelCopyWith<$Res>? get statistics {
    if (_value.statistics == null) {
      return null;
    }

    return $StatisticModelCopyWith<$Res>(_value.statistics!, (value) {
      return _then(_value.copyWith(statistics: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
          _$UserModelImpl value, $Res Function(_$UserModelImpl) then) =
      __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? uid,
      String? externalId,
      String? firstName,
      String? lastName,
      String? displayName,
      String? gender,
      String? email,
      String? password,
      String? callingCode,
      String? phone,
      String? birthday,
      String? idVerificationStatus,
      bool? idVerified,
      String? profilePhotoUrl,
      int? itemsListed,
      List<AddressModel>? addresses,
      StatisticModel? statistics,
      List<WalletModel>? wallets,
      List<VerificationModel>? userIdentifications,
      bool? canReceiveSMS,
      bool? canReceiveEmailUpdates,
      bool? canReceivePushNotifications,
      bool? hasDefaultWallet,
      String? pushNotificationToken,
      String? userTypeId,
      bool? termsAndConditions,
      String? deviceOs});

  @override
  $StatisticModelCopyWith<$Res>? get statistics;
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
      _$UserModelImpl _value, $Res Function(_$UserModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? uid = freezed,
    Object? externalId = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? displayName = freezed,
    Object? gender = freezed,
    Object? email = freezed,
    Object? password = freezed,
    Object? callingCode = freezed,
    Object? phone = freezed,
    Object? birthday = freezed,
    Object? idVerificationStatus = freezed,
    Object? idVerified = freezed,
    Object? profilePhotoUrl = freezed,
    Object? itemsListed = freezed,
    Object? addresses = freezed,
    Object? statistics = freezed,
    Object? wallets = freezed,
    Object? userIdentifications = freezed,
    Object? canReceiveSMS = freezed,
    Object? canReceiveEmailUpdates = freezed,
    Object? canReceivePushNotifications = freezed,
    Object? hasDefaultWallet = freezed,
    Object? pushNotificationToken = freezed,
    Object? userTypeId = freezed,
    Object? termsAndConditions = freezed,
    Object? deviceOs = freezed,
  }) {
    return _then(_$UserModelImpl(
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
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      callingCode: freezed == callingCode
          ? _value.callingCode
          : callingCode // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      birthday: freezed == birthday
          ? _value.birthday
          : birthday // ignore: cast_nullable_to_non_nullable
              as String?,
      idVerificationStatus: freezed == idVerificationStatus
          ? _value.idVerificationStatus
          : idVerificationStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      idVerified: freezed == idVerified
          ? _value.idVerified
          : idVerified // ignore: cast_nullable_to_non_nullable
              as bool?,
      profilePhotoUrl: freezed == profilePhotoUrl
          ? _value.profilePhotoUrl
          : profilePhotoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      itemsListed: freezed == itemsListed
          ? _value.itemsListed
          : itemsListed // ignore: cast_nullable_to_non_nullable
              as int?,
      addresses: freezed == addresses
          ? _value._addresses
          : addresses // ignore: cast_nullable_to_non_nullable
              as List<AddressModel>?,
      statistics: freezed == statistics
          ? _value.statistics
          : statistics // ignore: cast_nullable_to_non_nullable
              as StatisticModel?,
      wallets: freezed == wallets
          ? _value._wallets
          : wallets // ignore: cast_nullable_to_non_nullable
              as List<WalletModel>?,
      userIdentifications: freezed == userIdentifications
          ? _value._userIdentifications
          : userIdentifications // ignore: cast_nullable_to_non_nullable
              as List<VerificationModel>?,
      canReceiveSMS: freezed == canReceiveSMS
          ? _value.canReceiveSMS
          : canReceiveSMS // ignore: cast_nullable_to_non_nullable
              as bool?,
      canReceiveEmailUpdates: freezed == canReceiveEmailUpdates
          ? _value.canReceiveEmailUpdates
          : canReceiveEmailUpdates // ignore: cast_nullable_to_non_nullable
              as bool?,
      canReceivePushNotifications: freezed == canReceivePushNotifications
          ? _value.canReceivePushNotifications
          : canReceivePushNotifications // ignore: cast_nullable_to_non_nullable
              as bool?,
      hasDefaultWallet: freezed == hasDefaultWallet
          ? _value.hasDefaultWallet
          : hasDefaultWallet // ignore: cast_nullable_to_non_nullable
              as bool?,
      pushNotificationToken: freezed == pushNotificationToken
          ? _value.pushNotificationToken
          : pushNotificationToken // ignore: cast_nullable_to_non_nullable
              as String?,
      userTypeId: freezed == userTypeId
          ? _value.userTypeId
          : userTypeId // ignore: cast_nullable_to_non_nullable
              as String?,
      termsAndConditions: freezed == termsAndConditions
          ? _value.termsAndConditions
          : termsAndConditions // ignore: cast_nullable_to_non_nullable
              as bool?,
      deviceOs: freezed == deviceOs
          ? _value.deviceOs
          : deviceOs // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserModelImpl extends _UserModel {
  const _$UserModelImpl(
      {this.id,
      this.uid,
      this.externalId,
      this.firstName,
      this.lastName,
      this.displayName,
      this.gender,
      this.email,
      this.password,
      this.callingCode,
      this.phone,
      this.birthday,
      this.idVerificationStatus,
      this.idVerified,
      this.profilePhotoUrl,
      this.itemsListed,
      final List<AddressModel>? addresses,
      this.statistics,
      final List<WalletModel>? wallets,
      final List<VerificationModel>? userIdentifications,
      this.canReceiveSMS,
      this.canReceiveEmailUpdates,
      this.canReceivePushNotifications,
      this.hasDefaultWallet,
      this.pushNotificationToken,
      this.userTypeId,
      this.termsAndConditions,
      this.deviceOs})
      : _addresses = addresses,
        _wallets = wallets,
        _userIdentifications = userIdentifications,
        super._();

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? uid;
  @override
  final String? externalId;
  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final String? displayName;
  @override
  final String? gender;
  @override
  final String? email;
  @override
  final String? password;
  @override
  final String? callingCode;
  @override
  final String? phone;
  @override
  final String? birthday;
  @override
  final String? idVerificationStatus;
  @override
  final bool? idVerified;
  @override
  final String? profilePhotoUrl;
  @override
  final int? itemsListed;
  final List<AddressModel>? _addresses;
  @override
  List<AddressModel>? get addresses {
    final value = _addresses;
    if (value == null) return null;
    if (_addresses is EqualUnmodifiableListView) return _addresses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final StatisticModel? statistics;
  final List<WalletModel>? _wallets;
  @override
  List<WalletModel>? get wallets {
    final value = _wallets;
    if (value == null) return null;
    if (_wallets is EqualUnmodifiableListView) return _wallets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<VerificationModel>? _userIdentifications;
  @override
  List<VerificationModel>? get userIdentifications {
    final value = _userIdentifications;
    if (value == null) return null;
    if (_userIdentifications is EqualUnmodifiableListView)
      return _userIdentifications;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final bool? canReceiveSMS;
  @override
  final bool? canReceiveEmailUpdates;
  @override
  final bool? canReceivePushNotifications;
  @override
  final bool? hasDefaultWallet;
  @override
  final String? pushNotificationToken;
  @override
  final String? userTypeId;
  @override
  final bool? termsAndConditions;
  @override
  final String? deviceOs;

  @override
  String toString() {
    return 'UserModel(id: $id, uid: $uid, externalId: $externalId, firstName: $firstName, lastName: $lastName, displayName: $displayName, gender: $gender, email: $email, password: $password, callingCode: $callingCode, phone: $phone, birthday: $birthday, idVerificationStatus: $idVerificationStatus, idVerified: $idVerified, profilePhotoUrl: $profilePhotoUrl, itemsListed: $itemsListed, addresses: $addresses, statistics: $statistics, wallets: $wallets, userIdentifications: $userIdentifications, canReceiveSMS: $canReceiveSMS, canReceiveEmailUpdates: $canReceiveEmailUpdates, canReceivePushNotifications: $canReceivePushNotifications, hasDefaultWallet: $hasDefaultWallet, pushNotificationToken: $pushNotificationToken, userTypeId: $userTypeId, termsAndConditions: $termsAndConditions, deviceOs: $deviceOs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.externalId, externalId) ||
                other.externalId == externalId) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.callingCode, callingCode) ||
                other.callingCode == callingCode) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.birthday, birthday) ||
                other.birthday == birthday) &&
            (identical(other.idVerificationStatus, idVerificationStatus) ||
                other.idVerificationStatus == idVerificationStatus) &&
            (identical(other.idVerified, idVerified) ||
                other.idVerified == idVerified) &&
            (identical(other.profilePhotoUrl, profilePhotoUrl) ||
                other.profilePhotoUrl == profilePhotoUrl) &&
            (identical(other.itemsListed, itemsListed) ||
                other.itemsListed == itemsListed) &&
            const DeepCollectionEquality()
                .equals(other._addresses, _addresses) &&
            (identical(other.statistics, statistics) ||
                other.statistics == statistics) &&
            const DeepCollectionEquality().equals(other._wallets, _wallets) &&
            const DeepCollectionEquality()
                .equals(other._userIdentifications, _userIdentifications) &&
            (identical(other.canReceiveSMS, canReceiveSMS) ||
                other.canReceiveSMS == canReceiveSMS) &&
            (identical(other.canReceiveEmailUpdates, canReceiveEmailUpdates) ||
                other.canReceiveEmailUpdates == canReceiveEmailUpdates) &&
            (identical(other.canReceivePushNotifications,
                    canReceivePushNotifications) ||
                other.canReceivePushNotifications ==
                    canReceivePushNotifications) &&
            (identical(other.hasDefaultWallet, hasDefaultWallet) ||
                other.hasDefaultWallet == hasDefaultWallet) &&
            (identical(other.pushNotificationToken, pushNotificationToken) ||
                other.pushNotificationToken == pushNotificationToken) &&
            (identical(other.userTypeId, userTypeId) ||
                other.userTypeId == userTypeId) &&
            (identical(other.termsAndConditions, termsAndConditions) ||
                other.termsAndConditions == termsAndConditions) &&
            (identical(other.deviceOs, deviceOs) ||
                other.deviceOs == deviceOs));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        uid,
        externalId,
        firstName,
        lastName,
        displayName,
        gender,
        email,
        password,
        callingCode,
        phone,
        birthday,
        idVerificationStatus,
        idVerified,
        profilePhotoUrl,
        itemsListed,
        const DeepCollectionEquality().hash(_addresses),
        statistics,
        const DeepCollectionEquality().hash(_wallets),
        const DeepCollectionEquality().hash(_userIdentifications),
        canReceiveSMS,
        canReceiveEmailUpdates,
        canReceivePushNotifications,
        hasDefaultWallet,
        pushNotificationToken,
        userTypeId,
        termsAndConditions,
        deviceOs
      ]);

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelImplToJson(
      this,
    );
  }
}

abstract class _UserModel extends UserModel {
  const factory _UserModel(
      {final int? id,
      final String? uid,
      final String? externalId,
      final String? firstName,
      final String? lastName,
      final String? displayName,
      final String? gender,
      final String? email,
      final String? password,
      final String? callingCode,
      final String? phone,
      final String? birthday,
      final String? idVerificationStatus,
      final bool? idVerified,
      final String? profilePhotoUrl,
      final int? itemsListed,
      final List<AddressModel>? addresses,
      final StatisticModel? statistics,
      final List<WalletModel>? wallets,
      final List<VerificationModel>? userIdentifications,
      final bool? canReceiveSMS,
      final bool? canReceiveEmailUpdates,
      final bool? canReceivePushNotifications,
      final bool? hasDefaultWallet,
      final String? pushNotificationToken,
      final String? userTypeId,
      final bool? termsAndConditions,
      final String? deviceOs}) = _$UserModelImpl;
  const _UserModel._() : super._();

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get uid;
  @override
  String? get externalId;
  @override
  String? get firstName;
  @override
  String? get lastName;
  @override
  String? get displayName;
  @override
  String? get gender;
  @override
  String? get email;
  @override
  String? get password;
  @override
  String? get callingCode;
  @override
  String? get phone;
  @override
  String? get birthday;
  @override
  String? get idVerificationStatus;
  @override
  bool? get idVerified;
  @override
  String? get profilePhotoUrl;
  @override
  int? get itemsListed;
  @override
  List<AddressModel>? get addresses;
  @override
  StatisticModel? get statistics;
  @override
  List<WalletModel>? get wallets;
  @override
  List<VerificationModel>? get userIdentifications;
  @override
  bool? get canReceiveSMS;
  @override
  bool? get canReceiveEmailUpdates;
  @override
  bool? get canReceivePushNotifications;
  @override
  bool? get hasDefaultWallet;
  @override
  String? get pushNotificationToken;
  @override
  String? get userTypeId;
  @override
  bool? get termsAndConditions;
  @override
  String? get deviceOs;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
