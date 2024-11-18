
import 'package:aider_mobile_app/core/constants/colors.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/app_theme_util.dart';
import '../../../core/utils/helper_util.dart';
import '../../../core/constants/common.dart';



class AppBottomNavWrapper extends StatelessWidget {
  const AppBottomNavWrapper({
    super.key,
    required this.child,
    this.backgroundColor,
    this.padding,
    this.border,
  });

  final Widget? child;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor?? AppThemeUtil.getThemeColor(kPrimaryWhite, kPrimaryBlack),
        // border: border ?? const Border(
        //   top: BorderSide(color: kGrey300),
        // )
      ),
      padding: padding?? EdgeInsets.only(
        top: AppThemeUtil.height(20.0),
        bottom: AppThemeUtil.height(HelperUtil.isIOS? 24.0:16.0),
        left: AppThemeUtil.width(kWidthPadding),
        right: AppThemeUtil.width(kWidthPadding),
      ),
      child: child,
    );
  }
}
