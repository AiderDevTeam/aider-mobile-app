import 'package:aider_mobile_app/core/extensions/widgets/flexible_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/core/services/payment_service.dart';
import 'package:aider_mobile_app/core/utils/app_dialog_util.dart';
import 'package:aider_mobile_app/core/utils/cached_network_image_util.dart';
import 'package:aider_mobile_app/core/providers/base_view.dart';
import 'package:aider_mobile_app/core/providers/user_provider.dart';
import 'package:aider_mobile_app/src/features/inbox/domain/models/message/message_model.dart';
import 'package:aider_mobile_app/src/features/inbox/presentation/view_models/inbox_view_model.dart';
import 'package:aider_mobile_app/src/features/inbox/presentation/widgets/rental_details_modal_content.dart';
import 'package:aider_mobile_app/src/features/inbox/presentation/widgets/request_booking_actions.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/h_space.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/svg_icon.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/zloading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/utils/app_theme_util.dart';
import '../../../../shared_widgets/buttons/app_primary_button.dart';
import '../../../../shared_widgets/cards/app_card.dart';
import '../../../../shared_widgets/common/v_space.dart';
import '../../../rentals/domain/models/booking/booking_model.dart';
import '../../../transaction/presentation/providers/transaction_provider.dart';

class RequestChatItem extends StatelessWidget {
  const RequestChatItem({
    super.key,
    required this.message,
    required this.booking,
    required this.senderName,
  });

  final MessageModel message;
  final BookingModel booking;
  final String senderName;

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserProvider>().getUser;
    final isSender = message.senderUid == user.uid;
    final isBookingPaid =
        booking.collectionStatus == BookingProgressStatus.success;
    final isBookingAccepted =
        booking.bookingAcceptanceStatus == BookingProgressStatus.accepted;
    final isBookingCanceled =
        booking.bookingAcceptanceStatus == BookingProgressStatus.cancelled;
    final isBookingRejected =
        booking.bookingAcceptanceStatus == BookingProgressStatus.rejected;
    final isBookingPending =
        booking.bookingAcceptanceStatus == BookingProgressStatus.pending;
    final isCompleted =
        booking.vendorDropOffStatus == BookingProgressStatus.success &&
            booking.userDropOffStatus == BookingProgressStatus.success;

