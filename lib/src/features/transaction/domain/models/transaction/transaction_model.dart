import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../core/utils/model_converter_util.dart';

part 'transaction_model.freezed.dart';
part 'transaction_model.g.dart';


@freezed
class TransactionModel with _$TransactionModel {
  const factory TransactionModel({
    final int? id,
    final String? externalId,
    @NumToStringConverter() final String? amount,
    final String? accountNumber,
    final String? sortCode,
    final String? type,
    final String? status,
    final String? stan,
  }) = _TransactionModel;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);
}
