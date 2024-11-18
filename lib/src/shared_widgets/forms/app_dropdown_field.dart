import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/app_theme_util.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/common.dart';
import '../../../core/constants/text_style.dart';

class AppDropdownField extends StatelessWidget {
  final void Function(String?)? onChanged;
  final String? selectedItem;
  final List<String> listItems;
  final String hintText;
  final Color? borderColor;
  final String? Function(String?)? validator;
  final double dropdownMaxHeight;
  final Offset? dropDownOffset;

  const AppDropdownField({
    super.key,
    this.onChanged,
    this.selectedItem,
    required this.listItems,
    this.hintText = '',
    this.borderColor,
    this.validator,
    this.dropdownMaxHeight = 220,
    this.dropDownOffset,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
      child: DropdownButtonFormField2(
        isExpanded: true,
        hint: Text(
          hintText,
        ).regular().fontSize(14.0).color(kGrey500),
        iconStyleData: IconStyleData(
          icon: Icon(
            Icons.keyboard_arrow_down_outlined,
            size: AppThemeUtil.radius(24),
            color: AppThemeUtil.getThemeColor(kPrimaryBlack),
          ),
        ),
        // value: selectedItem,
        validator: validator,
        onChanged: onChanged,
        decoration: InputDecoration(
          helperText: ' ',
          helperStyle: kRegularFontStyle.copyWith(
            fontSize: AppThemeUtil.fontSize(14.0),
            height: 0.01
          ),
          errorStyle: kRegularFontStyle.copyWith(
            fontSize: AppThemeUtil.fontSize(12.0),
            color: AppThemeUtil.getThemeColor(kError600),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: AppThemeUtil.width(16.0),
            vertical: AppThemeUtil.height(14.0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppThemeUtil.radius(12.0))),
            borderSide: BorderSide(color: AppThemeUtil.getThemeColor(kError600), width: 1.0),
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

        dropdownStyleData: DropdownStyleData(
          maxHeight: dropdownMaxHeight,
          width: (MediaQuery.of(context).size.width-(kWidthPadding+kWidthPadding)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppThemeUtil.radius(16)),
            border: Border.all(color: AppThemeUtil.getThemeColor(kGrey200),),
            color: AppThemeUtil.getThemeColor(kPrimaryWhite),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.06),
                spreadRadius: 0,
                blurRadius: 15,
                offset: Offset(0, 10),
              ),
            ],
          ),
          offset: dropDownOffset?? const Offset(0, -8),
        ),
        items: listItems.map((obj) => DropdownItem<String>(
          value: obj,
          child: Text(
            obj,
          ).semiBold().fontSize(14.0).color(kPrimaryBlack),
        )).toList(),
      ),
    );
  }
}
