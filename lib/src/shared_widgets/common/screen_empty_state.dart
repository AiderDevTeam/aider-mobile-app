
import 'package:aider_mobile_app/core/constants/colors.dart';
import 'package:aider_mobile_app/core/constants/common.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/app_theme_util.dart';
import 'h_space.dart';
import 'v_space.dart';

class ScreenEmptyState extends StatelessWidget {
  const ScreenEmptyState({
    super.key,
    this.title = 'Transactions',
    this.subtitle = 'No transaction to display',
    this.isVertical = true,
    this.customButton,
    this.titleTextStyle,
    this.iconData,
    this.iconColor,
  });
  
  final String title;
  final String subtitle;
  final bool isVertical;
  final Widget? customButton;
  final TextStyle? titleTextStyle;
  final IconData? iconData;
  final Color? iconColor;


  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        horizontal: AppThemeUtil.width(kWidthPadding),
      ),
      child: isVertical ?
      Column(
        children: [
          CircleAvatar(
            backgroundColor: AppThemeUtil.getThemeColor(kGrey100),
            maxRadius: AppThemeUtil.radius(35.0),
            child: Icon(
              iconData?? Icons.folder_open,
              size: AppThemeUtil.radius(24.0),
              color: AppThemeUtil.getThemeColor(iconColor?? kPrimaryBlack),
            ),
          ),
          const VSpace(height: 10.0),
          if(title.isNotEmpty)Text(
            title,
          ).semiBold().fontSize(14.0).color(kPrimaryBlack).alignText(TextAlign.center),
          const VSpace(height: 5),
          Text(
            subtitle,
          ).regular().fontSize(12.0).color(kGrey500).alignText(TextAlign.center),
          if(customButton != null) const VSpace(height: 16),
          if(customButton != null) customButton!,
        ],
      )
          :
      Row(
        children: [
          CircleAvatar(
            backgroundColor: AppThemeUtil.getThemeColor(kGrey100),
            maxRadius: AppThemeUtil.radius(35.0),
            child: Icon(
              iconData?? Icons.folder_open,
              size: AppThemeUtil.radius(24.0),
              color: AppThemeUtil.getThemeColor(iconColor?? kPrimaryBlack),
            ),
          ),
          const HSpace(width: 10.0),
          Column(
            children: [
              if(title.isNotEmpty) ...[
                Text(
                  title,
                ).semiBold().fontSize(14.0).color(kPrimaryBlack).alignText(TextAlign.center),
                const VSpace(height: 5.0),
              ],
              Text(
                subtitle,
              ).regular().fontSize(12.0).color(kGrey500).height(24.0, 12.0).alignText(TextAlign.center),
            ],
          ),
        ],
      ),
    );
  }
}
