import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/core/utils/app_theme_util.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/colors.dart';

class SuggestionTag extends StatelessWidget {
  const SuggestionTag({
    super.key,
    required this.text,
    this.onTap,
    this.color,
    this.textColor,
    this.padding,
    this.fontSize,
    this.height,
    this.semiBold = false,
    this.leftWidget,
    this.rightWidget,
  });

  final String text;
  final void Function()? onTap;
  final Color? color;
  final Color? textColor;
  final EdgeInsets? padding;
  final double? fontSize;
  final double? height;
  final bool semiBold;
  final Widget? leftWidget;
  final Widget? rightWidget;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: height == null? null : Alignment.center,
        height: height == null? null : AppThemeUtil.height(36),
        padding: padding?? EdgeInsets.symmetric(horizontal: AppThemeUtil.width(16), vertical: AppThemeUtil.height(4)),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: AppThemeUtil.getThemeColor(color ?? kGrey100),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(leftWidget != null) leftWidget!,
            semiBold?
            Text(
              text,
            ).medium().fontSize(fontSize?? 14).height(21, 14).letterSpacing(-0.15).alignText(TextAlign.center).color(textColor?? kPrimaryBlack)
                :
            Text(
              text,
            ).regular().fontSize(fontSize?? 14).height(21, 14).letterSpacing(-0.15).alignText(TextAlign.center).color(textColor?? kPrimaryBlack),
            if(rightWidget != null) rightWidget!,
          ],
        ),
        // .color(textColor ?? ),
      ),
    );
  }
}
