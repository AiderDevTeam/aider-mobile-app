import 'sub_category_model.dart';

class SubCategoryItemModel {
  final int? id;
  final String? externalId;
  final String? name;
  final SubCategoryModel? subCategory;

  SubCategoryItemModel({
    this.id,
    this.externalId,
    this.name,
    this.subCategory,
  });

  factory SubCategoryItemModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryItemModel(
      id: json['id'],
      externalId: json['externalId'],
      name: json['name'],
      subCategory: json['subCategory'] != null
          ? SubCategoryModel.fromJson(json['subCategory'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'externalId': externalId,
      'name': name,
      'subCategory': subCategory?.toJson(),
    };
  }
}

class SubCategoryItemList {
  SubCategoryItemList({required this.list});
  final List<SubCategoryItemModel> list;

  factory SubCategoryItemList.fromJson(List parsedJson) {
    final list =
        parsedJson.map((obj) => SubCategoryItemModel.fromJson(obj)).toList();
    return SubCategoryItemList(list: list);
  }
}
