import 'package:aider_mobile_app/core/extensions/widgets/flexible_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/gesture_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/core/utils/app_dialog_util.dart';
import 'package:aider_mobile_app/core/utils/helper_util.dart';
import 'package:aider_mobile_app/src/shared_widgets/cards/app_card.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/svg_icon.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/v_space.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/constants/common.dart';
import '../../../../../../core/utils/app_theme_util.dart';
import '../../../../../shared_widgets/buttons/app_primary_button.dart';
import '../../../../../shared_widgets/common/app_bottom_nav_wrapper.dart';
import '../../../../../shared_widgets/common/h_space.dart';
import '../../../../../shared_widgets/forms/app_input_field.dart';
import '../../../../../shared_widgets/modals/location_modal.dart';
import '../../../domain/models/product/product_model.dart';
import '../../view_models/product_view_model.dart';

class RentingTimeAndLocationModalContent extends StatefulWidget {
  const RentingTimeAndLocationModalContent({
    super.key,
    required this.pageController,
    required this.product,
  });

  final PageController pageController;
  final ProductModel product;

  @override
  State<RentingTimeAndLocationModalContent> createState() => _RentingTimeAndLocationModalContentState();
}

class _RentingTimeAndLocationModalContentState extends State<RentingTimeAndLocationModalContent> {
  final formKey = GlobalKey<FormState>();
  final _quantity = ValueNotifier<int>(1);
  final locationController = TextEditingController();
  final timeController = TextEditingController();
  final location = ValueNotifier<Map<String, dynamic>?>(null);
  String period = '';
  String hour = "1";
  String minute = "00";


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(!mounted) return;
      final productProvider = context.read<ProductViewModel>();
      _quantity.value = productProvider.getQuantity;
    });
    super.initState();
  }

  @override
  void dispose() {
    locationController.dispose();
    timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;


    return Scaffold(
      body: ListView(
        children: [
          const Text('Item Quantity').semiBold().fontSize(14.0).color(kPrimaryBlack),
          const VSpace(height: 8.0),
          AppCard(
            padding: EdgeInsets.symmetric(
              horizontal: AppThemeUtil.width(16.0),
              vertical: AppThemeUtil.height(8.0),
            ),
            decoration: BoxDecoration(
              border: Border.all(color: kGrey200),
              borderRadius: BorderRadius.circular(AppThemeUtil.radius(12.0)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppCard(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(AppThemeUtil.radius(8.0)),
                  child: ZSvgIcon(
                    'minus.svg',
                    size: AppThemeUtil.radius(20.0),
                    color: kGrey600,
                  ),
                ).onPressed((){
                  if(_quantity.value == 1) return;
                  _quantity.value -= 1;
                  context.read<ProductViewModel>().setQuantity = _quantity.value;
                }),
                ValueListenableBuilder<int>(
                    valueListenable: _quantity,
                    builder: (context, quantity, child) {
                      return AppCard(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(AppThemeUtil.radius(8.0)),
                        child: Text(quantity.toString()).medium().fontSize(14).color(kGrey1200),
                      );
                    }
                ),
                AppCard(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(AppThemeUtil.radius(8.0)),
                  child: Icon(
                    Icons.add,
                    size: AppThemeUtil.radius(20.0),
                    color: kGrey1200,
                  ),
                ).onPressed((){
                  if(_quantity.value >= (product.quantity?? 0)) return;
                  _quantity.value += 1;
                  context.read<ProductViewModel>().setQuantity = _quantity.value;
                }),
              ],
            ),
          ),
          const VSpace(height: 24),
          const Text('Location of exchange').semiBold().fontSize(14.0).color(kPrimaryBlack),
          const VSpace(height: 8.0),
          Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppInputField(
                  controller: locationController,
                  hintText: 'Search location',
                  readOnly: true,
                  validator: (value){
                    if(value!.isEmpty) return 'Select exchange location';
                    return null;
                  },
                  onTap: () async{
                    final result = await AppDialogUtil.showScrollableBottomSheet(
                      context: context,
                      builder: (context) => const LocationModal(),
                    );
                    if(result != null){
                      locationController.text = result['originName']?? '';
                      if(!context.mounted) return;
                      location.value = result;
                      context.read<ProductViewModel>().setPlaceId = result['placeId']?? '';

                      context.read<ProductViewModel>().setLocation = {
                        "originName": result['originName'],
                        "country":"nigeria",
                        "countryCode":"ng",
                        "city": result['city'],
                      };
                    }
                  },
                  suffixIcon: ZSvgIcon(
                    'map_pin.svg',
                    size: AppThemeUtil.radius(20.0),
                  ).paddingAll(16.0),
                  helperHeight: 0.1,
                ),
                AppCard(
                    width: double.infinity,
                    padding: EdgeInsets.all(AppThemeUtil.radius(14)),
                    decoration: ShapeDecoration(
                      color: kBlue100,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.info, color: kBlue800,),
                        const HSpace(width: 10),
                        const Text("Location where you would like to receive the item").regular().fontSize(14).color(kGrey800).flexible(),
                      ],
                    )
                ),
                const VSpace(height: 24),
                const Text('Time of exchange').semiBold().fontSize(14.0).color(kPrimaryBlack),
                const VSpace(height: 8.0),

                AppInputField(
                  controller: timeController,
                  hintText: 'Select time',
                  readOnly: true,
                  validator: (value){
                    if(value!.isEmpty) return 'Select time of exchange';
                    return null;
                  },
                  onTap: (){
                    _selectTime(context);
                  },
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                        decoration: BoxDecoration(
                          color: period == 'am' ? kGrey1200 : kGrey50,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(AppThemeUtil.radius(4)),
                            bottomLeft: Radius.circular(AppThemeUtil.radius(4)),
                          ),
                        ),
                        child: const Text(
                          'AM',
                        ).regular().fontSize(10).letterSpacing(-0.11).color(kGrey500).alignText(TextAlign.center),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppThemeUtil.width(6),
                          vertical: AppThemeUtil.height(4),
                        ),
                        decoration: BoxDecoration(color: period == 'pm' ? kGrey1200 : kGrey50,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(AppThemeUtil.radius(4)),
                            bottomRight: Radius.circular(AppThemeUtil.radius(4)),
                          ),
                        ),
                        child: const Text(
                          'PM',
                        ).regular().fontSize(10).letterSpacing(-0.11).color(kGrey500).alignText(TextAlign.center),
                      ),
                    ],
                  ).paddingOnly(right: 16),
                  helperHeight: 0.1,
                ),
                const VSpace(height: 8.0),
                AppCard(
                    width: double.infinity,
                    padding: EdgeInsets.all(AppThemeUtil.radius(14)),
                    decoration: ShapeDecoration(
                      color: kBlue100,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.info, color: kBlue800,),
                        const HSpace(width: 10),
                        const Text("Enter the best time you’d be available").regular().fontSize(14).color(kGrey800).flexible(),
                      ],
                    )
                ),
              ],
            ),
          ),

        ],
      ).paddingSymmetric(horizontal: kWidthPadding),

      bottomNavigationBar: AppBottomNavWrapper(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppPrimaryButton(
              onPressed: (){
                widget.pageController.animateToPage(
                  0,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.ease,
                );
              },
              text: 'Back',
              fontSize: 14.0,
              height: 52,
              radius: 8.0,
              textColor: kGrey1000,
              color: kPrimaryWhite,
              borderColor: kGrey700,
            ).flexible(),
            const HSpace(width: 12.0),
            AppPrimaryButton(
              onPressed: () async{
                if(_quantity.value <= 0){
                  AppDialogUtil.showWarningAlert(context, 'Select quantity');
                  return;
                }
                if(formKey.currentState!.validate()){
                  widget.pageController.animateToPage(
                    2,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.ease,
                  );
                }
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

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.input,
    );
    if (picked != null){
      setState(() {
        period = picked.period == DayPeriod.am ? 'am' : 'pm';
        timeController.text = '${HelperUtil.addZeroToSingleInteger(picked.hourOfPeriod == 0 ? 12 : picked.hourOfPeriod)}:${HelperUtil.addZeroToSingleInteger(picked.minute)}';
      });
      if(context.mounted) context.read<ProductViewModel>().setTimeOfExchange = "${timeController.text}$period";
    }
  }
}
