import 'package:aider_mobile_app/core/extensions/widgets/flexible_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/common.dart';
import '../../../core/constants/text_style.dart';
import '../../../core/utils/app_theme_util.dart';
import '../../../core/utils/helper_util.dart';
import '../common/svg_icon.dart';


class AppIconTextButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final Color? color;
  final TextStyle? textStyle;
  final double minWidth;
  final double height;
  final bool scaledText;
  final Color? borderColor;
  final double? fontSize;
  final String? imageIconName;
  final Color? textColor;
  final MainAxisAlignment mainAxisAlignment;
  final Widget? icon;
  final double iconPaddingFromText;
  final bool isIconRight;
  final MainAxisSize mainAxisSize;
  final TextScaler? textScaler;

  const AppIconTextButton({
    super.key,
    required this.onPressed,
    this.text = '',
    this.color,
    this.textStyle,
    this.minWidth = 294.0,
    this.height = 48.0,
    this.scaledText = true,
    this.borderColor,
    this.fontSize,
    this.imageIconName,
    this.textColor,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.icon,
    this.iconPaddingFromText = 8.0,
    this.isIconRight = false,
    this.mainAxisSize = MainAxisSize.max,
    this.textScaler,
  }) : assert(imageIconName != null || icon!= null);


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
          disabledColor: AppThemeUtil.getThemeColor(kGrey300),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppThemeUtil.radius(8.0)),
            side: BorderSide(color: onPressed != null ? (borderColor?? AppThemeUtil.getThemeColor(kPrimaryBlack)) : Colors.transparent),
          ),
          onPressed: onPressed,
          minWidth: AppThemeUtil.width(minWidth),
          height: AppThemeUtil.height(height),
          child: isIconRight?
          Row(
            mainAxisAlignment: mainAxisAlignment,
            mainAxisSize: mainAxisSize,
            children: [
              Text(
                text,
                style: textStyle?? kSemiBoldFontStyle.copyWith(
                  fontSize: AppThemeUtil.fontSize(fontSize?? 16),
                  color: onPressed != null ? AppThemeUtil.getThemeColor(textColor?? kPrimaryWhite) : AppThemeUtil.getThemeColor(kPrimaryWhite),
                ),
                overflow: TextOverflow.ellipsis,
                textScaler: textScaler,
              ).flexible(),

              if(icon!=null) icon!.paddingOnly(left: iconPaddingFromText),

              if(imageIconName!=null) ...[
                HelperUtil.isSvgImage(imageIconName?? '') ? ZSvgIcon(
                  imageIconName!,
                  size: AppThemeUtil.radius(21),
                ).paddingOnly(right: iconPaddingFromText).flexible()
                    :
                Container(
                  height: AppThemeUtil.radius(21),
                  width: AppThemeUtil.radius(21),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('$kImagePath/$imageIconName'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ).paddingOnly(right: iconPaddingFromText).flexible()
              ],
            ],
          )
              :
          Row(
            mainAxisAlignment: mainAxisAlignment,
            mainAxisSize: mainAxisSize,
            children: [
              if(imageIconName!=null) ...[
                HelperUtil.isSvgImage(imageIconName?? '') ? ZSvgIcon(
                  imageIconName!,
                  size: AppThemeUtil.radius(21),
                ).paddingOnly(right: iconPaddingFromText).flexible()
                    :
                Container(
                  height: AppThemeUtil.radius(21),
                  width: AppThemeUtil.radius(21),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('$kImagePath/$imageIconName'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ).paddingOnly(right: iconPaddingFromText).flexible()
              ],

              if(icon!=null) icon!.paddingOnly(right: iconPaddingFromText),

              Text(
                text,
                style: textStyle?? kSemiBoldFontStyle.copyWith(
                  fontSize: AppThemeUtil.fontSize(fontSize?? 16),
                  color: onPressed != null ? AppThemeUtil.getThemeColor(textColor?? kPrimaryWhite) : AppThemeUtil.getThemeColor(kPrimaryWhite),
                ),
                overflow: TextOverflow.ellipsis,
                textScaler: textScaler
              ).flexible()
            ],
          ),
        ),
      ),
    );
  }
}
