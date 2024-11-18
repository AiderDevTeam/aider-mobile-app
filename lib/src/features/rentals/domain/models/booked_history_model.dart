
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/domain/models/pagination/pagination_model.dart';
import 'booking/booking_model.dart';

part 'booked_history_model.freezed.dart';
part 'booked_history_model.g.dart';


@freezed
class BookedProductHistoryModel with _$BookedProductHistoryModel {
  const factory BookedProductHistoryModel({
    @Default([]) final List<BookingModel> data,
    final PaginationModel? meta,
  }) = _BookedProductHistoryModel;

  factory BookedProductHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$BookedProductHistoryModelFromJson(json);
}
