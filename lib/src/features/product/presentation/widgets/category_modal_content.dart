import 'dart:async';

import 'package:aider_mobile_app/core/constants/colors.dart';
import 'package:aider_mobile_app/core/constants/common.dart';
import 'package:aider_mobile_app/core/extensions/widgets/gesture_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/core/routing/app_navigator.dart';
import 'package:aider_mobile_app/core/utils/app_theme_util.dart';
import 'package:aider_mobile_app/src/features/product/presentation/view_models/product_view_model.dart';
import 'package:aider_mobile_app/src/shared_widgets/forms/app_input_field.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/screen_empty_state.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/svg_icon.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/v_space.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/providers/base_view.dart';

class CategoryModalContent extends StatefulWidget {
  const CategoryModalContent({
    super.key,
    required this.pageController,
    required this.scrollController,
  });

  final PageController pageController;
  final ScrollController scrollController;

  @override
  State<CategoryModalContent> createState() => _CategoryModalContentState();
}

class _CategoryModalContentState extends State<CategoryModalContent> {
  final searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductViewModel>().fetchPopularCategories();
    });
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: widget.scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const VSpace(height: 20.0),
            AppInputField(
              hintText: 'Search categories',
              controller: searchController,
              helperHeight: 0.1,
              filled: true,
              customBorderColor: kGrey50,
              onChanged: _onSearchChanged,
              roundedBorderSize: 100,
              enableSuggestions: false,
              textInputAction: TextInputAction.search,
              prefixIcon: CircleAvatar(
                maxRadius: 14,
                backgroundColor: Colors.transparent,
                child: ZSvgIcon(
                  'search.svg',
                  color: kGrey500,
                  size: AppThemeUtil.radius(20),
                ),
              ).paddingOnly(
                top: 16.0,
                bottom: 16.0,
                left: 20,
              ),
            ).paddingSymmetric(horizontal: kWidthPadding),
            const Divider(color: kGrey200),
            const VSpace(height: 15.0),
            const Text('POPULAR CATEGORIES')
                .bold()
                .color(kGrey700)
                .fontSize(12.0)
                .paddingSymmetric(horizontal: kWidthPadding),
            const VSpace(height: 20.0),
            BaseView<ProductViewModel>(
                builder: (context, productConsumer, child) {
              if (productConsumer.getSubCategoryItems.isEmpty) {
                return const ScreenEmptyState(
                  title: 'Categories',
                  subtitle: 'No popular categories to display',
                );
              }
              return Wrap(
                spacing: AppThemeUtil.width(8.0),
                runSpacing: AppThemeUtil.height(12.0),
                children: List.generate(
                    productConsumer.getSubCategoryItems.length, (index) {
                  final item = productConsumer.getSubCategoryItems[index];
                  return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppThemeUtil.width(16),
                      vertical: AppThemeUtil.height(8),
                    ),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: AppThemeUtil.getThemeColor(kGrey50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: Text(
                      '${item.name}',
                    )
                        .medium()
                        .fontSize(14)
                        .height(20, 14)
                        .letterSpacing(-0.15)
                        .alignText(TextAlign.center)
                        .color(kGrey1200),
                  ).onPressed(() {
                    AppNavigator.pop(context, item);
                  });
                }),
              ).paddingSymmetric(horizontal: kWidthPadding);
            }),
          ],
        ),
      ),
    );
  }

  _onSearchChanged(String? query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<ProductViewModel>().emitPopularCategories(query);
      context.read<ProductViewModel>().fetchPopularCategories();
    });
  }
}
