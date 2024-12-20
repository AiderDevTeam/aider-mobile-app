import 'package:aider_mobile_app/core/constants/common.dart';
import 'package:aider_mobile_app/core/utils/app_theme_util.dart';
import 'package:flutter/material.dart';



class AppLoader extends StatelessWidget {
  const AppLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        '$kAnimationPath/loader.gif',
        width: AppThemeUtil.radius(200),
        height: AppThemeUtil.radius(200),
      ),
    );
  }
}