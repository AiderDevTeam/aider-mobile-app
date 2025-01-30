import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_price_model.freezed.dart';
part 'product_price_model.g.dart';

@freezed
class ProductPriceModel with _$ProductPriceModel {
  const factory ProductPriceModel({
    final int? id,
    final String? externalId,
    final num? price,
    final int? startDay,
    final int? endDay,
  }) = _ProductPriceModel;

  factory ProductPriceModel.fromJson(Map<String, dynamic> json) =>
      _$ProductPriceModelFromJson(json);
}
