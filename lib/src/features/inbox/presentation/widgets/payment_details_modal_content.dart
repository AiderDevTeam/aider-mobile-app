import 'package:aider_mobile_app/core/constants/common.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:flutter/material.dart';

import '../../../../shared_widgets/base/draggable_bottom_sheet.dart';
import '../../../../shared_widgets/modals/draggable_bottom_sheet_content.dart';
import '../../../rentals/domain/models/booking/booking_model.dart';
import '../../../rentals/presentation/widgets/my_items_card.dart';
import '../../../rentals/presentation/widgets/rented_item_card.dart';


class PaymentDetailModalContent extends StatelessWidget {
  const PaymentDetailModalContent({
    super.key,
    required this.booking,
    required this.isSender,
  });

  final BookingModel booking;
  final bool isSender;

  @override
  Widget build(BuildContext context) {
    return DraggableBottomSheet(
      initialChildSize: 0.65,
      minChildSize: 0.65,
      maxChildSize: 0.75,
      builder: (context, scrollController) {
        return DraggableBottomSheetContent(
          draggableKey: GlobalKey(),
          scrollController: scrollController,
          title: 'Rental details',
          content: SingleChildScrollView(
            controller: scrollController,
            child: isSender?
            RentedItemCard(
              rentalProduct: booking,
              isVendor: false,
              isBookingPaid: true,
            )
                :
            MyItemCard(
              rentalProduct: booking,
              isVendor: true,
            ),
          ).paddingSymmetric(horizontal: kWidthPadding, vertical: 20),
        );
      },
    );
  }
}