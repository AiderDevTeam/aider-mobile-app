import 'dart:convert';
import 'package:aider_mobile_app/core/auth/domain/models/user/user_model.dart';
import 'package:aider_mobile_app/core/constants/common.dart';
import 'package:aider_mobile_app/core/extensions/string_extension.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../booked_product/booked_product_model.dart';

part 'booking_model.freezed.dart';
part 'booking_model.g.dart';

@freezed
class BookingModel with _$BookingModel {
  const BookingModel._();
  const factory BookingModel({
    final int? id,
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
    @Default(false) final bool userHasReported,
    @Default(false) final bool vendorHasReported,
    final UserModel? vendor,
    final UserModel? user,
  }) = _BookingModel;

  String get getTotalCost => (collectionAmount ?? 0).toString().toCurrencyFormat;
  bool get hasUserPickupStatus => userPickupStatus == kSuccessStatus;

  factory BookingModel.fromJson(Map<String, dynamic> json) => _$BookingModelFromJson(json);

  static String encode(List<BookingModel> objects) => json.encode(
        objects.map<Map<String, dynamic>>((obj) => obj.toJson()).toList(),
      );

  static List<BookingModel> decode(String objects) =>
      objects.isEmpty ? [] : (json.decode(objects) as List<dynamic>).map<BookingModel>((obj) => BookingModel.fromJson(obj)).toList();
}

class BookingList {
  BookingList({required this.list});
  final List<BookingModel> list;

  factory BookingList.fromJson(List parsedJson) {
    final list = parsedJson.map((obj) => BookingModel.fromJson(obj)).toList();
    return BookingList(list: list);
  }
}
