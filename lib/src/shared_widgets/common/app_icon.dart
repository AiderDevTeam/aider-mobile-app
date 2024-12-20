import 'package:aider_mobile_app/core/utils/app_theme_util.dart';
import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  const AppIcon(
      this.icon, {
        super.key,
        this.color,
        this.size,
      });

  final IconData icon;
  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: color,
      size: size?? AppThemeUtil.radius(24.0),
    );
  }
}
