import 'package:aider_mobile_app/core/utils/app_theme_util.dart';
import 'package:aider_mobile_app/core/constants/colors.dart';
import 'package:flutter/material.dart';

import '../common/svg_icon.dart';

class FieldEye extends StatelessWidget {
  const FieldEye({
    super.key,
    required this.onPressed,
    this.isHidden = true,
  });

  final void Function()? onPressed;
  final bool isHidden;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: ZSvgIcon(
        isHidden? "eye_close.svg" : "eye.svg",
        size: AppThemeUtil.radius(12.0),
        color: AppThemeUtil.getThemeColor(kPrimaryBlack),
      )
    );
  }
}
