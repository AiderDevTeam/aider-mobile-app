
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/text_style.dart';
import '../../../../../core/utils/app_theme_util.dart';

class RentingCalendar extends StatelessWidget {
  const RentingCalendar({
    super.key,
    required this.onSelectionChanged,
    this.enablePastDates = false,
    this.initialSelectedDate,
    this.maxDate,
    this.dateRangePickerView = DateRangePickerView.month,
    this.allowViewNavigation = true,
    this.datePickerController,
    this.onViewChanged,
    this.todayCellDecoration,
    this.blackoutDates,
  });

  final void Function(DateRangePickerSelectionChangedArgs)? onSelectionChanged;
  final bool enablePastDates;
  final DateTime? initialSelectedDate;
  final DateTime? maxDate;
  final DateRangePickerView dateRangePickerView;
  final bool allowViewNavigation;
  final DateRangePickerController? datePickerController;
  final void Function(DateRangePickerViewChangedArgs)? onViewChanged;
  final Decoration? todayCellDecoration;
  final List<DateTime>? blackoutDates;


  @override
  Widget build(BuildContext context) {
    return SfDateRangePicker(
      controller: datePickerController,
      allowViewNavigation: allowViewNavigation,
      enablePastDates: enablePastDates,
      initialSelectedDate: initialSelectedDate,
      onSelectionChanged: onSelectionChanged,
      selectionMode: DateRangePickerSelectionMode.range,
      showNavigationArrow: true,
      selectionRadius: 20,
      selectionShape: DateRangePickerSelectionShape.circle,
      minDate: DateTime(2024, 01, 1),
      maxDate: maxDate,
      selectionTextStyle: kMediumFontStyle.copyWith(
        fontSize: AppThemeUtil.fontSize(14.0),
        color: AppThemeUtil.getThemeColor(kPrimaryWhite),
      ),
      startRangeSelectionColor: kAider700,
      endRangeSelectionColor: kAider700,
      headerStyle: DateRangePickerHeaderStyle(
        textAlign: TextAlign.center,
        textStyle: kSemiBoldFontStyle.copyWith(
          fontSize: AppThemeUtil.fontSize(14.0),
          color: AppThemeUtil.getThemeColor(kPrimaryBlack),
        ),
      ),
      view: dateRangePickerView,
      onViewChanged: onViewChanged,
      yearCellStyle: DateRangePickerYearCellStyle(
        cellDecoration: BoxDecoration(
          color: AppThemeUtil.getThemeColor(kPrimaryWhite),
          shape: BoxShape.circle,
        ),
        textStyle: kSemiBoldFontStyle.copyWith(
          fontSize: AppThemeUtil.fontSize(14.0),
          color: AppThemeUtil.getThemeColor(kPrimaryBlack),
        ),
        todayCellDecoration: todayCellDecoration?? BoxDecoration(
          color: AppThemeUtil.getThemeColor(kAider700),
          border: Border.all(color: AppThemeUtil.getThemeColor(kAider700)),
          shape: BoxShape.circle,
        ),
        todayTextStyle: kMediumFontStyle.copyWith(
          fontSize: AppThemeUtil.fontSize(14.0),
          color: AppThemeUtil.getThemeColor(kPrimaryWhite),
        ),
      ),
      monthViewSettings: DateRangePickerMonthViewSettings(
        showTrailingAndLeadingDates: true,
        blackoutDates: blackoutDates,
        dayFormat: 'EEE',
        viewHeaderStyle: DateRangePickerViewHeaderStyle(
          textStyle: kSemiBoldFontStyle.copyWith(
            fontSize: AppThemeUtil.fontSize(12.0),
            color: AppThemeUtil.getThemeColor(kPrimaryBlack),
            letterSpacing: -0.3,
          ),
        ),
      ),
      monthCellStyle: DateRangePickerMonthCellStyle(
        leadingDatesTextStyle: kRegularFontStyle.copyWith(
          fontSize: AppThemeUtil.fontSize(14.0),
          color: AppThemeUtil.getThemeColor(kBlack70),
        ),
        trailingDatesTextStyle: kRegularFontStyle.copyWith(
          fontSize: AppThemeUtil.fontSize(14.0),
          color: AppThemeUtil.getThemeColor(kGrey300),
        ),
        todayTextStyle: kMediumFontStyle.copyWith(
          fontSize: AppThemeUtil.fontSize(14.0),
          color: AppThemeUtil.getThemeColor(kGrey1200),
        ),
        textStyle: kRegularFontStyle.copyWith(
          fontSize: AppThemeUtil.fontSize(14.0),
          color: AppThemeUtil.getThemeColor(kPrimaryBlack),
        ),
        todayCellDecoration: todayCellDecoration?? BoxDecoration(
          color: AppThemeUtil.getThemeColor(kPrimaryWhite),
          border: Border.all(color: AppThemeUtil.getThemeColor(kAider700)),
          shape: BoxShape.circle,
        ),
        blackoutDateTextStyle: kRegularFontStyle.copyWith(
          fontSize: AppThemeUtil.fontSize(14.0),
          color: AppThemeUtil.getThemeColor(kGrey300),
        ),
        blackoutDatesDecoration: BoxDecoration(
          color: AppThemeUtil.getThemeColor(kGrey200),
          border: Border.all(color: AppThemeUtil.getThemeColor(kGrey50)),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}