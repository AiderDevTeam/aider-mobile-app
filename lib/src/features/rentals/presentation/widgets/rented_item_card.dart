import 'package:aider_mobile_app/core/constants/colors.dart';
import 'package:aider_mobile_app/core/constants/common.dart';
import 'package:aider_mobile_app/core/extensions/string_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/center_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/expanded_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/flexible_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/core/routing/app_navigator.dart';
import 'package:aider_mobile_app/core/services/logger_service.dart';
import 'package:aider_mobile_app/core/utils/app_theme_util.dart';
import 'package:aider_mobile_app/src/features/rentals/presentation/providers/rental_provider.dart';
import 'package:aider_mobile_app/src/features/rentals/presentation/widgets/rate_review_modal.dart';
import 'package:aider_mobile_app/src/features/rentals/presentation/widgets/report_modal.dart';
import 'package:aider_mobile_app/src/shared_widgets/buttons/app_primary_button.dart';
import 'package:aider_mobile_app/src/shared_widgets/cards/app_card.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/h_space.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/row_text.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/v_space.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/providers/base_view.dart';
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
    super.key,
    required this.booking,
    this.isVendor = false,
    this.isBookingPaid = false,
    this.messageExternalId,
  });
  final BookingModel booking;
  final bool isVendor;
  final bool isBookingPaid;
  final String? messageExternalId;

  @override
  State<RentedItemCard> createState() => _RentedItemCardState();
}

