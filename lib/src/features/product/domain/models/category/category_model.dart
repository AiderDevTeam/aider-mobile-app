import 'sub_category_model.dart';

class CategoryModel {
  final int? id;
  final String? externalId;
  final String? name;
  final String? imageUrl;
  final String? status;
  final List<SubCategoryModel>? subCategories;

  CategoryModel({
    this.id,
    this.externalId,
    this.name,
    this.imageUrl,
    this.status,
    this.subCategories,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      externalId: json['externalId'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      status: json['status'],
      subCategories: json['subCategories'] != null
          ? (json['subCategories'] as List)
              .map((obj) => SubCategoryModel.fromJson(obj))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'externalId': externalId,
      'name': name,
      'imageUrl': imageUrl,
      'status': status,
      'subCategories': subCategories,
    };
  }
}

class CategoryList {
  CategoryList({required this.list});
  final List<CategoryModel> list;

  factory CategoryList.fromJson(List parsedJson) {
    final list = parsedJson.map((obj) => CategoryModel.fromJson(obj)).toList();
    return CategoryList(list: list);
  }
}
