import 'package:aider_mobile_app/core/extensions/date_extension.dart';
import 'package:aider_mobile_app/core/extensions/string_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/flexible_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/core/utils/app_dialog_util.dart';
import 'package:aider_mobile_app/core/utils/helper_util.dart';
import 'package:aider_mobile_app/src/features/product/domain/models/product_price/product_price_model.dart';
import 'package:aider_mobile_app/src/shared_widgets/cards/app_card.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/v_space.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/constants/common.dart';
import '../../../../../../core/utils/app_theme_util.dart';
import '../../../../../shared_widgets/buttons/app_primary_button.dart';
import '../../../../../shared_widgets/common/app_bottom_nav_wrapper.dart';
import '../../../../../shared_widgets/common/h_space.dart';
import '../../../../rentals/domain/models/booked_product/booked_product_model.dart';
import '../../../../rentals/domain/models/booking/booking_model.dart';
import '../../../domain/models/product/product_model.dart';
import '../../providers/product_provider.dart';

class RentingSummaryModalContent extends StatefulWidget {
  const RentingSummaryModalContent({
    super.key,
    required this.pageController,
    required this.product,
  });

  final PageController pageController;
  final ProductModel product;

  @override
  State<RentingSummaryModalContent> createState() =>
      _RentingSummaryModalContentState();
}

