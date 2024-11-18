import 'package:aider_mobile_app/core/utils/app_theme_util.dart';
import 'package:aider_mobile_app/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/constants/text_style.dart';

class AppInputField extends StatelessWidget {
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final String? hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextAlign textAlign;
  final int? maxLength;
  final TextEditingController? controller;
  final bool readOnly;
  final bool filled;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final void Function()? onTap;
  final TextCapitalization textCapitalization;
  final String helperText;
  final bool hasHeight;
  final Color? customBorderColor;
  final Color? helperStyleColor;
  final Color? fillColor;
  final void Function(PointerDownEvent)? onTapOutside;
  final TextInputAction textInputAction;
  final double? helperHeight;
  final String? counterText;
  final Color? counterTextColor;
  final int? maxLine;
  final void Function(String)? onFieldSubmitted;
  final bool autofocus;
  final Iterable<String>? autofillHints;
  final bool autocorrect;
  final bool enableSuggestions;
  final double? roundedBorderSize;

  const AppInputField({
    super.key,
    this.onChanged,
    this.validator,
    this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textAlign = TextAlign.left,
    this.maxLength,
    this.controller,
    this.readOnly = false,
    this.filled = false,
    this.suffixIcon,
    this.prefixIcon,
    this.focusNode,
    this.inputFormatters,
    this.onTap,
    this.textCapitalization = TextCapitalization.none,
    this.helperText = ' ',
    this.hasHeight = true,
    this.customBorderColor,
    this.helperStyleColor,
    this.fillColor,
    this.onTapOutside,
    this.textInputAction = TextInputAction.done,
    this.helperHeight,
    this.counterText = '',
    this.maxLine = 1,
    this.counterTextColor,
    this.onFieldSubmitted,
    this.autofocus = false,
    this.autofillHints,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.roundedBorderSize,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: onTapOutside,
      onTap: onTap,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      textAlign: textAlign,
      maxLines: maxLine,
      style: kSemiBoldFontStyle.copyWith(
        fontSize: AppThemeUtil.fontSize(14.0),
        color: AppThemeUtil.getThemeColor(kPrimaryBlack),
      ),
      onChanged: onChanged,
      validator: validator,
      maxLength: maxLength,
      readOnly: readOnly,
      controller: controller,
      textCapitalization: textCapitalization,
      focusNode: focusNode,
      inputFormatters: inputFormatters,
      cursorColor: AppThemeUtil.getThemeColor(kPrimaryBlack),
      onFieldSubmitted: onFieldSubmitted,
      autofocus: autofocus,
      autofillHints: autofillHints,
      autocorrect: autocorrect,
      enableSuggestions: enableSuggestions,
      decoration: InputDecoration(
        fillColor: fillColor ?? AppThemeUtil.getThemeColor(kGrey50),
        filled: filled,
        hintText: hintText,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        counterText: counterText,
        helperText: helperText,
        isDense: true,
        hintStyle: kRegularFontStyle.copyWith(
          fontSize: AppThemeUtil.fontSize(14.0),
          color: AppThemeUtil.getThemeColor(kGrey500),
        ),
        helperStyle: kRegularFontStyle.copyWith(
          fontSize: AppThemeUtil.fontSize(14.0),
          color: helperStyleColor?? AppThemeUtil.getThemeColor(kPrimaryBlack),
          height: helperHeight,
        ),
        counterStyle: kSemiBoldFontStyle.copyWith(
          fontSize: AppThemeUtil.fontSize(10),
          color: AppThemeUtil.getThemeColor(counterTextColor?? kPrimaryBlack),
        ),
        errorStyle: kRegularFontStyle.copyWith(
          fontSize: AppThemeUtil.fontSize(12.0),
          color: AppThemeUtil.getThemeColor(kError600),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppThemeUtil.width(16.0),
          vertical: AppThemeUtil.height(16.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppThemeUtil.radius(roundedBorderSize?? 12.0))),
          borderSide: BorderSide(color: AppThemeUtil.getThemeColor(kError600), width: 1.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppThemeUtil.radius(roundedBorderSize?? 12.0))),
          borderSide: BorderSide(color: AppThemeUtil.getThemeColor(kError600), width: 1.0),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: customBorderColor ?? AppThemeUtil.getThemeColor(kGrey200), width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(AppThemeUtil.radius(roundedBorderSize?? 12.0))),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: customBorderColor??  AppThemeUtil.getThemeColor(kGrey200), width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(AppThemeUtil.radius(roundedBorderSize?? 12.0))),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: customBorderColor?? AppThemeUtil.getThemeColor(kPrimaryBlack), width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(AppThemeUtil.radius(roundedBorderSize?? 12.0))),
        ),
      ),
    );
  }
}
