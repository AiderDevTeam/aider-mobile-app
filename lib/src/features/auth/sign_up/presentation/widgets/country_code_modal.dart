

import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/core/constants/colors.dart';
import 'package:aider_mobile_app/core/constants/common.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_theme_util.dart';
import '../../../../../../core/constants/text_style.dart';

class CountryCodeModal{
  static Future<CountryCode?> showDialog(BuildContext context) async{
    final countryPicker = FlCountryCodePicker(
      localize: true,
      showDialCode: true,
      showSearchBar: true,
      title: const Text('Select country').bold().fontSize(18.0).color(kPrimaryBlack).paddingOnly(
        top: 16.0,
        left: kWidthPadding,
      ),
      filteredCountries: ['NG'],
      searchBarDecoration: InputDecoration(
        hintText: 'Search country or dial code',
        fillColor: AppThemeUtil.getThemeColor(kGrey300),
        isDense: true,
        hintStyle: kRegularFontStyle.copyWith(
          fontSize: AppThemeUtil.fontSize(14.0),
          color: AppThemeUtil.getThemeColor(kGrey500),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppThemeUtil.width(16.0),
          vertical: AppThemeUtil.height(14.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppThemeUtil.radius(12.0))),
          borderSide: BorderSide(color: AppThemeUtil.getThemeColor(kError700), width: 1.0),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppThemeUtil.getThemeColor(kGrey300), width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(AppThemeUtil.radius(12.0))),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppThemeUtil.getThemeColor(kGrey300), width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(AppThemeUtil.radius(12.0))),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppThemeUtil.getThemeColor(kPrimaryBlack), width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(AppThemeUtil.radius(12.0))),
        ),
      ),
      searchBarTextStyle: kSemiBoldFontStyle.copyWith(
        fontSize: AppThemeUtil.fontSize(14.0),
        color: AppThemeUtil.getThemeColor(kPrimaryBlack),
      ),
      countryTextStyle: kSemiBoldFontStyle.copyWith(
        fontSize: AppThemeUtil.fontSize(14.0),
        color: AppThemeUtil.getThemeColor(kPrimaryBlack),
      ),
      dialCodeTextStyle: kSemiBoldFontStyle.copyWith(
        fontSize: AppThemeUtil.fontSize(14.0),
        color: AppThemeUtil.getThemeColor(kPrimaryBlack),
      ),
    );

    return await countryPicker.showPicker(
      context: context,
      pickerMaxHeight: MediaQuery.of(context).size.height * 0.7,
      barrierColor: kBlack70,
    );
  }
}