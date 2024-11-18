import 'package:aider_mobile_app/core/utils/app_theme_util.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';


class AppDottedBorder extends StatelessWidget {
  const AppDottedBorder({
    super.key,
    required this.child,
    this.color,
    this.padding,
    this.strokeWidth = 1,
    this.borderType,
    this.dashPattern,
    this.radius,
  });

  final Widget child;
  final Color? color;
  final EdgeInsets? padding;
  final double strokeWidth;
  final BorderType? borderType;
  final List<double>? dashPattern;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: borderType?? BorderType.Rect,
      padding: padding?? EdgeInsets.all(AppThemeUtil.radius(6.0)),
      strokeWidth: strokeWidth,
      dashPattern: dashPattern?? [5, 4,],
      color: color?? Colors.grey.shade500,
      radius: Radius.circular(AppThemeUtil.radius(radius ?? 0.0)),
      child: child,
    );
  }
}
