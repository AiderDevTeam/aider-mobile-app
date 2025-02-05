import 'package:aider_mobile_app/core/constants/colors.dart';
import 'package:aider_mobile_app/core/extensions/widgets/center_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/core/routing/app_navigator.dart';
import 'package:aider_mobile_app/core/utils/app_theme_util.dart';
import 'package:aider_mobile_app/src/features/rentals/presentation/widgets/rating_stars_widget.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/app_bottom_nav_wrapper.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/v_space.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/common.dart';
import '../../../../../core/utils/app_dialog_util.dart';
import '../../../../shared_widgets/base/draggable_bottom_sheet.dart';
import '../../../../shared_widgets/buttons/app_primary_button.dart';
import '../../../../shared_widgets/common/row_text.dart';
import '../../../../shared_widgets/forms/app_input_field.dart';
import '../../../../shared_widgets/modals/draggable_bottom_sheet_content.dart';
import '../../domain/models/booking/booking_model.dart';
import '../providers/rental_provider.dart';

class RateAndReviewModal extends StatefulWidget {
  const RateAndReviewModal({
    super.key,
    required this.booking,
    required this.type,
  });
  final BookingModel booking;
  final String type;

  @override
  State<RateAndReviewModal> createState() => _RateAndReviewModalState();
}

class _RateAndReviewModalState extends State<RateAndReviewModal> {
  int rating = 0;
  final productReviewController = TextEditingController();

  @override
  void dispose() {
    productReviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableBottomSheet(
      initialChildSize: 0.72,
      minChildSize: 0.45,
      maxChildSize: 0.78,
      builder: (context, scrollController) {
        return DraggableBottomSheetContent(
          draggableKey: GlobalKey(),
          scrollController: scrollController,
          bottomNavigationBar: AppBottomNavWrapper(
            child: AppPrimaryButton(
              onPressed: () async {
                if (rating == 0) {
                  AppDialogUtil.showWarningAlert(context, 'Rate this product');
                  return;
                }

                await context.read<RentalProvider>().createProductReviews(
                  context,
                  type: widget.type,
                  bookingUid: widget.booking.uid ?? '',
                  requestBody: {
                    "type": widget.type,
                    "rating": rating,
                    "comment": productReviewController.text,
                    'vendorUid': widget.booking.vendorUid,
                    'renterUid': widget.booking.userUid,
                  },
                );
              },
              text: 'Submit',
              height: 56,
            ),
          ),
          modalHeaderContent: RowText(
            leftWidget: const Text('Rate and Review')
                .bold()
                .fontSize(20)
                .color(kPrimaryBlack)
                .height(24, 20),
            rightWidget: IconButton(
              onPressed: () {
                AppNavigator.pop(context);
              },
              icon: Icon(
                Icons.close,
                size: AppThemeUtil.radius(24),
              ),
            ),
          ).paddingOnly(left: kWidthPadding, right: kWidthPadding, bottom: 10),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RowText(
                  leftWidget: const Text(
                    'Rate',
                  )
                      .bold()
                      .fontSize(14)
                      .color(kPrimaryBlack)
                      .letterSpacing(-0.15)
                      .height(0.11, 14),
                ),
                const VSpace(height: 8),
                RatingStarsWidget(
                  onRatingUpdate: (value) {
                    rating = value.toInt();
                  },
                ).toCenter(),
                const VSpace(height: 20),
                RowText(
                  leftWidget: const Text(
                    'Review',
                  )
                      .bold()
                      .fontSize(14)
                      .color(kPrimaryBlack)
                      .letterSpacing(-0.15)
                      .height(0.11, 14),
                ),
                const VSpace(height: 8),
                AppInputField(
                  controller: productReviewController,
                  maxLine: 5,
                ),
              ],
            ),
          ).paddingOnly(top: 20, left: kWidthPadding, right: kWidthPadding),
        );
      },
    );
  }
}
