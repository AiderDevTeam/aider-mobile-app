import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';

class FormLabel extends StatelessWidget {
  const FormLabel({
    super.key,
    required this.text,
    this.customText,
  });

  final String text;
  final Widget? customText;

  @override
  Widget build(BuildContext context) {
    return customText?? Text(text).regular().fontSize(14.0).color(kGrey1200).letterSpacing(-0.15);
  }
}
