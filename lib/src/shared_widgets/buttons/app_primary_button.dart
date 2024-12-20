import 'package:flutter/material.dart';

import '../../../core/utils/app_theme_util.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/text_style.dart';


class AppPrimaryButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final Color? color;
  final TextStyle? textStyle;
  final double minWidth;
  final double height;
  final TextScaler? textScaler;
  final Color? borderColor;
  final double? fontSize;
  final Color? textColor;
  final double? radius;

  const AppPrimaryButton({
    super.key,
    required this.onPressed,
    this.text = '',
    this.color,
    this.textStyle,
    this.minWidth = 294.0,
    this.height = 56.0,
    this.textScaler,
    this.borderColor,
    this.fontSize,
    this.textColor,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppThemeUtil.height(height),
      child: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: MaterialButton(
          elevation: 0,
          highlightElevation: 0,
          color: color?? AppThemeUtil.getThemeColor(kPrimaryBlack),
          disabledColor: AppThemeUtil.getThemeColor(kGrey200),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppThemeUtil.radius(radius?? 12.0)),
            side: BorderSide(color: onPressed != null ? (borderColor?? AppThemeUtil.getThemeColor(kPrimaryBlack)) : Colors.transparent),
          ),
          onPressed: onPressed,
          minWidth: AppThemeUtil.width(minWidth),
          height: AppThemeUtil.height(height),
          child: Text(
            text,
            style: textStyle?? kSemiBoldFontStyle.copyWith(
              fontSize: AppThemeUtil.fontSize(fontSize?? 16),
              color: onPressed != null ? AppThemeUtil.getThemeColor(textColor?? kPrimaryWhite) : AppThemeUtil.getThemeColor(const Color(0xFF98A2B3)),
            ),
            textScaler: textScaler,
          ),
        ),
      ),
    );
  }
}
