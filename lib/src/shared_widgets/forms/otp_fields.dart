import 'package:aider_mobile_app/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../core/utils/app_theme_util.dart';
import '../../../core/constants/text_style.dart';

class OtpFields extends StatelessWidget {
  final Function(String) onCompleted;
  final TextEditingController? controller;

  const OtpFields({
    super.key,
    required this.onCompleted,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      controller: controller,
      appContext: context,
      pastedTextStyle: kBoldFontStyle.copyWith(
        color: AppThemeUtil.getThemeColor(kPrimaryBlack),
        fontSize: AppThemeUtil.fontSize(32.0),
      ),
      textStyle: kBoldFontStyle.copyWith(
        color: AppThemeUtil.getThemeColor(kPrimaryBlack),
        fontSize: AppThemeUtil.fontSize(32.0),
      ),
      length: 4,
      animationType: AnimationType.fade,
      autoFocus: true,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(AppThemeUtil.radius(16.0)),
        fieldHeight: AppThemeUtil.radius(68.0),
        fieldWidth: AppThemeUtil.radius(68.0),
        activeColor: AppThemeUtil.getThemeColor(kPrimaryBlack),
        borderWidth: 1.0,
        selectedColor: AppThemeUtil.getThemeColor(kPrimaryBlack),
        inactiveColor: AppThemeUtil.getThemeColor(const Color(0xFFD6D6D6)),
        activeFillColor: AppThemeUtil.getThemeColor(const Color(0xFFD6D6D6)),
        selectedFillColor: AppThemeUtil.getThemeColor(const Color(0xFFD6D6D6)),
        inactiveFillColor: AppThemeUtil.getThemeColor(const Color(0xFFD6D6D6)),
      ),
      hintCharacter: '',
      hintStyle: kRegularFontStyle.copyWith(
        fontSize: AppThemeUtil.fontSize(32.0),
        color: AppThemeUtil.getThemeColor(kGrey500),
      ),
      cursorColor: AppThemeUtil.getThemeColor(kPrimaryBlack),
      animationDuration: const Duration(milliseconds: 300),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onCompleted: onCompleted,
      onChanged: (value) {},
      beforeTextPaste: (text) {
        return true;
      },
    );
  }
}
