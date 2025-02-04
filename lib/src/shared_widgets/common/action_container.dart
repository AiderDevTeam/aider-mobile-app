import 'package:aider_mobile_app/core/constants/colors.dart';
import 'package:aider_mobile_app/core/extensions/widgets/gesture_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/utils/app_theme_util.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/routing/app_navigator.dart';
import '../../../core/routing/app_route.dart';
import '../../../core/utils/app_dialog_util.dart';
import '../../features/search/presentation/providers/search_provider.dart';
import '../../features/search/presentation/widgets/modals/filter_modal.dart';
import 'h_space.dart';

class ProfileActions extends StatelessWidget {
  const ProfileActions(
      {super.key,
      this.showSearchIcon = true,
      this.showFilterIcon = true,
      required this.filterType,
      required this.categoryExternalId});

  final bool showSearchIcon;
  final bool showFilterIcon;
  final String filterType;
  final String categoryExternalId;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (showSearchIcon)
          Container(
            padding: EdgeInsets.all(AppThemeUtil.radius(10)),
            decoration: ShapeDecoration(
              color: kGrey50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppThemeUtil.radius(12)),
              ),
            ),
            child: ZSvgIcon(
              "MagnifyingGlass.svg",
              size: AppThemeUtil.radius(24.0),
              color: kPrimaryBlack,
            ),
          ).onPressed(() {
            AppNavigator.pushNamed(context, AppRoute.search);
          }),
        const HSpace(width: 12.0),
        if (showFilterIcon)
          Container(
            padding: EdgeInsets.all(AppThemeUtil.radius(10)),
            decoration: ShapeDecoration(
              color: kGrey50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppThemeUtil.radius(12)),
              ),
            ),
            child: ZSvgIcon(
              "filter.svg",
              size: AppThemeUtil.radius(24.0),
              color: kPrimaryBlack,
            ),
          ).onPressed(() {
            // context.read<ProductProvider>().emitPopularCategories();
            context.read<SearchProvider>().emitPopularLocations();
            AppDialogUtil.showScrollableBottomSheet(
              context: context,
              builder: (context) => FilterModal(
                  type: filterType, categoryExternalId: categoryExternalId),
            );
          }),
      ],
    ).paddingOnly(right: AppThemeUtil.radius(20));
  }
}
