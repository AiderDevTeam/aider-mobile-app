import 'package:aider_mobile_app/core/constants/colors.dart';
import 'package:aider_mobile_app/core/constants/common.dart';
import 'package:aider_mobile_app/core/extensions/string_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/center_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/expanded_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/flexible_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/core/routing/app_navigator.dart';
import 'package:aider_mobile_app/core/utils/app_theme_util.dart';
import 'package:aider_mobile_app/src/features/rentals/presentation/view_model/rental_view_model.dart';
import 'package:aider_mobile_app/src/features/rentals/presentation/widgets/rate_review_modal.dart';
import 'package:aider_mobile_app/src/features/rentals/presentation/widgets/report_modal.dart';
import 'package:aider_mobile_app/src/shared_widgets/buttons/app_primary_button.dart';
import 'package:aider_mobile_app/src/shared_widgets/cards/app_card.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/h_space.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/row_text.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/v_space.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/utils/app_dialog_util.dart';
import '../../../../shared_widgets/buttons/app_text_button.dart';
import '../../../../shared_widgets/common/network_image_view.dart';
import '../../../../shared_widgets/common/svg_icon.dart';
import '../../../../shared_widgets/modals/question_bottom_sheet_modal_content.dart';
import '../../../inbox/presentation/view_models/inbox_view_model.dart';
import 'confirm_pickup_modal.dart';
import '../../domain/models/booking/booking_model.dart';
import 'days_remaining_card.dart';

class RentedItemCard extends StatefulWidget {
  const RentedItemCard({
    super.key, required
    this.rentalProduct,
    this.isVendor = false,
    this.isBookingPaid = false,
    this.messageExternalId,
  });
  final BookingModel rentalProduct;
  final bool isVendor;
  final bool isBookingPaid;
  final String? messageExternalId;

  @override
  State<RentedItemCard> createState() => _RentedItemCardState();
}

