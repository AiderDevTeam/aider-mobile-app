
import 'package:aider_mobile_app/core/utils/app_theme_util.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';

class CachedImageError extends StatelessWidget {
  const CachedImageError({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kPrimaryWhite,
        borderRadius: BorderRadius.circular(AppThemeUtil.radius(10.0)),
      ),
      child: Icon(
        Icons.error,
        color: kPrimaryWhite,
        size: AppThemeUtil.radius(24.0),
      ),
    );
  }
}
