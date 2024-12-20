import 'package:aider_mobile_app/core/constants/colors.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/app_theme_util.dart';

class ZLoading extends StatelessWidget {
  const ZLoading({super.key, this.color,});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppThemeUtil.radius(20.0),
      width: AppThemeUtil.radius(20.0),
      child: CircularProgressIndicator(
        color: color?? kPrimaryBlack,
        strokeWidth: 3,
      ),
    );
  }
}
