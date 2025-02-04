import 'dart:convert';
import 'package:aider_mobile_app/core/auth/domain/models/user/user_model.dart';
import 'package:aider_mobile_app/core/extensions/string_extension.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../booked_product/booked_product_model.dart';

part 'booking_model.freezed.dart';
part 'booking_model.g.dart';

enum BookingProgressStatus {
  notStarted,
  pending,
  accepted,
  rejected,
  cancelled,
  abandoned,
  failed,
  success
}

enum BookingStatus {
  awaitingAcceptance,
  awaitingCollection,
  awaitingDropOff,
  awaitingPickup,
  awaitingReturn,
  completed,
  cancelled,
}

@freezed
class BookingModel with _$BookingModel {
  const BookingModel._();
  const factory BookingModel({
    final int? id,
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
    @Default(false) final bool userHasReported,
    @Default(false) final bool vendorHasReported,
    final UserModel? vendor,
    final UserModel? user,
    final DateTime? createdAt,
  }) = _BookingModel;

  String get getTotalCost =>
      (collectionAmount ?? 0).toString().toCurrencyFormat;
  bool get hasUserPickupStatus =>
      userPickupStatus == BookingProgressStatus.success;

  factory BookingModel.fromJson(Map<String, dynamic> json) =>
      _$BookingModelFromJson(json);

  static String encode(List<BookingModel> objects) => json.encode(
        objects.map<Map<String, dynamic>>((obj) => obj.toJson()).toList(),
      );

  static List<BookingModel> decode(String objects) => objects.isEmpty
      ? []
      : (json.decode(objects) as List<dynamic>)
          .map<BookingModel>((obj) => BookingModel.fromJson(obj))
          .toList();

  Map<String, dynamic> customToJson() {
    final bookingJson = toJson();
    bookingJson['bookingAcceptanceStatus'] = BookingProgressStatus.pending.name;
    bookingJson['status'] = BookingStatus.awaitingAcceptance.name;
    bookingJson['collectionStatus'] = BookingProgressStatus.notStarted.name;
    bookingJson['disbursementStatus'] = BookingProgressStatus.notStarted.name;
    bookingJson['reversalStatus'] = BookingProgressStatus.notStarted.name;
    bookingJson['vendorPickupStatus'] = BookingProgressStatus.notStarted.name;
    bookingJson['userPickupStatus'] = BookingProgressStatus.notStarted.name;
    bookingJson['vendorDropOffStatus'] = BookingProgressStatus.notStarted.name;
    bookingJson['userDropOffStatus'] = BookingProgressStatus.notStarted.name;
    bookingJson['bookedProduct'] = bookedProduct?.customToJson();
    return bookingJson;
  }
}

class BookingList {
  BookingList({required this.list});
  final List<BookingModel> list;

  factory BookingList.fromJson(List parsedJson) {
    final list = parsedJson.map((obj) => BookingModel.fromJson(obj)).toList();
    return BookingList(list: list);
  }
}
