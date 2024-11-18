import 'package:aider_mobile_app/core/extensions/widgets/center_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/gesture_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/routing/app_navigator.dart';
import '../../../../../core/routing/app_route.dart';
import '../../../../../core/utils/app_theme_util.dart';
import '../../../../shared_widgets/common/network_image_view.dart';
import '../../../product/domain/models/category/category_model.dart';

class CategoryItemCard extends StatelessWidget {
  const CategoryItemCard({super.key, required this.category});
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: kGrey200,
          ),
          // color: kGrey200,
          borderRadius: BorderRadius.all(Radius.circular(AppThemeUtil.radius(12.0,)))
      ),
      child: Stack(
        children: [
          NetworkImageView(
            imageUrl: category.imageUrl?? '',
            width: AppThemeUtil.width(116),
            height: AppThemeUtil.height(110),
            radius: 12.0,
            borderRadius: BorderRadius.circular(12),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: AppThemeUtil.height(44),
              width: AppThemeUtil.width(116),
              padding: EdgeInsets.symmetric(horizontal: AppThemeUtil.width(12), vertical: AppThemeUtil.height(5)),
              decoration: BoxDecoration(
                  color: kPrimaryWhite.withOpacity(0.94),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(AppThemeUtil.radius(12.0,)),
                    bottomRight: Radius.circular(AppThemeUtil.radius(12.0,)),
                  )
              ),
              child: Text(category.name?? '', maxLines: 2,)
                  .medium()
                  .fontSize(12)
                  .color(kPrimaryBlack).wrapAround(true).overflowText(TextOverflow.ellipsis)
                  .toCenter(),
            ),
          ),
        ],
      ).onPressed((){
        AppNavigator.pushNamed(context, AppRoute.seeAllRentalListeningScreen, arguments: {
          'type': 'category',
          'externalId': category.externalId ?? '',
          'title': category.name,
        });
      }),
    );
  }
}
