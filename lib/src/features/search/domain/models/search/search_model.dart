import 'package:aider_mobile_app/core/auth/domain/models/user/user_model.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../product/domain/models/product/product_model.dart';

part 'search_model.freezed.dart';

part 'search_model.g.dart';

@freezed
class SearchModel with _$SearchModel {

  const factory SearchModel({
    final List<UserModel>? users,
    final List<ProductModel>? products,
    final int? vendorCount,
    final int? productCount,

  }) = _SearchModel;

  factory SearchModel.fromJson(Map<String, dynamic> json) => _$SearchModelFromJson(json);
}

