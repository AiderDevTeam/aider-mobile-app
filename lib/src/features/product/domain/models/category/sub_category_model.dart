import 'category_model.dart';
import 'sub_category_item_model.dart';

class SubCategoryModel {
  final int? id;
  final String? externalId;
  final String? name;
  final CategoryModel? category;
  final List<SubCategoryItemModel>? subCategoryItems;

  SubCategoryModel({
    this.id,
    this.externalId,
    this.name,
    this.category,
    this.subCategoryItems,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
      id: json['id'],
      externalId: json['externalId'],
      name: json['name'],
      category: json['category'] != null
          ? CategoryModel.fromJson(json['category'])
          : null,
      subCategoryItems: json['subCategoryItems'] != null
          ? (json['subCategoryItems'] as List)
              .map((obj) => SubCategoryItemModel.fromJson(obj))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'external_id': externalId,
      'name': name,
      'category': category?.toJson(),
      'sub_category_items':
          subCategoryItems?.map((obj) => obj.toJson()).toList(),
    };
  }
}
