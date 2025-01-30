import 'dart:convert';

import 'package:aider_mobile_app/core/domain/models/address/address_model.dart';
import 'package:aider_mobile_app/core/auth/domain/models/user/user_model.dart';
import 'package:aider_mobile_app/core/extensions/string_extension.dart';
import 'package:aider_mobile_app/src/features/review/domain/review/review_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../booking/booking_date_model.dart';
import '../category/sub_category_item_model.dart';
import '../product_photo/product_photo_model.dart';
import '../product_price/product_price_model.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
class ProductModel with _$ProductModel {
  const ProductModel._();
  const factory ProductModel({
    final int? id,
    final String? uid,
    final String? userId,
    final String? externalId,
    final String? subCategoryItemId,
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
    final List<ReviewModel>? reviews,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

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
