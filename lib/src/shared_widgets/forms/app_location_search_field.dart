
import 'package:aider_mobile_app/core/extensions/widgets/flexible_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/core/utils/app_theme_util.dart';
import 'package:aider_mobile_app/core/constants/colors.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/v_space.dart';
import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';

import '../../../core/constants/text_style.dart';
import '../../../core/domain/models/location/location_prediction_model.dart';

class AppLocationSearchField extends StatelessWidget {
  const AppLocationSearchField({
    super.key,
    this.keyboardType = TextInputType.text,
    this.textAlign = TextAlign.left,
    this.hintText,
    this.controller,
    this.validator,
    this.suffixIcon,
    this.prefixIcon,
    this.focusNode,
    required this.suggestions,
    required this.queryFetch,
    this.onSuggestionTap,
    this.offset,
  });


  final TextInputType keyboardType;
  final TextAlign textAlign;
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final FocusNode? focusNode;
  final List<LocationPredictionModel> suggestions;
  final void Function(String query) queryFetch;
  final dynamic Function(SearchFieldListItem<LocationPredictionModel>)? onSuggestionTap;
  final Offset? offset;

  @override
  Widget build(BuildContext context) {

    return SearchField<LocationPredictionModel>(
      suggestions: suggestions.
      map((e) => SearchFieldListItem<LocationPredictionModel>(
        e.description?? '',
        item: e,
        child: Text('${e.description}').semiBold().color(kPrimaryBlack).fontSize(14.0).textMaxLines(2).overflowText(TextOverflow.ellipsis).flexible().paddingSymmetric(horizontal: 8.0, vertical: 8.0,),
      )).toList(),
      onSearchTextChanged: (query){
        if(query.isNotEmpty){
          queryFetch.call(query);
        }
        return suggestions
            .map((e) => SearchFieldListItem<LocationPredictionModel>(
          e.description?? '',
          child: Text('${e.description}').semiBold().color(kPrimaryBlack).fontSize(14.0).textMaxLines(2).overflowText(TextOverflow.ellipsis).flexible().paddingSymmetric(horizontal: 8.0, vertical: 8.0,),
        ),
        ).toList();
      },
      hint: hintText,
      controller: controller,
      focusNode: focusNode,
      validator: validator,
      searchStyle: kSemiBoldFontStyle.copyWith(
        fontSize: AppThemeUtil.fontSize(14.0),
        color: AppThemeUtil.getThemeColor(kPrimaryBlack),
      ),
      searchInputDecoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        isDense: true,
        hintStyle: kRegularFontStyle.copyWith(
          fontSize: AppThemeUtil.fontSize(14.0),
          color: AppThemeUtil.getThemeColor(kGrey500),
        ),
        errorStyle: kRegularFontStyle.copyWith(
          fontSize: AppThemeUtil.fontSize(12.0),
          color: AppThemeUtil.getThemeColor(kError700),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppThemeUtil.width(16.0),
          vertical: AppThemeUtil.height(16.0),
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
      suggestionsDecoration: SuggestionDecoration(
        padding: const EdgeInsets.all(4),
        border: Border.all(color: kError700),
        borderRadius: BorderRadius.circular(AppThemeUtil.radius(16.0)),
      ),
      onSuggestionTap: onSuggestionTap,
      emptyWidget: Container(
        decoration: BoxDecoration(
          border: Border.all(color: kError700),
          borderRadius: BorderRadius.circular(AppThemeUtil.radius(16.0)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Searching location....').semiBold().color(kPrimaryBlack)
                .fontSize(16.0).alignText(TextAlign.center),
            const VSpace(height: 4.0),
            const Text('No location found yet').regular().color(kPrimaryBlack)
                .fontSize(12.0).alignText(TextAlign.center),
          ],
        ).paddingSymmetric(vertical: 32, horizontal: 16.0),
      ),
      itemHeight: AppThemeUtil.height(58.0),
      offset: offset ?? const Offset(0.0, 55.0),
      scrollbarDecoration: ScrollbarDecoration(thickness: 3.0),
      suggestionItemDecoration: BoxDecoration(
          border: Border.all(color: Colors.transparent)
      ),
    );
  }
}
