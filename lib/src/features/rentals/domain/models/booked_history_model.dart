import '../../../../../core/domain/models/pagination/pagination_model.dart';
import 'booking/booking_model.dart';

class BookedProductHistoryModel {
  final List<BookingModel> data;
  final PaginationModel? meta;

  BookedProductHistoryModel({
    this.data = const [],
    this.meta,
  });

  BookedProductHistoryModel copyWith({
    List<BookingModel>? data,
    PaginationModel? meta,
  }) {
    return BookedProductHistoryModel(
      data: data ?? this.data,
      meta: meta ?? this.meta,
    );
  }

  factory BookedProductHistoryModel.fromJson(Map<String, dynamic> json) {
    return BookedProductHistoryModel(
      data: json['data'] != null
          ? (json['data'] as List)
              .map((obj) => BookingModel.fromJson(obj))
              .toList()
          : [],
      meta:
          json['meta'] != null ? PaginationModel.fromJson(json['meta']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((obj) => obj.toJson()).toList(),
      'meta': meta?.toJson(),
    };
  }
}
