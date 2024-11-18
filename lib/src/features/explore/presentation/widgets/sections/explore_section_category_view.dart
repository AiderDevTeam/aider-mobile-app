import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/utils/app_theme_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../product/domain/models/category/category_model.dart';
import '../category_item_card.dart';

class ExploreSectionCategoryView extends StatelessWidget {
  const ExploreSectionCategoryView({super.key, required this.categories});

  final List categories;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppThemeUtil.height(110),
      child: ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index){
          final categoryJson = categories[index];
          final category = CategoryModel.fromJson(categoryJson ?? {});
          return CategoryItemCard(
            category: category,
          ).paddingOnly(right: AppThemeUtil.radius(10));
        }
      ),
    );
  }
}
