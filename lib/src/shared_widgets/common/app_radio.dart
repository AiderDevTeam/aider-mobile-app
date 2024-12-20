import 'package:flutter/material.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

import '../../../core/constants/colors.dart';
import '../../../core/utils/app_theme_util.dart';

class AppRadio extends StatelessWidget {
  const AppRadio({
    super.key,
    this.selected = false,
    this.onTap,
    this.size = 24.0,
  });

  final bool selected;
  final void Function(bool?)? onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    return RoundCheckBox(
      isChecked: selected,
      size: AppThemeUtil.radius(size),
      onTap: onTap,
      border: Border.all(
        width: 1,
        color: selected ? AppThemeUtil.getThemeColor(kGrey1200) : AppThemeUtil.getThemeColor(kGrey200),
      ),
      disabledColor: selected? AppThemeUtil.getThemeColor(kGrey1200) : AppThemeUtil.getThemeColor(kPrimaryWhite),
      checkedColor: AppThemeUtil.getThemeColor(kGrey1200),
      checkedWidget: CircleAvatar(
        maxRadius: AppThemeUtil.radius(10),
        backgroundColor: kPrimaryWhite,
        child: Icon(
          Icons.circle,
          size: AppThemeUtil.radius(12.0),
          color: AppThemeUtil.getThemeColor(kPrimaryBlack),
        ),
      ),
      animationDuration: const Duration(
        milliseconds: 50,
      ),
    );
  }
}
