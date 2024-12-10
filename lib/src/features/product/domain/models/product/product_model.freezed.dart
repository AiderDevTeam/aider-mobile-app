// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) {
  return _ProductModel.fromJson(json);
}

/// @nodoc
mixin _$ProductModel {
  int? get id => throw _privateConstructorUsedError;
  String? get externalId => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  int? get quantity => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  num? get value => throw _privateConstructorUsedError;
  String? get postedAt => throw _privateConstructorUsedError;
  List<ProductPriceModel>? get prices => throw _privateConstructorUsedError;
  List<ProductPhotoModel>? get photos => throw _privateConstructorUsedError;
  String? get shareLink => throw _privateConstructorUsedError;
  AddressModel? get address => throw _privateConstructorUsedError;
  UserModel? get user => throw _privateConstructorUsedError;
  SubCategoryItemModel? get subCategoryItem =>
      throw _privateConstructorUsedError;
  num? get rating => throw _privateConstructorUsedError;
  List<BookingDateModel>? get unavailableBookingDates =>
      throw _privateConstructorUsedError;
  List<ReviewModel>? get reviews => throw _privateConstructorUsedError;

  /// Serializes this ProductModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProductModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductModelCopyWith<ProductModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductModelCopyWith<$Res> {
  factory $ProductModelCopyWith(
          ProductModel value, $Res Function(ProductModel) then) =
      _$ProductModelCopyWithImpl<$Res, ProductModel>;
  @useResult
  $Res call(
      {int? id,
      String? externalId,
      String? name,
      String? description,
      int? quantity,
      String? status,
      num? value,
      String? postedAt,
      List<ProductPriceModel>? prices,
      List<ProductPhotoModel>? photos,
      String? shareLink,
      AddressModel? address,
      UserModel? user,
      SubCategoryItemModel? subCategoryItem,
      num? rating,
      List<BookingDateModel>? unavailableBookingDates,
      List<ReviewModel>? reviews});

  $AddressModelCopyWith<$Res>? get address;
  $UserModelCopyWith<$Res>? get user;
  $SubCategoryItemModelCopyWith<$Res>? get subCategoryItem;
}

