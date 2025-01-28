import 'package:aider_mobile_app/core/constants/colors.dart';
import 'package:aider_mobile_app/core/constants/common.dart';
import 'package:aider_mobile_app/core/extensions/widgets/align_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/expanded_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/gesture_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/core/routing/app_navigator.dart';
import 'package:aider_mobile_app/core/utils/app_theme_util.dart';
import 'package:aider_mobile_app/core/providers/base_view.dart';
import 'package:aider_mobile_app/src/features/product/presentation/view_models/product_view_model.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/app_expandable.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/v_space.dart';
import 'package:flutter/material.dart';

class SubCategoryModalContent extends StatefulWidget {
  const SubCategoryModalContent({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  State<SubCategoryModalContent> createState() =>
      _SubCategoryModalContentState();
}

class _SubCategoryModalContentState extends State<SubCategoryModalContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const VSpace(height: 20.0),
        const Text('SUB CATEGORIES')
            .bold()
            .color(kGrey700)
            .fontSize(12.0)
            .alignCenterLeft(),
        const VSpace(height: 20.0),
        BaseView<ProductViewModel>(builder: (context, productConsumer, child) {
          final subCategories =
              productConsumer.getSelectedCategory.subCategories ?? [];
          return ListView.builder(
            shrinkWrap: true,
            itemCount: subCategories.length,
            itemBuilder: (context, index) {
              final subCategory = subCategories[index];
              final items = subCategory.subCategoryItems ?? [];
              return AppExpandable(
                header: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: AppThemeUtil.height(20.0)),
                  decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: kGrey100))),
                  child: Text(subCategory.name ?? '')
                      .color(kGrey1200)
                      .medium()
                      .fontSize(14)
                      .height(20, 14)
                      .letterSpacing(-0.15),
                ),
                collapsed: const SizedBox.shrink(),
                expanded: ColoredBox(
                  color: kGrey50,
                  child: ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(
                          vertical: AppThemeUtil.height(20.0),
                        ),
                        margin: index == (items.length - 1)
                            ? null
                            : EdgeInsets.symmetric(
                                horizontal: AppThemeUtil.width(16.0),
                              ),
                        decoration: const BoxDecoration(
                            color: kGrey50,
                            border:
                                Border(bottom: BorderSide(color: kGrey200))),
                        child: Text(item.name ?? '')
                            .color(kGrey1200)
                            .medium()
                            .fontSize(14)
                            .height(20, 14)
                            .letterSpacing(-0.15)
                            .paddingSymmetric(
                                horizontal:
                                    index == (items.length - 1) ? 16.0 : 0),
                      ).onPressed(() {
                        AppNavigator.pop(context, item);
                      });
                    },
                  ),
                ),
              );
            },
          );
        }).expanded(),
      ],
    ).paddingSymmetric(horizontal: kWidthPadding);
  }
}
