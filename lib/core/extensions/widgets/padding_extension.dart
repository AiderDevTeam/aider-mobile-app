
import 'package:flutter/material.dart';

import '../../utils/app_theme_util.dart';



extension PaddingExtension on Widget {
  Padding paddingAll(double value, {Key? key}) => Padding(
    key: key,
    padding: EdgeInsets.all(AppThemeUtil.radius(value)),
    child: this,
  );

  Padding paddingOnly({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
    Key? key,
  }) =>
      Padding(
        key: key,
        padding:
        EdgeInsets.only(
          top: AppThemeUtil.height(top),
          left: AppThemeUtil.width(left),
          bottom: AppThemeUtil.height(bottom),
          right: AppThemeUtil.width(right),
        ),
        child: this,
      );

  Padding paddingLTRB(
      double left,
      double top,
      double right,
      double bottom, {
        Key? key,
      }) =>
      Padding(
        key: key,
        padding: EdgeInsets.fromLTRB(
          AppThemeUtil.width(left),
          AppThemeUtil.height(top),
          AppThemeUtil.width(right),
          AppThemeUtil.height(bottom),
        ),
        child: this,
      );

  Padding paddingSymmetric(
      {double vertical = 0.0, double horizontal = 0.0, Key? key}) =>
      Padding(
        key: key,
        padding: EdgeInsets.symmetric(
          vertical: AppThemeUtil.height(vertical),
          horizontal: AppThemeUtil.width(horizontal),
        ),
        child: this,
      );
}