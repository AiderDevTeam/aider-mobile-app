import 'package:freezed_annotation/freezed_annotation.dart';

import 'sub_category_model.dart';

part 'category_model.freezed.dart';
part 'category_model.g.dart';


@freezed
class CategoryModel with _$CategoryModel {
  const factory CategoryModel({
    final int? id,
    final String? externalId,
    final String? name,
    final String? imageUrl,
    final String? status,
    final List<SubCategoryModel>? subCategories,
  }) = _CategoryModel;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
}



class CategoryList {
  CategoryList({required this.list});
  final List<CategoryModel> list;

  factory CategoryList.fromJson(List parsedJson) {
    final list = parsedJson.map((obj) => CategoryModel.fromJson(obj) ).toList();
    return CategoryList(list: list);
  }

}