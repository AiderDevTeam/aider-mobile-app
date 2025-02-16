import 'dart:convert';
import 'package:aider_mobile_app/core/auth/domain/models/user/user_model.dart';
import 'package:aider_mobile_app/core/extensions/string_extension.dart';

import '../booked_product/booked_product_model.dart';

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

class BookingModel {
  final int? id;
  final String? uid;
  final String? externalId;
  final BookingStatus? status;
  final num? collectionAmount;
  final BookingProgressStatus? collectionStatus;
  final num? disbursementAmount;
  final BookingProgressStatus? disbursementStatus;
  final BookingProgressStatus? reversalStatus;
  final BookingProgressStatus? bookingAcceptanceStatus;
  final BookingProgressStatus? vendorPickupStatus;
  final BookingProgressStatus? userPickupStatus;
  final BookingProgressStatus? vendorDropOffStatus;
  final BookingProgressStatus? userDropOffStatus;
  final String? bookingNumber;
  final String? productUid;
  final String? userUid;
  final String? vendorUid;
  final BookedProductModel? bookedProduct;
  final bool userHasReported;
  final bool vendorHasReported;
  final UserModel? vendor;
  final UserModel? user;
  final DateTime? createdAt;

  BookingModel({
    this.id,
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
    this.createdAt,
  });

  BookingModel copyWith({
    int? id,
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
    bool? userHasReported,
    bool? vendorHasReported,
    UserModel? vendor,
    UserModel? user,
    DateTime? createdAt,
    bool? hasUnreadMessages,
  }) {
    return BookingModel(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      externalId: externalId ?? this.externalId,
      status: status ?? this.status,
      collectionAmount: collectionAmount ?? this.collectionAmount,
      collectionStatus: collectionStatus ?? this.collectionStatus,
      disbursementAmount: disbursementAmount ?? this.disbursementAmount,
      disbursementStatus: disbursementStatus ?? this.disbursementStatus,
      reversalStatus: reversalStatus ?? this.reversalStatus,
      bookingAcceptanceStatus:
          bookingAcceptanceStatus ?? this.bookingAcceptanceStatus,
      vendorPickupStatus: vendorPickupStatus ?? this.vendorPickupStatus,
      userPickupStatus: userPickupStatus ?? this.userPickupStatus,
      vendorDropOffStatus: vendorDropOffStatus ?? this.vendorDropOffStatus,
      userDropOffStatus: userDropOffStatus ?? this.userDropOffStatus,
      bookingNumber: bookingNumber ?? this.bookingNumber,
      productUid: productUid ?? this.productUid,
      userUid: userUid ?? this.userUid,
      vendorUid: vendorUid ?? this.vendorUid,
      bookedProduct: bookedProduct ?? this.bookedProduct,
      userHasReported: userHasReported ?? this.userHasReported,
      vendorHasReported: vendorHasReported ?? this.vendorHasReported,
      vendor: vendor ?? this.vendor,
      user: user ?? this.user,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uid': uid,
      'externalId': externalId,
      'status': status?.name,
      'collectionAmount': collectionAmount,
      'collectionStatus': collectionStatus?.name,
      'disbursementAmount': disbursementAmount,
      'disbursementStatus': disbursementStatus?.name,
      'reversalStatus': reversalStatus?.name,
      'bookingAcceptanceStatus': bookingAcceptanceStatus?.name,
      'vendorPickupStatus': vendorPickupStatus?.name,
      'userPickupStatus': userPickupStatus?.name,
      'vendorDropOffStatus': vendorDropOffStatus?.name,
      'userDropOffStatus': userDropOffStatus?.name,
      'bookingNumber': bookingNumber,
      'productUid': productUid,
      'userUid': userUid,
      'vendorUid': vendorUid,
      'bookedProduct': bookedProduct?.toJson(),
      'userHasReported': userHasReported,
      'vendorHasReported': vendorHasReported,
      'vendor': vendor?.toJson(),
      'user': user?.toJson(),
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'],
      uid: json['uid'],
      externalId: json['externalId'],
      status: BookingStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => BookingStatus.awaitingAcceptance,
      ),
      collectionAmount: json['collectionAmount'],
      collectionStatus: BookingProgressStatus.values.firstWhere(
        (e) => e.name == json['collectionStatus'],
        orElse: () => BookingProgressStatus.notStarted,
      ),
      disbursementAmount: json['disbursementAmount'],
      disbursementStatus: BookingProgressStatus.values.firstWhere(
        (e) => e.name == json['disbursementStatus'],
        orElse: () => BookingProgressStatus.notStarted,
      ),
      reversalStatus: BookingProgressStatus.values.firstWhere(
        (e) => e.name == json['reversalStatus'],
        orElse: () => BookingProgressStatus.notStarted,
      ),
      bookingAcceptanceStatus: BookingProgressStatus.values.firstWhere(
        (e) => e.name == json['bookingAcceptanceStatus'],
        orElse: () => BookingProgressStatus.notStarted,
      ),
      vendorPickupStatus: BookingProgressStatus.values.firstWhere(
        (e) => e.name == json['vendorPickupStatus'],
        orElse: () => BookingProgressStatus.notStarted,
      ),
      userPickupStatus: BookingProgressStatus.values.firstWhere(
        (e) => e.name == json['userPickupStatus'],
        orElse: () => BookingProgressStatus.notStarted,
      ),
      vendorDropOffStatus: BookingProgressStatus.values.firstWhere(
        (e) => e.name == json['vendorDropOffStatus'],
        orElse: () => BookingProgressStatus.notStarted,
      ),
      userDropOffStatus: BookingProgressStatus.values.firstWhere(
        (e) => e.name == json['userDropOffStatus'],
        orElse: () => BookingProgressStatus.notStarted,
      ),
      bookingNumber: json['bookingNumber'],
      productUid: json['productUid'],
      userUid: json['userUid'],
      vendorUid: json['vendorUid'],
      bookedProduct: json['bookedProduct'] != null
          ? BookedProductModel.fromJson(json['bookedProduct'])
          : null,
      userHasReported: json['userHasReported'],
      vendorHasReported: json['vendorHasReported'],
      vendor:
          json['vendor'] != null ? UserModel.fromJson(json['vendor']) : null,
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  String get getTotalCost =>
      (collectionAmount ?? 0).toString().toCurrencyFormat;
  bool get hasUserPickupStatus =>
      userPickupStatus == BookingProgressStatus.success;

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
    bookingJson['bookedProduct'] = bookedProduct?.toJson();
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

  BookingList copyWith({
    List<BookingModel>? list,
  }) {
    return BookingList(list: list ?? this.list);
  }
}
