import 'dart:convert';

import 'package:aider_mobile_app/core/domain/models/address/address_model.dart';
import 'package:aider_mobile_app/core/auth/domain/models/user/user_model.dart';
import 'package:aider_mobile_app/core/extensions/string_extension.dart';
import 'package:aider_mobile_app/src/features/review/domain/review/review_model.dart';
import '../booking/booking_date_model.dart';
import '../category/sub_category_item_model.dart';
import '../product_photo/product_photo_model.dart';
import '../product_price/product_price_model.dart';

class ProductModel {
  final int? id;
  final String? uid;
  final String? userUid;
  final String? externalId;
  final String? subCategoryItemId;
  final String? name;
  final String? description;
  final int? quantity;
  final String? status;
  final num? value;
  final String? postedAt;
  final List<ProductPriceModel>? prices;
  final List<ProductPhotoModel>? photos;
  final String? shareLink;
  final AddressModel? address;
  final UserModel? user;
  final SubCategoryItemModel? subCategoryItem;
  final num? rating;
  final List<BookingDateModel>? unavailableBookingDates;
  final List<ReviewModel>? reviews;

  ProductModel({
    this.id,
    this.uid,
    this.userUid,
    this.externalId,
    this.subCategoryItemId,
    this.name,
    this.description,
    this.quantity,
    this.status,
    this.value,
    this.postedAt,
    this.prices,
    this.photos,
    this.shareLink,
    this.address,
    this.user,
    this.subCategoryItem,
    this.rating,
    this.unavailableBookingDates,
    this.reviews,
  });

  ProductModel copyWith({
    String? uid,
    String? userUid,
    String? externalId,
    String? subCategoryItemId,
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
    List<ReviewModel>? reviews,
  }) {
    return ProductModel(
      uid: uid ?? this.uid,
      userUid: userUid ?? this.userUid,
      externalId: externalId ?? this.externalId,
      subCategoryItemId: subCategoryItemId ?? this.subCategoryItemId,
      name: name ?? this.name,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      status: status ?? this.status,
      value: value ?? this.value,
      postedAt: postedAt ?? this.postedAt,
      prices: prices ?? this.prices,
      photos: photos ?? this.photos,
      shareLink: shareLink ?? this.shareLink,
      address: address ?? this.address,
      user: user ?? this.user,
      subCategoryItem: subCategoryItem ?? this.subCategoryItem,
      rating: rating ?? this.rating,
      unavailableBookingDates:
          unavailableBookingDates ?? this.unavailableBookingDates,
      reviews: reviews ?? this.reviews,
    );
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      uid: json['uid'],
      userUid: json['userUid'],
      externalId: json['externalId'],
      subCategoryItemId: json['subCategoryItemId'],
      name: json['name'],
      description: json['description'],
      quantity: json['quantity'],
      status: json['status'],
      value: json['value'],
      postedAt: json['postedAt'],
      prices: json['prices'] != null
          ? (json['prices'] as List)
              .map((price) => ProductPriceModel.fromJson(price))
              .toList()
          : [],
      photos: json['photos'] != null
          ? (json['photos'] as List)
              .map((photo) => ProductPhotoModel.fromJson(photo))
              .toList()
          : [],
      shareLink: json['shareLink'],
      address: json['address'] != null
          ? AddressModel.fromJson(json['address'])
          : null,
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      subCategoryItem: json['subCategoryItem'] != null
          ? SubCategoryItemModel.fromJson(json['subCategoryItem'])
          : null,
      rating: json['rating'],
      unavailableBookingDates: json['unavailableBookingDates'] != null
          ? (json['unavailableBookingDates'] as List)
              .map((date) => BookingDateModel.fromJson(date))
              .toList()
          : [],
      reviews: json['reviews'] != null
          ? (json['reviews'] as List)
              .map((review) => ReviewModel.fromJson(review))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uid': uid,
      'userUid': userUid,
      'externalId': externalId,
      'subCategoryItemId': subCategoryItemId,
      'name': name,
      'description': description,
      'quantity': quantity,
      'status': status,
      'value': value,
      'postedAt': postedAt,
      'prices': prices?.map((price) => price.toJson()).toList(),
      'photos': photos?.map((photo) => photo.toJson()).toList(),
      'shareLink': shareLink,
      'address': address?.toJson(),
      'user': user?.toJson(),
      'subCategoryItem': subCategoryItem?.toJson(),
      'rating': rating,
      'unavailableBookingDates':
          unavailableBookingDates?.map((date) => date.toJson()).toList(),
      'reviews': reviews?.map((review) => review.toJson()).toList(),
    };
  }

  bool get hasPhotos => (photos ?? []).isNotEmpty;
  String get firstPhoto => hasPhotos ? (photos?.first.photoUrl ?? '') : '';

  bool get hasPrices => (prices ?? []).isNotEmpty;
  String get getFirstPrice =>
      (hasPrices ? (prices?[0].price ?? 0) : 0).toString().toCurrencyFormat;

  static String encode(List<ProductModel> objects) => json.encode(
        objects.map<Map<String, dynamic>>((obj) => obj.toJson()).toList(),
      );

  static List<ProductModel> decode(String objects) => objects.isEmpty
      ? []
      : (json.decode(objects) as List<dynamic>)
          .map<ProductModel>((obj) => ProductModel.fromJson(obj))
          .toList();
}

class ProductList {
  ProductList({required this.list});
  final List<ProductModel> list;

  factory ProductList.fromJson(List parsedJson) {
    final list = parsedJson.map((obj) => ProductModel.fromJson(obj)).toList();
    return ProductList(list: list);
  }
}