/// @nodoc
class _$ProductModelCopyWithImpl<$Res, $Val extends ProductModel>
    implements $ProductModelCopyWith<$Res> {
  _$ProductModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? externalId = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? quantity = freezed,
    Object? status = freezed,
    Object? value = freezed,
    Object? postedAt = freezed,
    Object? prices = freezed,
    Object? photos = freezed,
    Object? shareLink = freezed,
    Object? address = freezed,
    Object? user = freezed,
    Object? subCategoryItem = freezed,
    Object? rating = freezed,
    Object? unavailableBookingDates = freezed,
    Object? reviews = freezed,
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
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as num?,
      postedAt: freezed == postedAt
          ? _value.postedAt
          : postedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      prices: freezed == prices
          ? _value.prices
          : prices // ignore: cast_nullable_to_non_nullable
              as List<ProductPriceModel>?,
      photos: freezed == photos
          ? _value.photos
          : photos // ignore: cast_nullable_to_non_nullable
              as List<ProductPhotoModel>?,
      shareLink: freezed == shareLink
          ? _value.shareLink
          : shareLink // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as AddressModel?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      subCategoryItem: freezed == subCategoryItem
          ? _value.subCategoryItem
          : subCategoryItem // ignore: cast_nullable_to_non_nullable
              as SubCategoryItemModel?,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as num?,
      unavailableBookingDates: freezed == unavailableBookingDates
          ? _value.unavailableBookingDates
          : unavailableBookingDates // ignore: cast_nullable_to_non_nullable
              as List<BookingDateModel>?,
      reviews: freezed == reviews
          ? _value.reviews
          : reviews // ignore: cast_nullable_to_non_nullable
              as List<ReviewModel>?,
    ) as $Val);
  }

  /// Create a copy of ProductModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressModelCopyWith<$Res>? get address {
    if (_value.address == null) {
      return null;
    }

    return $AddressModelCopyWith<$Res>(_value.address!, (value) {
      return _then(_value.copyWith(address: value) as $Val);
    });
  }

  /// Create a copy of ProductModel
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

  /// Create a copy of ProductModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SubCategoryItemModelCopyWith<$Res>? get subCategoryItem {
    if (_value.subCategoryItem == null) {
      return null;
    }

    return $SubCategoryItemModelCopyWith<$Res>(_value.subCategoryItem!,
        (value) {
      return _then(_value.copyWith(subCategoryItem: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProductModelImplCopyWith<$Res>
    implements $ProductModelCopyWith<$Res> {
  factory _$$ProductModelImplCopyWith(
          _$ProductModelImpl value, $Res Function(_$ProductModelImpl) then) =
      __$$ProductModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? externalId,
      String? name,
      String? description,
      int? quantity,
      String? status,
      num? value,
      String? postedAt,
      List<ProductPriceModel>? prices,
      List<ProductPhotoModel>? photos,
      String? shareLink,
      AddressModel? address,
      UserModel? user,
      SubCategoryItemModel? subCategoryItem,
      num? rating,
      List<BookingDateModel>? unavailableBookingDates,
      List<ReviewModel>? reviews});

  @override
  $AddressModelCopyWith<$Res>? get address;
  @override
  $UserModelCopyWith<$Res>? get user;
  @override
  $SubCategoryItemModelCopyWith<$Res>? get subCategoryItem;
}

/// @nodoc
class __$$ProductModelImplCopyWithImpl<$Res>
    extends _$ProductModelCopyWithImpl<$Res, _$ProductModelImpl>
    implements _$$ProductModelImplCopyWith<$Res> {
  __$$ProductModelImplCopyWithImpl(
      _$ProductModelImpl _value, $Res Function(_$ProductModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? externalId = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? quantity = freezed,
    Object? status = freezed,
    Object? value = freezed,
    Object? postedAt = freezed,
    Object? prices = freezed,
    Object? photos = freezed,
    Object? shareLink = freezed,
    Object? address = freezed,
    Object? user = freezed,
    Object? subCategoryItem = freezed,
    Object? rating = freezed,
    Object? unavailableBookingDates = freezed,
    Object? reviews = freezed,
  }) {
    return _then(_$ProductModelImpl(
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
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as num?,
      postedAt: freezed == postedAt
          ? _value.postedAt
          : postedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      prices: freezed == prices
          ? _value._prices
          : prices // ignore: cast_nullable_to_non_nullable
              as List<ProductPriceModel>?,
      photos: freezed == photos
          ? _value._photos
          : photos // ignore: cast_nullable_to_non_nullable
              as List<ProductPhotoModel>?,
      shareLink: freezed == shareLink
          ? _value.shareLink
          : shareLink // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as AddressModel?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      subCategoryItem: freezed == subCategoryItem
          ? _value.subCategoryItem
          : subCategoryItem // ignore: cast_nullable_to_non_nullable
              as SubCategoryItemModel?,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as num?,
      unavailableBookingDates: freezed == unavailableBookingDates
          ? _value._unavailableBookingDates
          : unavailableBookingDates // ignore: cast_nullable_to_non_nullable
              as List<BookingDateModel>?,
      reviews: freezed == reviews
          ? _value._reviews
          : reviews // ignore: cast_nullable_to_non_nullable
              as List<ReviewModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductModelImpl extends _ProductModel {
  const _$ProductModelImpl(
      {this.id,
      this.externalId,
      this.name,
      this.description,
      this.quantity,
      this.status,
      this.value,
      this.postedAt,
      final List<ProductPriceModel>? prices,
      final List<ProductPhotoModel>? photos,
      this.shareLink,
      this.address,
      this.user,
      this.subCategoryItem,
      this.rating,
      final List<BookingDateModel>? unavailableBookingDates,
      final List<ReviewModel>? reviews})
      : _prices = prices,
        _photos = photos,
        _unavailableBookingDates = unavailableBookingDates,
        _reviews = reviews,
        super._();

  factory _$ProductModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? externalId;
  @override
  final String? name;
  @override
  final String? description;
  @override
  final int? quantity;
  @override
  final String? status;
  @override
  final num? value;
  @override
  final String? postedAt;
  final List<ProductPriceModel>? _prices;
  @override
  List<ProductPriceModel>? get prices {
    final value = _prices;
    if (value == null) return null;
    if (_prices is EqualUnmodifiableListView) return _prices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ProductPhotoModel>? _photos;
  @override
  List<ProductPhotoModel>? get photos {
    final value = _photos;
    if (value == null) return null;
    if (_photos is EqualUnmodifiableListView) return _photos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? shareLink;
  @override
  final AddressModel? address;
  @override
  final UserModel? user;
  @override
  final SubCategoryItemModel? subCategoryItem;
  @override
  final num? rating;
  final List<BookingDateModel>? _unavailableBookingDates;
  @override
  List<BookingDateModel>? get unavailableBookingDates {
    final value = _unavailableBookingDates;
    if (value == null) return null;
    if (_unavailableBookingDates is EqualUnmodifiableListView)
      return _unavailableBookingDates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ReviewModel>? _reviews;
  @override
  List<ReviewModel>? get reviews {
    final value = _reviews;
    if (value == null) return null;
    if (_reviews is EqualUnmodifiableListView) return _reviews;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ProductModel(id: $id, externalId: $externalId, name: $name, description: $description, quantity: $quantity, status: $status, value: $value, postedAt: $postedAt, prices: $prices, photos: $photos, shareLink: $shareLink, address: $address, user: $user, subCategoryItem: $subCategoryItem, rating: $rating, unavailableBookingDates: $unavailableBookingDates, reviews: $reviews)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.externalId, externalId) ||
                other.externalId == externalId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.postedAt, postedAt) ||
                other.postedAt == postedAt) &&
            const DeepCollectionEquality().equals(other._prices, _prices) &&
            const DeepCollectionEquality().equals(other._photos, _photos) &&
            (identical(other.shareLink, shareLink) ||
                other.shareLink == shareLink) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.subCategoryItem, subCategoryItem) ||
                other.subCategoryItem == subCategoryItem) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            const DeepCollectionEquality().equals(
                other._unavailableBookingDates, _unavailableBookingDates) &&
            const DeepCollectionEquality().equals(other._reviews, _reviews));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      externalId,
      name,
      description,
      quantity,
      status,
      value,
      postedAt,
      const DeepCollectionEquality().hash(_prices),
      const DeepCollectionEquality().hash(_photos),
      shareLink,
      address,
      user,
      subCategoryItem,
      rating,
      const DeepCollectionEquality().hash(_unavailableBookingDates),
      const DeepCollectionEquality().hash(_reviews));

  /// Create a copy of ProductModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductModelImplCopyWith<_$ProductModelImpl> get copyWith =>
      __$$ProductModelImplCopyWithImpl<_$ProductModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductModelImplToJson(
      this,
    );
  }
}

abstract class _ProductModel extends ProductModel {
  const factory _ProductModel(
      {final int? id,
      final String? externalId,
      final String? name,
      final String? description,
      final int? quantity,
      final String? status,
      final num? value,
      final String? postedAt,
      final List<ProductPriceModel>? prices,
      final List<ProductPhotoModel>? photos,
      final String? shareLink,
      final AddressModel? address,
      final UserModel? user,
      final SubCategoryItemModel? subCategoryItem,
      final num? rating,
      final List<BookingDateModel>? unavailableBookingDates,
      final List<ReviewModel>? reviews}) = _$ProductModelImpl;
  const _ProductModel._() : super._();

  factory _ProductModel.fromJson(Map<String, dynamic> json) =
      _$ProductModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get externalId;
  @override
  String? get name;
  @override
  String? get description;
  @override
  int? get quantity;
  @override
  String? get status;
  @override
  num? get value;
  @override
  String? get postedAt;
  @override
  List<ProductPriceModel>? get prices;
  @override
  List<ProductPhotoModel>? get photos;
  @override
  String? get shareLink;
  @override
  AddressModel? get address;
  @override
  UserModel? get user;
  @override
  SubCategoryItemModel? get subCategoryItem;
  @override
  num? get rating;
  @override
  List<BookingDateModel>? get unavailableBookingDates;
  @override
  List<ReviewModel>? get reviews;

  /// Create a copy of ProductModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductModelImplCopyWith<_$ProductModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
