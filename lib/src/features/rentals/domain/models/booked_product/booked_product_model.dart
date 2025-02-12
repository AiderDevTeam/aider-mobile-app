import 'package:aider_mobile_app/core/extensions/date_extension.dart';
import 'package:aider_mobile_app/core/extensions/string_extension.dart';
import 'package:aider_mobile_app/src/features/product/domain/models/product/product_model.dart';

import '../../../../review/domain/review/review_model.dart';
import '../booking/exchange_schedule_model.dart';

class BookedProductModel {
  final int? id;
  final String? externalId;
  final num? amount;
  final int? quantity;
  final num? value;
  final String? startDate;
  final String? endDate;
  final int? duration;
  final bool? returnedEarly;
  final ProductModel? product;
  final bool? isReviewed;
  final ReviewModel? review;
  final ReviewModel? renterReview;
  final ExchangeScheduleModel? exchangeSchedule;

  BookedProductModel({
    this.id,
    this.externalId,
    this.amount,
    this.quantity,
    this.value,
    this.startDate,
    this.endDate,
    this.duration,
    this.returnedEarly,
    this.product,
    this.isReviewed,
    this.review,
    this.renterReview,
    this.exchangeSchedule,
  });

  BookedProductModel copyWith({
    int? id,
    String? externalId,
    num? amount,
    int? quantity,
    num? value,
    String? startDate,
    String? endDate,
    int? duration,
    bool? returnedEarly,
    ProductModel? product,
    bool? isReviewed,
    ReviewModel? review,
    ReviewModel? renterReview,
    ExchangeScheduleModel? exchangeSchedule,
  }) {
    return BookedProductModel(
      id: id ?? this.id,
      externalId: externalId ?? this.externalId,
      amount: amount ?? this.amount,
      quantity: quantity ?? this.quantity,
      value: value ?? this.value,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      duration: duration ?? this.duration,
      returnedEarly: returnedEarly ?? this.returnedEarly,
      product: product ?? this.product,
      isReviewed: isReviewed ?? this.isReviewed,
      review: review ?? this.review,
      renterReview: renterReview ?? this.renterReview,
      exchangeSchedule: exchangeSchedule ?? this.exchangeSchedule,
    );
  }

  String get getDuration =>
      duration == 1 ? '$duration Day' : '${duration ?? 0} Days';

  bool get isOverdue => DateTime.now().isAfter(DateTime.parse(endDate ?? ''));

  int get daysSpan => DateTime.parse(endDate ?? '')
      .difference(DateTime.parse(startDate ?? ''))
      .inDays;

  String get getStartDate => DateTime.parse(startDate ?? '').format('MMM dd');
  String get getEndDate => DateTime.parse(endDate ?? '').format('MMM dd');
  String get getTotalCost => (amount ?? 0).toString().toCurrencyFormat;

  factory BookedProductModel.fromJson(Map<String, dynamic> json) {
    return BookedProductModel(
      id: json['id'],
      externalId: json['externalId'],
      amount: json['amount'],
      quantity: json['quantity'],
      value: json['value'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      duration: json['duration'],
      returnedEarly: json['returned_early'] ?? false,
      product: json['product'] != null
          ? ProductModel.fromJson(json['product'])
          : null,
      isReviewed: json['isReviewed'],
      review:
          json['review'] != null ? ReviewModel.fromJson(json['review']) : null,
      renterReview: json['renterReview'] != null
          ? ReviewModel.fromJson(json['renterReview'])
          : null,
      exchangeSchedule: json['exchangeSchedule'] != null
          ? ExchangeScheduleModel.fromJson(json['exchangeSchedule'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final bookedProductJson = {
      'id': id,
      'external_id': externalId,
      'amount': amount,
      'quantity': quantity,
      'value': value,
      'startDate': startDate,
      'endDate': endDate,
      'duration': duration,
      'returnedEarly': returnedEarly,
      'product': product?.toJson(),
      'isReviewed': isReviewed,
      'review': review?.toJson(),
      'renterReview': renterReview?.toJson(),
      'exchangeSchedule': exchangeSchedule?.toJson(),
    };
    return bookedProductJson;
  }
}