class _RentedItemCardState extends State<RentedItemCard> {
  @override
  Widget build(BuildContext context) {
    final rentalProduct = widget.rentalProduct.bookedProduct;
    return AppCard(
      width: double.infinity,
      padding: EdgeInsets.all(
        AppThemeUtil.radius(12),
      ),
      decoration: ShapeDecoration(
        color: kPrimaryWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppThemeUtil.radius(20)),
        ),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            rentalProduct?.product?.hasPhotos == true
                ? NetworkImageView(
                    imageUrl: rentalProduct?.product?.firstPhoto ?? '',
                    height: AppThemeUtil.height(90.0),
                    width: AppThemeUtil.height(90.0),
                    borderRadius: BorderRadius.circular(AppThemeUtil.radius(12.0)),
                  )
                : SizedBox(
                    height: AppThemeUtil.height(90.0),
                    width: AppThemeUtil.height(90.0),
                  ),
            const HSpace(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  rentalProduct?.product?.name ?? '',
                ).semiBold().fontSize(14).color(kGrey1200),
                const VSpace(height: 30),
                RowText(
                  leftWidget: const Text(
                    'Total Cost',
                  ).semiBold().fontSize(12).color(kGrey700),
                  rightWidget: Text(
                    '$kCurrency ${(widget.rentalProduct.collectionAmount).toString().toCurrencyFormat}',
                  ).bold().fontSize(14).color(kPrimaryBlack),
                )
              ],
            ).expanded(),
          ],
        ),
        const VSpace(height: 12),
        Container(
          width: double.infinity,
          height: AppThemeUtil.height(270),
          padding: const EdgeInsets.all(12),
          decoration: ShapeDecoration(
            color: kGrey50,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Rent Duration',
              ).semiBold().fontSize(14).color(kGrey800),
              const VSpace(height: 8),
              Text(
                '${rentalProduct?.getDuration ?? ''} (${rentalProduct?.getStartDate} → ${rentalProduct?.getEndDate})',
              ).bold().fontSize(14).color(kGrey1200),
              const VSpace(height: 16),
              const Text(
                'Rental ID',
              ).semiBold().fontSize(14).color(kGrey800),
              const VSpace(height: 8),
              Text(
                '${widget.rentalProduct.bookingNumber}',
              ).bold().fontSize(14).color(kGrey1200),
              const VSpace(height: 16),
              const Text(
                'Location of exchange',
              ).semiBold().fontSize(14).color(kGrey800),
              const VSpace(height: 8),
              Text(
                rentalProduct?.exchangeSchedule?.originName ?? '',
              ).bold().fontSize(14).color(kGrey1200).flexible(),
              const VSpace(height: 16),
              const Text(
                'Time of exchange',
              ).semiBold().fontSize(14).color(kGrey800),
              const VSpace(height: 8),
              Text(
                rentalProduct?.exchangeSchedule?.timeOfExchange ?? '',
              ).bold().fontSize(14).color(kGrey1200).flexible(),
            ],
          ),
        ),
        const VSpace(height: 10),
        if (widget.rentalProduct.vendorPickupStatus == kPending && widget.rentalProduct.userPickupStatus != kPending) ...[
          const AppPrimaryButton(
            text: "Waiting for vendor to confirm",
            minWidth: double.infinity,
            fontSize: 14,
            height: 40,
            onPressed: null,
          ),
        ],
        if (widget.rentalProduct.userPickupStatus == kPending && widget.isBookingPaid) ...[
          AppPrimaryButton(
            text: "Proceed to Confirm Pickup",
            minWidth: double.infinity,
            fontSize: 14,
            height: 40,
            onPressed: () {
              AppDialogUtil.showScrollableBottomSheet(
                context: context,
                builder: (context) => ConfirmPickupModal(
                  title: 'Are you sure you’ve picked up\nthe right item?',
                  onYesPressed: () async {
                    AppNavigator.of(context);
                    await context.read<RentalViewModel>().confirmPickUp(
                      context,
                      type: 'user',
                      bookingExternalId: widget.rentalProduct.externalId ?? '',
                      scaffoldKey: GlobalKey<ScaffoldState>(),
                      requestBody: {"status": "success", "type": "user"},
                    );
                  },
                ),
              );
            },
          )
        ],
        if (widget.rentalProduct.userPickupStatus == kPending &&
            widget.rentalProduct.vendorPickupStatus == kPending &&
            (
              widget.rentalProduct.bookingAcceptanceStatus != kBookingCanceledStatus 
            &&
             widget.rentalProduct.bookingAcceptanceStatus != kBookingRejectedStatus
            )
            ) ...[
              const VSpace(height: 10),
          AppPrimaryButton(
            text: 'Cancel request',
            onPressed: () async {
              AppDialogUtil.showScrollableBottomSheet(
                context: context,
                builder: (context) => QuestionBottomSheetContent(
                  title: 'Are you sure you want to\ncancel your request?',
                  image: 'error.png',
                  yesButtonText: 'Yes, cancel',
                  noButtonText: 'No, I don\'t',
                  buttonReversed: true,
                  onYesPressed: () {
                    context.read<InboxViewModel>().approveBookingRequest(
                      context,
                      messageExternalId: widget.messageExternalId,
                      bookingExternalId: widget.rentalProduct.externalId ?? '',
                      requestBody: {
                        "status": "canceled",
                      },
                    );
                    // AppNavigator.pop(context);
                  },
                ),
              );
            },
            height: 40,
            minWidth: double.infinity,
            fontSize: 14,
            textColor: kError700,
            borderColor: kError700,
            color: kPrimaryWhite,
          ),
        ],
        if (widget.rentalProduct.vendorPickupStatus == kSuccessStatus &&
            widget.rentalProduct.userPickupStatus == kSuccessStatus &&
            rentalProduct?.isOverdue == false &&
            rentalProduct?.returnedEarly == false) ...[
          DaysRemainingCard(
            overDue: '${rentalProduct?.daysSpan} days remaining',
            cardColor: const Color(0xFFFEF4E6),
            textColor: const Color(0xFFF79009),
          ),
          AppTextButton(
            text: 'Return Now',
            fontSize: 14,
            textColor: kError700,
            onPressed: () {
              AppDialogUtil.showScrollableBottomSheet(
                context: context,
                builder: (context) => ConfirmPickupModal(
                  title: 'Are you sure you want to return\nthis item ${rentalProduct?.daysSpan ?? ''} days early, there will be no\nrefunds',
                  onYesPressed: () async {
                    await context.read<RentalViewModel>().earlyReturn(
                          context,
                          bookedProductExternalId: rentalProduct?.externalId ?? '',
                        );
                  },
                ),
              );
            },
          ).toCenter(),
        ],
        if (widget.rentalProduct.vendorPickupStatus == kSuccessStatus &&
            widget.rentalProduct.userPickupStatus == kSuccessStatus &&
            rentalProduct?.isOverdue == true &&
            widget.rentalProduct.userDropOffStatus != kSuccessStatus &&
            rentalProduct?.returnedEarly == false) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppPrimaryButton(
                text: "Report",
                fontSize: 14,
                height: 36,
                color: kPrimaryWhite,
                textColor: kPrimaryBlack,
                onPressed: () {
                  AppDialogUtil.showScrollableBottomSheet(
                    isDismissible: true,
                    useSafeArea: false,
                    context: context,
                    builder: (context) {
                      return ReportModal(
                        booking: widget.rentalProduct,
                        isVendor: widget.isVendor,
                      );
                    },
                  );
                },
              ).flexible(),
              const HSpace(width: 10),
              AppPrimaryButton(
                text: "Confirm Return",
                fontSize: 14,
                height: 36,
                onPressed: () async {
                  AppDialogUtil.showScrollableBottomSheet(
                    context: context,
                    builder: (context) => ConfirmPickupModal(
                      title: 'Please ensure the item being returned\nis the right one that was rented',
                      onYesPressed: () async {
                        await context.read<RentalViewModel>().confirmDropOff(
                          context,
                          scaffoldKey: GlobalKey<ScaffoldState>(),
                          type: 'user',
                          bookingExternalId: widget.rentalProduct.externalId ?? '',
                          requestBody: {"status": "success", "type": "user"},
                        );
                      },
                    ),
                  );
                },
              ).flexible(),
            ],
          ),
          const VSpace(height: 18),
          (rentalProduct?.daysSpan == 0)
              ? const SizedBox.shrink()
              : Text(
                  rentalProduct?.daysSpan == 1 ? 'You’re ${rentalProduct?.daysSpan} day overdue' : 'You’re ${rentalProduct?.daysSpan} days overdue',
                ).semiBold().fontSize(14).color(kError700).toCenter(),
          // Text('You’re ${rentalProduct?.daysSpan} days overdue',
          // ).semiBold().fontSize(14).color(kError700).toCenter()
        ],
        if (widget.rentalProduct.vendorPickupStatus == kSuccessStatus &&
            widget.rentalProduct.userPickupStatus == kSuccessStatus &&
            rentalProduct?.returnedEarly == true &&
            rentalProduct?.isOverdue == false &&
            widget.rentalProduct.userDropOffStatus != kSuccessStatus) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppPrimaryButton(
                text: "Report",
                fontSize: 14,
                height: 36,
                color: kPrimaryWhite,
                textColor: kPrimaryBlack,
                onPressed: () {
                  AppDialogUtil.showScrollableBottomSheet(
                    context: context,
                    builder: (context) {
                      return ReportModal(
                        booking: widget.rentalProduct,
                        isVendor: false,
                      );
                    },
                  );
                },
              ).flexible(),
              const HSpace(width: 10),
              AppPrimaryButton(
                text: "Confirm Return",
                fontSize: 14,
                height: 36,
                onPressed: () async {
                  AppDialogUtil.showScrollableBottomSheet(
                    useSafeArea: true,
                    context: context,
                    builder: (context) => ConfirmPickupModal(
                      title: 'Please ensure the item being returned\nis the right one that was rented',
                      onYesPressed: () async {
                        await context.read<RentalViewModel>().confirmDropOff(
                          context,
                          scaffoldKey: GlobalKey<ScaffoldState>(),
                          type: 'user',
                          bookingExternalId: widget.rentalProduct.externalId ?? '',
                          requestBody: {"status": "success", "type": "user"},
                        );
                      },
                    ),
                  );
                },
              ).flexible(),
            ],
          ),
        ],
        if (widget.rentalProduct.userDropOffStatus == kSuccessStatus) ...[
          if (rentalProduct?.isReviewed == true) ...[
            AppCard(
              width: double.infinity,
              padding: EdgeInsets.all(AppThemeUtil.radius(12)),
              decoration: ShapeDecoration(
                color: kGrey50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppThemeUtil.radius(12)),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Wrap(
                        runSpacing: 12.0,
                        children: List.generate(rentalProduct?.review?.rating ?? 0, (index) {
                          return ZSvgIcon(
                            'star.svg',
                            color: kWarning700,
                            size: AppThemeUtil.radius(14.0),
                          );
                        }),
                      ),
                      Text(
                        rentalProduct?.review?.date ?? '',
                      ).regular().fontSize(12).color(kGrey700).alignText(TextAlign.right),
                    ],
                  ),
                  const VSpace(height: 12),
                  Text(
                    rentalProduct?.review?.comment ?? '',
                  ).regular().fontSize(14).color(kGrey1200),
                ],
              ),
            ),
            const VSpace(height: 10),
          ],
          (rentalProduct?.isReviewed == true)
              ? const SizedBox.shrink()
              : AppPrimaryButton(
                  text: "Rate and review",
                  fontSize: 14,
                  height: 40,
                  minWidth: double.infinity,
                  borderColor: kGrey700,
                  color: kPrimaryWhite,
                  textColor: kGrey1000,
                  onPressed: () async {
                    AppDialogUtil.showScrollableBottomSheet(
                      context: context,
                      builder: (context) => RateAndReviewModal(
                        type: "product",
                        bookingProductExternalId: rentalProduct?.externalId ?? '',
                      ),
                    );
                  },
                )
        ],
        if (widget.rentalProduct.userHasReported) Center(child: const Text("You reported this vendor").semiBold().fontSize(14).color(kGrey800))
      ]),
    ).paddingOnly(bottom: kWidthPadding);
  }
}
