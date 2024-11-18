import 'package:aider_mobile_app/core/extensions/widgets/flexible_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/gesture_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/core/constants/colors.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/app_theme_util.dart';
import '../../../core/constants/common.dart';
import '../common/svg_icon.dart';


class AiderAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;
  final String? title;
  final void Function() onPressed;
  final List<Widget>? actions;
  final bool hasLeading;
  final bool hasBottomBorder;
  final Color? appBarBackgroundColor;
  final double? titleFontSize;
  final Widget? titleWidget;

  const AiderAppBar({
    super.key,
    required this.appBar,
    this.title,
    required this.onPressed,
    this.actions,
    this.hasLeading = true,
    this.hasBottomBorder = true,
    this.appBarBackgroundColor,
    this.titleFontSize,
    this.titleWidget,
  });

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height+5);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      centerTitle: false,
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: appBarBackgroundColor,
      flexibleSpace: Row(
        children: [
          if(hasLeading) Container(
            width: AppThemeUtil.radius(44.0),
            height: AppThemeUtil.radius(44.0),
            decoration: BoxDecoration(
              color: AppThemeUtil.getThemeColor(const Color(0xFFF8F8F8)),
              borderRadius: BorderRadius.circular(AppThemeUtil.radius(12.0)),
            ),
            padding: EdgeInsets.all(AppThemeUtil.radius(8.0)),
            child: ZSvgIcon(
              'arrow_left.svg',
              size: AppThemeUtil.radius(30.0),
              color: AppThemeUtil.getThemeColor(kPrimaryBlack, kPrimaryWhite),
            ),
          ).onPressed(onPressed),
          titleWidget?? Text(
            title?? '',
          ).semiBold().fontSize(titleFontSize?? 20.0).color(kPrimaryBlack, kPrimaryWhite).letterSpacing(-0.31).overflowText(TextOverflow.ellipsis)
              .paddingOnly(
            left: hasLeading? 8.0 : 0.0,
            top: hasLeading? 0.0: 10.0,
          ).flexible(),
        ],
      ).paddingLTRB(
        kWidthPadding,
        MediaQuery.of(context).viewPadding.top + 10,
        kWidthPadding,
        10.0,
      ),
      actions: actions ?? [],
    );
  }
}