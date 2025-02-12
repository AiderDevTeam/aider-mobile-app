import '../../../../../../core/domain/models/pagination/pagination_model.dart';
import '../product/product_model.dart';

class ProductHistoryModel {
  final List<ProductModel> data;
  final PaginationModel? meta;

  ProductHistoryModel({
    this.data = const [],
    this.meta,
  });

  factory ProductHistoryModel.fromJson(Map<String, dynamic> json) {
    return ProductHistoryModel(
      data: json['data'] != null
          ? (json['data'] as List)
              .map((obj) => ProductModel.fromJson(obj))
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

  ProductHistoryModel copyWith({
    List<ProductModel>? data,
    PaginationModel? meta,
  }) {
    return ProductHistoryModel(
      data: data ?? this.data,
      meta: meta ?? this.meta,
    );
  }
}