class _RentingSummaryModalContentState
    extends State<RentingSummaryModalContent> {
  final _quantity = ValueNotifier<int>(1);
  int _duration = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final productProvider = context.read<ProductProvider>();
      _quantity.value = productProvider.getQuantity;
      if (productProvider.getDates['startDate'] ==
          productProvider.getDates['endDate']) {
        _duration = 1;
      } else {
        _duration = HelperUtil.getDuration(
            productProvider.getDates['startDate'],
            productProvider.getDates['endDate']);
      }
      // _duration = HelperUtil.getDuration(productProvider.getDates['startDate'], productProvider.getDates['endDate']);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final productProvider = context.read<ProductProvider>();
    return Scaffold(
      body: ListView(
        children: [
          AppCard(
            backgroundColor: kGrey50,
            width: double.infinity,
            padding: EdgeInsets.all(AppThemeUtil.radius(20.0)),
            decoration: BoxDecoration(
              border: Border.all(color: kGrey200),
              borderRadius: BorderRadius.circular(AppThemeUtil.radius(12.0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('SELECTED DATE')
                    .bold()
                    .fontSize(12.0)
                    .color(kGrey700),
                const VSpace(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_duration == 1 ? '$_duration Day' : '$_duration Days')
                        .medium()
                        .fontSize(14.0)
                        .color(kGrey800),
                    Text('${(productProvider.getDates['startDate'] as DateTime).format('MMM d')} - ${(productProvider.getDates['endDate'] as DateTime).format('MMM d')}')
                        .bold()
                        .fontSize(14.0)
                        .color(kGrey700),
                  ],
                ),
                const VSpace(height: 12.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: AppPrimaryButton(
                    text: 'Change',
                    onPressed: () {
                      widget.pageController.animateToPage(
                        0,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.ease,
                      );
                    },
                    minWidth: 69,
                    height: 28,
                    fontSize: 14.0,
                    textColor: kError700,
                    color: kError100,
                    borderColor: kError100,
                  ),
                )
              ],
            ),
          ),
          const VSpace(height: 12.0),
          AppCard(
            backgroundColor: kGrey50,
            width: double.infinity,
            padding: EdgeInsets.all(AppThemeUtil.radius(20.0)),
            decoration: BoxDecoration(
              border: Border.all(color: kGrey200),
              borderRadius: BorderRadius.circular(AppThemeUtil.radius(12.0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Location of exchange')
                    .bold()
                    .fontSize(12.0)
                    .color(kGrey700),
                const VSpace(height: 12.0),
                Text("${productProvider.getLocation['originName']}")
                    .semiBold()
                    .fontSize(14.0)
                    .color(kGrey1200),
                const VSpace(height: 20.0),
                const Text('Time of exchange')
                    .bold()
                    .fontSize(12.0)
                    .color(kGrey700),
                const VSpace(height: 12.0),
                Text("${productProvider.getTimeOfExchange}")
                    .semiBold()
                    .fontSize(14.0)
                    .color(kGrey1200),
                const VSpace(height: 12.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: AppPrimaryButton(
                    text: 'Change',
                    onPressed: () {
                      widget.pageController.animateToPage(
                        1,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.ease,
                      );
                    },
                    minWidth: 69,
                    height: 28,
                    fontSize: 14.0,
                    textColor: kError700,
                    color: kError100,
                    borderColor: kError100,
                  ),
                )
              ],
            ),
          ),
          const VSpace(height: 12.0),
          AppCard(
            backgroundColor: kGrey50,
            width: double.infinity,
            padding: EdgeInsets.all(AppThemeUtil.radius(20.0)),
            decoration: BoxDecoration(
              border: Border.all(color: kGrey200),
              borderRadius: BorderRadius.circular(AppThemeUtil.radius(12.0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('PRICE DETAILS')
                    .bold()
                    .fontSize(12.0)
                    .color(kGrey700),
                const VSpace(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('$kCurrency ${HelperUtil.getDurationPrice(product.prices ?? [], _duration).toString().toCurrencyFormat} x ${_duration == 1 ? '$_duration Day' : '$_duration Days'}')
                        .medium()
                        .fontSize(14.0)
                        .color(kGrey800),
                    Text('$kCurrency ${HelperUtil.getTotalDurationPrice(product.prices ?? [], _duration).toString().toCurrencyFormat}')
                        .bold()
                        .fontSize(16.0)
                        .color(kGrey1200),
                  ],
                ),
                const VSpace(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('SERVICE FEE')
                        .bold()
                        .fontSize(12.0)
                        .color(kGrey700),
                    Text('$kCurrency ${calculateTenPercent(HelperUtil.getTotalDurationPrice(product.prices ?? [], _duration).toString())}')
                        .bold()
                        .fontSize(16.0)
                        .color(kGrey1200),
                  ],
                ),
              ],
            ),
          ),
          const VSpace(height: 12.0),
          AppCard(
            backgroundColor: kGrey50,
            width: double.infinity,
            padding: EdgeInsets.all(AppThemeUtil.radius(20.0)),
            decoration: BoxDecoration(
              border: Border.all(color: kGrey200),
              borderRadius: BorderRadius.circular(AppThemeUtil.radius(12.0)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('TOTAL').medium().fontSize(12.0).color(kGrey800),
                Text('$kCurrency ${calculateTotalWithTenPercent(HelperUtil.getTotalDurationPrice(product.prices ?? [], _duration).toString().toCurrencyFormat, calculateTenPercent(HelperUtil.getTotalDurationPrice(product.prices ?? [], _duration).toString()))}')
                    .bold()
                    .fontSize(16.0)
                    .color(kGrey1200),
              ],
            ),
          ),
          const VSpace(height: 28.0),
          const Text(
                  'We recommend checking availability of multiple options or owners to maximise the chance of finding an item that suits your dates and pickup.')
              .regular()
              .fontSize(14.0)
              .color(kGrey500),
        ],
      ).paddingSymmetric(horizontal: kWidthPadding),
      bottomNavigationBar: AppBottomNavWrapper(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppPrimaryButton(
              onPressed: () {
                widget.pageController.animateToPage(
                  1,
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
              onPressed: () async {
                if (_quantity.value <= 0) {
                  AppDialogUtil.showWarningAlert(context, 'Select quantity');
                  return;
                }

                final booking = BookingModel(
                  bookedProduct: BookedProductModel(
                    quantity: productProvider.getQuantity,
                    startDate:
                        (productProvider.getDates['startDate'] as DateTime)
                            .format('y-MM-dd'),
                    endDate: (productProvider.getDates['endDate'] as DateTime)
                        .format('y-MM-dd'),
                  ),
                );

                await productProvider.requestForItem(context, widget.product,
                    booking: booking);
              },
              text: 'Submit request',
              fontSize: 14.0,
              height: 52,
              radius: 8.0,
            ).flexible(),
          ],
        ),
      ),
    );
  }

  String tenPercent(String value) {
    // Remove any commas or other non-numeric characters
    final sanitizedValue = value.replaceAll(RegExp(r'[^\d.]'), '');
    final numericValue = double.parse(sanitizedValue);
    final result = (10 / 100) * numericValue;
    return result.toString().toCurrencyFormat;
  }

  double calculateTotalTenPercent(
      List<ProductPriceModel> prices, int duration) {
    double totalTenPercent = 0.0;

    // Iterate over each day within the given duration
    for (int day = 1; day <= duration; day++) {
      // Find the applicable price for the current day
      final priceForDay = prices.firstWhere(
        (price) =>
            day >= (price.startDay ?? 0) &&
            (price.endDay == null || day <= price.endDay!),
        orElse: () => const ProductPriceModel(price: 0.0),
      );

      // Calculate 10% of the price for the current day and add to the total
      totalTenPercent += 0.10 * (priceForDay.price ?? 0.0);
    }

    return totalTenPercent;
  }

  String calculateTenPercent(String totalAmount) {
    // Convert the string to a double
    final doubleAmount = double.tryParse(totalAmount) ?? 0.0;

    // Calculate 10% of the amount
    final tenPercent = doubleAmount * 0.10;

    // Return the result as a string
    return tenPercent.toString().toCurrencyFormat;
  }

  String calculateTotalWithTenPercent(
      String totalDurationPrice, String tenPercentValue) {
    final sanitizedDurationPriceValue =
        totalDurationPrice.replaceAll(RegExp(r'[^\d.]'), '');
    final sanitizedPercentValue =
        tenPercentValue.replaceAll(RegExp(r'[^\d.]'), '');

    double totalDurationPriceDouble = double.parse(sanitizedDurationPriceValue);
    double tenPercentValueDouble = double.parse(sanitizedPercentValue);

    double total = totalDurationPriceDouble + tenPercentValueDouble;

    return total.toString().toCurrencyFormat;
  }
}
