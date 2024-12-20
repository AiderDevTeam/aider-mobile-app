
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';



class AppTextButton extends StatelessWidget {
  const AppTextButton({
    super.key,
    this.text,
    required this.onPressed,
    this.child,
    this.hasButtonStyle = false,
    this.fontSize,
    this.isRegular = false,
    this.textColor,
  });

  final String? text;
  final void Function()? onPressed;
  final Widget? child;
  final bool hasButtonStyle;
  final double? fontSize;
  final bool isRegular;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: hasButtonStyle? TextButton.styleFrom(
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
        splashFactory: NoSplash.splashFactory,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ) : null ,
      child: child?? (isRegular?  Text(
          text?? ''
      ).regular().fontSize(fontSize?? 16.0).color(kPrimaryBlack).letterSpacing(-0.18)
          :
      Text(
          text?? ''
      ).bold().fontSize(fontSize?? 16.0).color(textColor ?? kPrimaryBlack).letterSpacing(-0.18)),
    );
  }
}
