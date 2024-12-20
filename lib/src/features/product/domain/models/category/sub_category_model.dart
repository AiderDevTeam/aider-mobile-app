import 'package:freezed_annotation/freezed_annotation.dart';

import 'category_model.dart';
import 'sub_category_item_model.dart';

part 'sub_category_model.freezed.dart';
part 'sub_category_model.g.dart';


@freezed
class SubCategoryModel with _$SubCategoryModel {
  const factory SubCategoryModel({
    final int? id,
    final String? externalId,
    final String? name,
    final CategoryModel? category,
    final List<SubCategoryItemModel>? subCategoryItems,
  }) = _SubCategoryModel;

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$SubCategoryModelFromJson(json);
}
