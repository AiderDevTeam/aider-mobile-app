
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../core/domain/models/pagination/pagination_model.dart';
import '../product/product_model.dart';

part 'product_history_model.freezed.dart';
part 'product_history_model.g.dart';


@freezed
class ProductHistoryModel with _$ProductHistoryModel {
  const factory ProductHistoryModel({
    @Default([]) final List<ProductModel> data,
    final PaginationModel? meta,
  }) = _ProductHistoryModel;

  factory ProductHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$ProductHistoryModelFromJson(json);
}
