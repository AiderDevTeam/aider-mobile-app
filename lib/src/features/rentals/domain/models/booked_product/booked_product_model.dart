import 'package:aider_mobile_app/core/extensions/date_extension.dart';
import 'package:aider_mobile_app/core/extensions/string_extension.dart';
import 'package:aider_mobile_app/src/features/product/domain/models/product/product_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../review/domain/review/review_model.dart';
import '../booking/exchange_schedule_model.dart';

part 'booked_product_model.freezed.dart';
part 'booked_product_model.g.dart';

@freezed
class BookedProductModel with _$BookedProductModel {
  const BookedProductModel._();
  const factory BookedProductModel({
    final int? id,
    final String? externalId,
    final num? amount,
    final int? quantity,
    final num? value,
    final String? startDate,
    final String? endDate,
    final int? duration,
    final bool? returnedEarly,
    final ProductModel? product,
    final bool? isReviewed,
    final ReviewModel? review,
    final ReviewModel? renterReview,
    final ExchangeScheduleModel? exchangeSchedule,
  }) = _BookedProductModel;

  String get getDuration =>
      duration == 1 ? '$duration Day' : '${duration ?? 0} Days';

  bool get isOverdue => DateTime.now().isAfter(DateTime.parse(endDate ?? ''));

  int get daysSpan => DateTime.parse(endDate ?? '')
      .difference(DateTime.parse(startDate ?? ''))
      .inDays;

  String get getStartDate => DateTime.parse(startDate ?? '').format('MMM dd');
  String get getEndDate => DateTime.parse(endDate ?? '').format('MMM dd');
  String get getTotalCost => (amount ?? 0).toString().toCurrencyFormat;

  factory BookedProductModel.fromJson(Map<String, dynamic> json) =>
      _$BookedProductModelFromJson(json);

  Map<String, dynamic> customToJson() {
    final bookedProductJson = toJson();
    bookedProductJson['product'] = product?.customToJson();
    bookedProductJson['review'] = review?.toJson();
    bookedProductJson['renterReview'] = renterReview?.toJson();
    bookedProductJson['exchangeSchedule'] = exchangeSchedule?.toJson();
    return bookedProductJson;
  }
}
