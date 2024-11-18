import 'package:aider_mobile_app/core/extensions/widgets/gesture_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/utils/app_theme_util.dart';
import '../../../../shared_widgets/cards/app_card.dart';
import '../../../../shared_widgets/common/h_space.dart';
import '../../../../shared_widgets/common/svg_icon.dart';

class ProfileTabNavigate extends StatelessWidget {
  const ProfileTabNavigate({
    super.key,
    required this.text,
    required this.iconName,
    required this.onPressed,
    this.color,
    this.decoration,
    this.size,
  });

  final String text;
  final String iconName;
  final void Function() onPressed;
  final Color? color;
  final Decoration? decoration;
  final size;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.all(AppThemeUtil.radius(12)),
      decoration: decoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ZSvgIcon(
                iconName,
                size: AppThemeUtil.radius(size ?? 20.0),
                color: color?? kGrey1200,
              ),
              const HSpace(width: 8.0),
              Text(text).medium().fontSize(16.0).color(color?? kGrey1200).letterSpacing(-0.48),
            ],
          ),

          ZSvgIcon(
            'caret_right.svg',
            size: AppThemeUtil.radius(20.0),
            color: color?? kGrey500,
          ),
        ],
      ),
    ).onPressed(onPressed);
  }
}
