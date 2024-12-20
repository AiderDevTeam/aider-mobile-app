import 'package:aider_mobile_app/core/extensions/widgets/gesture_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_theme_util.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../shared_widgets/common/h_space.dart';

class CountryCodePrefix extends StatelessWidget {
  const CountryCodePrefix({
    super.key,
    required this.onTap,
    required this.selectedCountry,
  });

  final void Function() onTap;
  final ValueNotifier<Map<String, dynamic>> selectedCountry;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(AppThemeUtil.radius(8.0)),
          margin: EdgeInsets.only(left: AppThemeUtil.width(8.0)),
          decoration: BoxDecoration(
            color: const Color(0xFFF2F4F7),
            borderRadius: BorderRadius.circular(AppThemeUtil.radius(8.0)),
          ),
          child: ValueListenableBuilder<Map<String, dynamic>>(
              valueListenable: selectedCountry,
              builder: (context, selectedCountryValue, child) {
                return Row(
                  children: [
                    Image.asset(
                      selectedCountryValue['path'],
                      width: AppThemeUtil.width(25.0),
                      package: selectedCountryValue['package'],
                    ),
                    const HSpace(width: 8.0),
                    Text(selectedCountryValue['code']?? '').bold().fontSize(14.0).color(kPrimaryBlack)
                  ],
                );
              }
          ),
        ).onPressed(onTap),
      ],
    );
  }
}
