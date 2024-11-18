import 'package:aider_mobile_app/core/utils/app_theme_util.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    this.backgroundColor,
    this.child,
    this.margin,
    this.padding,
    this.decoration,
    this.height,
    this.width,
    this.gradient,
    this.borderRadius,
    this.border,
    this.alignment,
  });


  final Color? backgroundColor;
  final Widget? child;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Decoration? decoration;
  final double? width;
  final double? height;
  final Gradient? gradient;
  final double? borderRadius;
  final BoxBorder? border;
  final AlignmentGeometry? alignment;


  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      margin: margin,
      padding: padding,
      width: width,
      height: height,
      decoration: decoration?? BoxDecoration(
        color: backgroundColor?? AppThemeUtil.getThemeColor(kPrimaryWhite, kPrimaryBlack),
        borderRadius: BorderRadius.circular(borderRadius?? AppThemeUtil.radius(12.0)),
        border: border,
        gradient: gradient,
      ),
      child: child,
    );
  }
}
