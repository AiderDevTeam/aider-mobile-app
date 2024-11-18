import 'package:freezed_annotation/freezed_annotation.dart';
import 'sub_category_model.dart';

part 'sub_category_item_model.freezed.dart';
part 'sub_category_item_model.g.dart';


@freezed
class SubCategoryItemModel with _$SubCategoryItemModel {
  const factory SubCategoryItemModel({
    final int? id,
    final String? externalId,
    final String? name,
    final SubCategoryModel? subCategory,
  }) = _SubCategoryItemModel;

  factory SubCategoryItemModel.fromJson(Map<String, dynamic> json) =>
      _$SubCategoryItemModelFromJson(json);
}




class SubCategoryItemList {
  SubCategoryItemList({required this.list});
  final List<SubCategoryItemModel> list;

  factory SubCategoryItemList.fromJson(List parsedJson) {
    final list = parsedJson.map((obj) => SubCategoryItemModel.fromJson(obj) ).toList();
    return SubCategoryItemList(list: list);
  }

}