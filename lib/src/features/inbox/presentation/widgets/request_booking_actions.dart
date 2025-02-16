import 'package:aider_mobile_app/core/constants/colors.dart';
import 'package:aider_mobile_app/core/extensions/widgets/center_extension.dart';
import 'package:aider_mobile_app/core/routing/app_navigator.dart';
import 'package:aider_mobile_app/core/utils/app_dialog_util.dart';
import 'package:aider_mobile_app/core/utils/helper_util.dart';
import 'package:aider_mobile_app/src/features/rentals/domain/models/booking/booking_model.dart';
import 'package:aider_mobile_app/src/features/rentals/presentation/providers/rental_provider.dart';
import 'package:aider_mobile_app/src/features/rentals/presentation/widgets/confirm_pickup_modal.dart';
import 'package:aider_mobile_app/src/features/rentals/presentation/widgets/days_remaining_card.dart';
import 'package:aider_mobile_app/src/shared_widgets/buttons/app_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RequestBookingActions extends StatelessWidget {
  const RequestBookingActions(
      {super.key, required this.booking, required this.isVendor});

  final BookingModel booking;
  final bool isVendor;
  @override
  Widget build(BuildContext context) {
    final isVendorPickupConfirmed =
        booking.vendorPickupStatus == BookingProgressStatus.success;
    final isVendorReturnConfirmed =
        booking.vendorDropOffStatus == BookingProgressStatus.success;
    final isRenterPickupConfirmed =
        booking.userPickupStatus == BookingProgressStatus.success;
    final isRenterReturnConfirmed =
        booking.userDropOffStatus == BookingProgressStatus.success;
    final isRenterAndVendorPickupConfirmed =
        isVendorPickupConfirmed && isRenterPickupConfirmed;
    final isRenterOrVendorDropOffConfirmed =
        isVendorReturnConfirmed || isRenterReturnConfirmed;

    return Column(
      children: [
        if (isVendor) ...[
          if (!isVendorPickupConfirmed)
            AppPrimaryButton(
              text: 'Confirm Pickup',
              onPressed: () async {
                AppDialogUtil.showScrollableBottomSheet(
                  context: context,
                  builder: (context) => ConfirmPickupModal(
                    title: 'Are you sure the renter picked up\nthe right item?',
                    onYesPressed: () async {
                      await context.read<RentalProvider>().confirmPickUp(
                            scaffoldKey: GlobalKey<ScaffoldState>(),
                            context,
                            type: 'vendor',
                            booking: booking,
                          );
                    },
                  ),
                );
              },
              height: 40,
              fontSize: 14,
            ),
          if (isVendorPickupConfirmed && !isRenterPickupConfirmed)
            const AppPrimaryButton(
              text: 'Waiting for renter to confirm',
              height: 40,
              fontSize: 14,
              onPressed: null,
            ),
          if (isRenterAndVendorPickupConfirmed &&
              !isVendorReturnConfirmed &&
              !booking.bookedProduct!.isOverdue)
            DaysRemainingCard(
              overDue:
                  'Item in use, ${HelperUtil.getDaysRemaining(booking.bookedProduct?.startDate ?? '', booking.bookedProduct?.endDate ?? '')} days remaining',
              cardColor: const Color.fromARGB(0, 245, 138, 138),
              textColor: const Color(0xFFF79009),
            ),
          if (isRenterAndVendorPickupConfirmed && !isVendorReturnConfirmed)
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
                            type: 'vendor',
                            booking: booking,
                          );
                    },
                  ),
                );
              },
            ),
        ],
        if (!isVendor) ...[
          if (!isRenterPickupConfirmed)
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
                            booking: booking,
                            scaffoldKey: GlobalKey<ScaffoldState>(),
                          );
                    },
                  ),
                );
              },
            ),
          if (isRenterPickupConfirmed && !isVendorPickupConfirmed)
            const AppPrimaryButton(
              text: 'Waiting for vendor to confirm',
              height: 40,
              fontSize: 14,
              onPressed: null,
            ),
          if (isRenterPickupConfirmed &&
              !isRenterReturnConfirmed &&
              !booking.bookedProduct!.isOverdue) ...[
            DaysRemainingCard(
              overDue:
                  'Item in use, ${HelperUtil.getDaysRemaining(booking.bookedProduct?.startDate ?? '', booking.bookedProduct?.endDate ?? '')} days remaining',
              cardColor: const Color.fromARGB(0, 245, 138, 138),
              textColor: const Color(0xFFF79009),
            ),
            AppPrimaryButton(
              text: 'Return Now',
              height: 40,
              fontSize: 14,
              borderColor: kError100,
              color: kError100,
              textColor: kError700,
              onPressed: () {
                AppDialogUtil.showScrollableBottomSheet(
                  context: context,
                  builder: (context) => ConfirmPickupModal(
                    title:
                        'Are you sure you want to return\nthis item ${booking.bookedProduct?.daysSpan ?? ''} days early, there will be no\nrefunds',
                    onYesPressed: () async {
                      await context.read<RentalProvider>().earlyReturn(
                            context,
                            booking: booking,
                            bookedProduct: booking.bookedProduct!,
                          );
                    },
                  ),
                );
              },
            ).toCenter(),
          ],
        ]
      ],
    );
  }
}
