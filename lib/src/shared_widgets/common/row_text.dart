import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';

class RowText extends StatelessWidget {
  const RowText({
    super.key,
    this.leftText,
    this.leftWidget,
    this.rightText,
    this.rightWidget,
    this.rightTextColor,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    this.mainAxisSize = MainAxisSize.max,
    this.fontSize = 16.0,
  });

  final String? leftText;
  final String? rightText;
  final Widget? leftWidget;
  final Widget? rightWidget;
  final Color? rightTextColor;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  final double fontSize;
  final MainAxisSize mainAxisSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: [
        leftWidget?? Text(leftText?? '').regular().fontSize(fontSize).color(kPrimaryBlack),
        rightWidget?? Text(rightText?? '').regular().fontSize(fontSize).color(rightTextColor ?? kPrimaryBlack).alignText(TextAlign.end),
      ],
    );
  }
}