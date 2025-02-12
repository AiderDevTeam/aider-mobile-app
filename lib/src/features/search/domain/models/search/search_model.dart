import 'package:aider_mobile_app/core/auth/domain/models/user/user_model.dart';

import '../../../../product/domain/models/product/product_model.dart';

class SearchModel {
  final List<UserModel>? users;
  final List<ProductModel>? products;
  final int? vendorCount;
  final int? productCount;

  const SearchModel({
    this.users,
    this.products,
    this.vendorCount,
    this.productCount,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      users: (json['users'] as List).map((i) => UserModel.fromJson(i)).toList(),
      products: (json['products'] as List)
          .map((i) => ProductModel.fromJson(i))
          .toList(),
      vendorCount: json['vendorCount'],
      productCount: json['productCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'users': users?.map((i) => i.toJson()).toList(),
      'products': products?.map((i) => i.toJson()).toList(),
      'vendorCount': vendorCount,
      'productCount': productCount,
    };
  }
}
