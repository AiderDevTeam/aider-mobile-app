import 'package:aider_mobile_app/core/constants/colors.dart';
import 'package:aider_mobile_app/core/constants/common.dart';
import 'package:aider_mobile_app/core/extensions/widgets/align_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/expanded_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/gesture_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/core/utils/app_theme_util.dart';
import 'package:aider_mobile_app/core/view_models/base_view.dart';
import 'package:aider_mobile_app/src/features/product/presentation/view_models/product_view_model.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/svg_icon.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/v_space.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllCategoryModalContent extends StatefulWidget {
  const AllCategoryModalContent({super.key, required this.pageController,});

  final PageController pageController;

  @override
  State<AllCategoryModalContent> createState() => _AllCategoryModalContentState();
}

class _AllCategoryModalContentState extends State<AllCategoryModalContent> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductViewModel>().fetchCategories();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const VSpace(height: 20.0),
        const Text('ALL CATEGORIES').bold().color(kGrey700).fontSize(12.0).alignCenterLeft(),
        const VSpace(height: 20.0),
        BaseView<ProductViewModel>(
          builder: (context, productConsumer, child) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: productConsumer.getCategories.length,
              itemBuilder: (context, index){
                final category = productConsumer.getCategories[index];
                return Container(
                  padding: EdgeInsets.symmetric(vertical: AppThemeUtil.height(20.0)),
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: kGrey100))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(category.name?? '').medium().fontSize(14).color(kGrey1200).height(20, 14).letterSpacing(-0.15),
                      ZSvgIcon(
                        'caret_right.svg',
                        size: AppThemeUtil.radius(16),
                        color: kGrey600,
                      )
                    ],
                  ),
                ).onPressed((){
                  context.read<ProductViewModel>().setModalWithCategory(category);
                  widget.pageController.animateToPage(
                    2,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.ease,
                  );
                });
              },
            );
          }
        ).expanded(),
      ],
    ).paddingSymmetric(horizontal: kWidthPadding);
  }
}
