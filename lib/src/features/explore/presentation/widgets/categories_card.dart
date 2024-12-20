import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/src/features/explore/presentation/widgets/suggestion_tag.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/common.dart';
import '../../../../../core/utils/app_theme_util.dart';

class CategoriesCard extends StatelessWidget {
  const CategoriesCard({super.key, required this.subCategories});

  final List subCategories;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppThemeUtil.height(36),
      child: ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: 10,
          // subCategories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: ((context, index){
            // final subCategoriesJson = subCategories[index];
            // final subCategory = SubCategoryModel.fromJson(subCategoriesJson ?? {});
            return SuggestionTag(
              text: 'Drones',
              height: AppThemeUtil.height(36),
              semiBold: true,
              onTap: (){
                // AppNavigatorUtil.pushNamed(context, AppRoute.subCategoryProductsScreen, arguments: subCategory);
              },
            ).paddingOnly(right: index == subCategories.length-1? kWidthPadding: 12.0, left: index == 0? kWidthPadding:0);
          })
      ),
    );
  }
}
