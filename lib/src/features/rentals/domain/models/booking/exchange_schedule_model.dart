import 'package:freezed_annotation/freezed_annotation.dart';

part 'exchange_schedule_model.freezed.dart';
part 'exchange_schedule_model.g.dart';

@freezed
class ExchangeScheduleModel with _$ExchangeScheduleModel {
  const ExchangeScheduleModel._();
  const factory ExchangeScheduleModel({
    final String? externalId,
    final String? city,
    final String? status,
    final String? country,
    final String? countryCode,
    final String? originName,
    final String? timeOfExchange,
  }) = _ExchangeScheduleModel;

  factory ExchangeScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$ExchangeScheduleModelFromJson(json);
}
