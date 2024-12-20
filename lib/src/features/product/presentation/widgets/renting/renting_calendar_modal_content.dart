import 'package:aider_mobile_app/core/extensions/date_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/expanded_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/flexible_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/core/utils/helper_util.dart';
import 'package:aider_mobile_app/src/features/product/presentation/view_models/product_view_model.dart';
import 'package:aider_mobile_app/src/shared_widgets/cards/app_card.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/svg_icon.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/v_space.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/constants/common.dart';
import '../../../../../../core/utils/app_dialog_util.dart';
import '../../../../../../core/utils/app_theme_util.dart';
import '../../../../../shared_widgets/buttons/app_primary_button.dart';
import '../../../../../shared_widgets/common/app_bottom_nav_wrapper.dart';
import '../../../../../shared_widgets/common/h_space.dart';
import '../../../domain/models/product/product_model.dart';
import '../renting_calendar.dart';

class RentingCalendarModalContent extends StatefulWidget {
  const RentingCalendarModalContent({
    super.key,
    required this.pageController,
    required this.product,
  });

  final PageController pageController;
  final ProductModel product;

  @override
  State<RentingCalendarModalContent> createState() => _RentingCalendarModalContentState();
}

class _RentingCalendarModalContentState extends State<RentingCalendarModalContent> {
  final _selectedDates = ValueNotifier<Map<String, dynamic>?>(null);
  final _calendarController = DateRangePickerController();
  int duration = 0;
  
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final dates = context.read<ProductViewModel>().getDates;
      _calendarController.selectedRange = PickerDateRange(dates['startDate'], dates['endDate']);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(color: kGrey50),
          borderRadius: BorderRadius.circular(AppThemeUtil.radius(12.0)),
        ),
        child: Column(
          children: [
            RentingCalendar(
              datePickerController: _calendarController,
              onSelectionChanged: (args){
                if(args.value != null){
                  _selectedDates.value = {
                    'startDate': args.value.startDate,
                    'endDate': args.value.endDate,
                  };
                  context.read<ProductViewModel>().setDates = _selectedDates.value?? {};
                }
              },
              blackoutDates: (widget.product.unavailableBookingDates?? []).map((obj) => DateTime.parse(obj.date?? '')).toList(),
            ).expanded(),
            const VSpace(height: 12.0),
            ValueListenableBuilder<Map<String, dynamic>?>(
              valueListenable: _selectedDates,
              builder: (context, selectedDateValues, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppCard(
                      borderRadius: 8.0,
                      border: Border.all(color: const Color(0xFFD0D5DD)),
                      padding: EdgeInsets.symmetric(
                        horizontal: AppThemeUtil.width(12.0),
                        vertical: AppThemeUtil.height(8.0),
                      ),
                      child: Text(selectedDateValues?['startDate'] == null? 'Apr 16, 2024' : ((selectedDateValues?['startDate']?? DateTime.now()) as DateTime).format('MMM dd, y')).fontSize(14.0).regular().color(selectedDateValues?['startDate'] == null? kPrimaryWhite : const Color(0xFF101828)).textScale(TextScaler.noScaling),
                    ).flexible(),
                    const HSpace(width: 8),
                    ZSvgIcon(
                      'minus.svg',
                      size: AppThemeUtil.radius(12.0),
                      color: kGrey1200,
                    ),
                    const HSpace(width: 8),
                    AppCard(
                      borderRadius: 8.0,
                      border: Border.all(color: const Color(0xFFD0D5DD)),
                      padding: EdgeInsets.symmetric(
                        horizontal: AppThemeUtil.width(12.0),
                        vertical: AppThemeUtil.height(8.0),
                      ),
                      child: Text(selectedDateValues?['endDate'] == null? 'Apr 16, 2024' : ((selectedDateValues?['endDate']?? DateTime.now()) as DateTime).format('MMM dd, y')).fontSize(14.0).regular().color(selectedDateValues?['endDate'] == null? kPrimaryWhite:const Color(0xFF101828)).textScale(TextScaler.noScaling),
                    ).flexible(),
                  ],
                );
              }
            ),
            const VSpace(height: 12.0),
          ],
        ).paddingSymmetric(horizontal: 24.0),
      ).paddingSymmetric(horizontal: kWidthPadding),
      bottomNavigationBar: AppBottomNavWrapper(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppPrimaryButton(
              onPressed: (){
                _calendarController.selectedRange = null;
                context.read<ProductViewModel>().removeDates();
                _selectedDates.value = null;
              },
              text: 'Clear dates',
              fontSize: 14.0,
              height: 52,
              radius: 8.0,
              textColor: kGrey1000,
              color: kPrimaryWhite,
              borderColor: kGrey700,
            ).flexible(),
            const HSpace(width: 12.0),
            AppPrimaryButton(
              onPressed: (){
                if(_selectedDates.value == null || _selectedDates.value?['startDate'] == null ||_selectedDates.value?['endDate'] == null){
                  AppDialogUtil.showWarningAlert(context, 'Select date range');
                  return;
                }
                // final duration = HelperUtil.getDuration(_selectedDates.value?['startDate'], _selectedDates.value?['endDate']);


                if (_selectedDates.value?['startDate'].isAtSameMomentAs(_selectedDates.value?['endDate'])) {
                  duration = 1;
                } else {
                  duration = HelperUtil.getDuration(_selectedDates.value?['startDate'], _selectedDates.value?['endDate']);  // Calculate duration
                }

                if(HelperUtil.getDurationPrice(widget.product.prices?? [], duration) == 0){
                  AppDialogUtil.showWarningAlert(context, 'No price found for selected date range');
                  return;
                }
                widget.pageController.animateToPage(
                  1,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.ease,
                );
              },
              text: 'Continue',
              fontSize: 14.0,
              height: 52,
              radius: 8.0,
            ).flexible(),
          ],
        ),
      ),
    );
  }
}