class _RentedItemCardState extends State<RentedItemCard> {
  @override
  void initState() {
    super.initState();

    // Only listen to booking if the rental is still in progress
    if (widget.booking.userDropOffStatus == BookingProgressStatus.notStarted ||
        widget.booking.vendorDropOffStatus ==
            BookingProgressStatus.notStarted) {
      ZLoggerService.logOnInfo(
          'Listening to booking: ${widget.booking.bookingNumber}');
      context
          .read<RentalProvider>()
          .listenToBooking(context, widget.booking, isChat: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<RentalProvider>(
      builder: (context, rentalConsumer, child) {
        ZLoggerService.logOnInfo(
            'Building rented item card ${rentalConsumer.bookingsMap[widget.booking.uid ?? '']}');
        final booking = rentalConsumer.bookingsMap[widget.booking.uid ?? ''] ??
            widget.booking;
        final rentalProduct = booking.bookedProduct;
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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                rentalProduct?.product?.hasPhotos == true
                    ? NetworkImageView(
                        imageUrl: rentalProduct?.product?.firstPhoto ?? '',
                        height: AppThemeUtil.height(90.0),
                        width: AppThemeUtil.height(90.0),
                        borderRadius:
                            BorderRadius.circular(AppThemeUtil.radius(12.0)),
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
                        '$kCurrency ${(booking.collectionAmount).toString().toCurrencyFormat}',
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
                    '${booking.bookingNumber}',
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
            if (booking.vendorPickupStatus ==
                    BookingProgressStatus.notStarted &&
                booking.userPickupStatus !=
                    BookingProgressStatus.notStarted) ...[
              const AppPrimaryButton(
                text: "Waiting for vendor to confirm",
                minWidth: double.infinity,
                fontSize: 14,
                height: 40,
                onPressed: null,
              ),
            ],
            if (booking.userPickupStatus == BookingProgressStatus.notStarted &&
                widget.isBookingPaid) ...[
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
                        await context.read<RentalProvider>().confirmPickUp(
                              context,
                              type: 'user',
                              bookingUid: booking.uid ?? '',
                              scaffoldKey: GlobalKey<ScaffoldState>(),
                            );
                      },
                    ),
                  );
                },
              )
            ],
            if (booking.userPickupStatus == BookingProgressStatus.notStarted &&
                booking.vendorPickupStatus ==
                    BookingProgressStatus.notStarted &&
                (booking.bookingAcceptanceStatus !=
                        BookingProgressStatus.cancelled &&
                    booking.bookingAcceptanceStatus !=
                        BookingProgressStatus.rejected)) ...[
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
                            booking: booking,
                            status: BookingProgressStatus.cancelled);
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
            if (booking.vendorPickupStatus == BookingProgressStatus.success &&
                booking.userPickupStatus == BookingProgressStatus.success &&
                rentalProduct?.isOverdue == false &&
                rentalProduct?.returnedEarly == false &&
                booking.userDropOffStatus != BookingProgressStatus.success) ...[
              DaysRemainingCard(
                overDue:
                    '${DateTime.parse(rentalProduct?.endDate ?? '').difference(DateTime.now()).inDays} days remaining',
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
                      title:
                          'Are you sure you want to return\nthis item ${rentalProduct?.daysSpan ?? ''} days early, there will be no\nrefunds',
                      onYesPressed: () async {
                        await context.read<RentalProvider>().earlyReturn(
                              context,
                              bookingUid: booking.uid ?? '',
                              bookedProduct: rentalProduct!,
                            );
                      },
                    ),
                  );
                },
              ).toCenter(),
            ],
            if (booking.vendorPickupStatus == BookingProgressStatus.success &&
                booking.userPickupStatus == BookingProgressStatus.success &&
                rentalProduct?.isOverdue == true &&
                booking.userDropOffStatus != BookingProgressStatus.success &&
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
                            booking: booking,
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
                          title:
                              'Please ensure the item being returned\nis the right one that was rented',
                          onYesPressed: () async {
                            await context.read<RentalProvider>().confirmDropOff(
                                  context,
                                  scaffoldKey: GlobalKey<ScaffoldState>(),
                                  type: 'user',
                                  bookingUid: booking.uid ?? '',
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
                      'You’re ${DateTime.now().difference(DateTime.parse(rentalProduct?.endDate ?? '')).inDays} days overdue',
                    ).semiBold().fontSize(14).color(kError700).toCenter(),
              // Text('You’re ${rentalProduct?.daysSpan} days overdue',
              // ).semiBold().fontSize(14).color(kError700).toCenter()
            ],
            if (booking.vendorPickupStatus == BookingProgressStatus.success &&
                booking.userPickupStatus == BookingProgressStatus.success &&
                rentalProduct?.returnedEarly == true &&
                rentalProduct?.isOverdue == false &&
                booking.userDropOffStatus != BookingProgressStatus.success) ...[
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
                            booking: booking,
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
                          title:
                              'Please ensure the item being returned\nis the right one that was rented',
                          onYesPressed: () async {
                            await context.read<RentalProvider>().confirmDropOff(
                                  context,
                                  scaffoldKey: GlobalKey<ScaffoldState>(),
                                  type: 'user',
                                  bookingUid: booking.uid ?? '',
                                );
                          },
                        ),
                      );
                    },
                  ).flexible(),
                ],
              ),
            ],
            if (booking.userDropOffStatus == BookingProgressStatus.success) ...[
              if (rentalProduct?.isReviewed == true) ...[
                AppCard(
                  width: double.infinity,
                  padding: EdgeInsets.all(AppThemeUtil.radius(12)),
                  decoration: ShapeDecoration(
                    color: kGrey50,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppThemeUtil.radius(12)),
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
                            children: List.generate(
                                rentalProduct?.review?.rating ?? 0, (index) {
                              return ZSvgIcon(
                                'star.svg',
                                color: kWarning700,
                                size: AppThemeUtil.radius(14.0),
                              );
                            }),
                          ),
                          Text(
                            rentalProduct?.review?.date ?? '',
                          )
                              .regular()
                              .fontSize(12)
                              .color(kGrey700)
                              .alignText(TextAlign.right),
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
                            booking: booking,
                          ),
                        );
                      },
                    )
            ],
            if (booking.userHasReported)
              Center(
                  child: const Text("You reported this vendor")
                      .semiBold()
                      .fontSize(14)
                      .color(kGrey800))
          ]),
        ).paddingOnly(bottom: kWidthPadding);
      },
    );
  }
}
