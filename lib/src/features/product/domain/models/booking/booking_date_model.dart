
import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_date_model.freezed.dart';
part 'booking_date_model.g.dart';


@freezed
class BookingDateModel with _$BookingDateModel {
  const factory BookingDateModel({
    final int? id,
    final String? date,
  }) = _BookingDateModel;

  factory BookingDateModel.fromJson(Map<String, dynamic> json) =>
      _$BookingDateModelFromJson(json);
}