    return AppCard(
      padding: EdgeInsets.symmetric(
        vertical: AppThemeUtil.height(12.0),
        horizontal: AppThemeUtil.width(24.5),
      ),
      decoration: BoxDecoration(
        color: kPrimaryWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppThemeUtil.radius(isSender ? 12.0 : 0)),
          topRight: Radius.circular(AppThemeUtil.radius(isSender ? 0 : 12.0)),
          bottomRight: Radius.circular(AppThemeUtil.radius(12.0)),
          bottomLeft: Radius.circular(AppThemeUtil.radius(12.0)),
        ),
      ),
      child: Column(
        children: [
          const Text('ITEM REQUEST').semiBold().fontSize(12.0).color(kGrey800),
          const VSpace(height: 12.0),
          Container(
            alignment: Alignment.bottomCenter,
            height: AppThemeUtil.height(236.0),
            decoration: BoxDecoration(
              color: kBlue100,
              borderRadius: BorderRadius.circular(AppThemeUtil.radius(12)),
              image: DecorationImage(
                image: CachedNetworkImageUtil.cacheNetworkImageProvider(
                    booking.bookedProduct?.product?.firstPhoto ?? ''),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              width: double.infinity,
              height: AppThemeUtil.height(64.0),
              padding: EdgeInsets.all(AppThemeUtil.radius(12.0)),
              decoration: BoxDecoration(
                color: kBlue100,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(AppThemeUtil.radius(12)),
                  bottomRight: Radius.circular(AppThemeUtil.radius(12)),
                ),
              ),
              child: Text(booking.bookedProduct?.product?.name ?? '')
                  .bold()
                  .fontSize(14.0)
                  .color(kGrey1200)
                  .textMaxLines(2)
                  .alignText(TextAlign.center)
                  .overflowText(TextOverflow.ellipsis),
            ),
          ),
          const VSpace(height: 12.0),
          Container(
            padding: EdgeInsets.all(AppThemeUtil.radius(20)),
            decoration: BoxDecoration(
              color: kGrey50,
              borderRadius: BorderRadius.circular(AppThemeUtil.radius(12)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Quantity')
                        .medium()
                        .fontSize(14.0)
                        .color(kGrey800),
                    Text((booking.bookedProduct?.quantity ?? 0).toString())
                        .semiBold()
                        .fontSize(14.0)
                        .color(kGrey1200),
                  ],
                ),
                const VSpace(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(booking.bookedProduct?.getDuration ?? '')
                        .medium()
                        .fontSize(14.0)
                        .color(kGrey800),
                    Text('${booking.bookedProduct?.getStartDate} → ${booking.bookedProduct?.getEndDate}')
                        .semiBold()
                        .fontSize(14.0)
                        .color(kGrey1200)
                        .flexible(),
                  ],
                ),
                const VSpace(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total Cost')
                        .medium()
                        .fontSize(14.0)
                        .color(kGrey800),
                    Text('₦${booking.getTotalCost}')
                        .semiBold()
                        .fontSize(14.0)
                        .color(kGrey1200)
                        .flexible(),
                  ],
                ),
              ],
            ),
          ),
          const VSpace(height: 12.0),
          if (isBookingPending)
            Text(isSender
                    ? 'Waiting for owner to accept'
                    : 'Renter is waiting for you')
                .bold()
                .fontSize(14.0)
                .color(kGrey1200),
          if (isBookingAccepted && !isBookingPaid && !isBookingCanceled)
            Text(isSender
                    ? 'Request accepted'
                    : 'Waiting for payment from renter')
                .bold()
                .fontSize(14.0)
                .color(isSender ? kSuccess700 : kGrey1200),
          if (isBookingPaid) ...[
            if (isSender)
              booking.userPickupStatus == BookingProgressStatus.notStarted
                  ? const Text('You have made payment')
                      .bold()
                      .fontSize(14.0)
                      .color(kSuccess700)
                  : const SizedBox.shrink(),
            if (!isSender)
              booking.vendorPickupStatus == BookingProgressStatus.notStarted
                  ? const Text('Renter has made payment')
                      .bold()
                      .fontSize(14.0)
                      .color(kSuccess700)
                  : const SizedBox.shrink(),
            if (isCompleted)
              const Text('Transaction completed')
                  .bold()
                  .fontSize(14.0)
                  .color(kSuccess700),
            const VSpace(height: 12.0),
            RequestBookingActions(
              booking: booking,
              isVendor: !isSender,
            ),
            const VSpace(height: 8.0),
          ],
          if (isBookingCanceled) ...[
            const Text('Request canceled')
                .bold()
                .fontSize(14.0)
                .color(kAider700),
            const VSpace(height: 8.0),
          ],
          AppPrimaryButton(
            text: 'See rental details',
            onPressed: () {
              AppDialogUtil.showScrollableBottomSheet(
                context: context,
                builder: (modalContext) => RentalDetailModalContent(
                  booking: booking,
                  isSender: isSender,
                  isBookingPaid: isBookingPaid,
                  messageExternalId: message.externalId,
                ),
              );
            },
            height: 40,
            fontSize: 14,
            textColor: kGrey1000,
            borderColor: kGrey1000,
            color: kPrimaryWhite,
          ),
          const VSpace(height: 8.0),
          if (booking.collectionStatus == BookingProgressStatus.success &&
                  booking.userDropOffStatus != BookingProgressStatus.success ||
              booking.vendorDropOffStatus != BookingProgressStatus.success &&
                  !isBookingCanceled &&
                  isBookingPaid)
            ...[],
          if (isSender &&
              [
                BookingProgressStatus.notStarted,
                BookingProgressStatus.abandoned,
                BookingProgressStatus.failed
              ].contains(booking.collectionStatus)) ...[
            if (isBookingAccepted) ...[
              BaseView<TransactionProvider>(
                  builder: (context, transactionConsumer, child) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    AppPrimaryButton(
                      text: transactionConsumer.isPaymentLoading
                          ? ''
                          : 'Make payment',
                      onPressed: () async {
                        final result = await context
                            .read<TransactionProvider>()
                            .initiateTransaction(
                              context,
                              bookingUid: booking.uid!,
                            );

                        if (result != null) {
                          if (!context.mounted) return;
                          await PaymentService().openPayStackForm(
                            context,
                            paymentUrl: result,
                          );
                          return;
                        }

                        if (!context.mounted) return;
                        context.read<TransactionProvider>().setPaymentLoading =
                            false;
                      },
                      height: 40,
                      fontSize: 14,
                    ),
                    if (transactionConsumer.isPaymentLoading)
                      const ZLoading(
                        color: kPrimaryWhite,
                      ),
                  ],
                );
              }),
              const VSpace(height: 8.0),
            ],
          ],
          if (!isSender &&
              isBookingPending &&
              (!isBookingCanceled || !isBookingRejected)) ...[
            BaseView<InboxViewModel>(builder: (context, inboxConsumer, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  AppPrimaryButton(
                    text: inboxConsumer.isAcceptingRequestLoading
                        ? ''
                        : 'Accept request',
                    onPressed: () async {
                      await context
                          .read<InboxViewModel>()
                          .approveBookingRequest(context,
                              messageExternalId: message.externalId,
                              booking: booking,
                              status: BookingProgressStatus.accepted);

                      // if(!context.mounted) return;
                      // context.read<InboxViewModel>().setAcceptingRequestLoading = false;
                    },
                    height: 40,
                    fontSize: 14,
                  ),
                  if (inboxConsumer.isAcceptingRequestLoading)
                    const ZLoading(
                      color: kPrimaryWhite,
                    ),
                ],
              );
            }),
            // AppPrimaryButton(
            //   text: 'Accept request',
            //   onPressed: () async {
            //     await context.read<InboxViewModel>().approveBookingRequest(
            //       context,
            //       messageExternalId: widget.message.externalId,
            //       bookingExternalId: booking.externalId?? '',
            //       requestBody: {
            //         "status": "accepted",
            //       },
            //     );
            //   },
            //   height: 40,
            //   fontSize: 14,
            // ),
            const VSpace(height: 12),
          ],
          if (isBookingPaid) ...[
            if (!isSender) const VSpace(height: 12),
            if (!isSender)
              const Text(
                      'You get your payment once the renter has returned the booked item')
                  .medium()
                  .fontSize(14.0)
                  .color(kGrey800),
            const VSpace(height: 12),
          ],
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(message.getSentAt).regular().fontSize(12.0).color(kGrey400),
              const HSpace(width: 8.0),
              ZSvgIcon(
                'checks.svg',
                size: AppThemeUtil.radius(12.0),
                color: kGrey500,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
