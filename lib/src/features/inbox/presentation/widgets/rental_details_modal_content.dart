import 'package:aider_mobile_app/core/constants/common.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:flutter/material.dart';

import '../../../../shared_widgets/base/draggable_bottom_sheet.dart';
import '../../../../shared_widgets/modals/draggable_bottom_sheet_content.dart';
import '../../../rentals/domain/models/booking/booking_model.dart';
import '../../../rentals/presentation/widgets/my_items_card.dart';
import '../../../rentals/presentation/widgets/rented_item_card.dart';


class RentalDetailModalContent extends StatelessWidget {
  const RentalDetailModalContent({
    super.key,
    required this.booking,
    required this.isSender,
    required this.isBookingPaid,
    this.messageExternalId,
  });

  final BookingModel booking;
  final bool isSender;
  final bool isBookingPaid;
  final String? messageExternalId;


  @override
  Widget build(BuildContext context) {
    return DraggableBottomSheet(
      initialChildSize: 0.70,
      minChildSize: 0.70,
      maxChildSize: 0.80,
      builder: (context, scrollController) {
        return DraggableBottomSheetContent(
          draggableKey: GlobalKey(),
          scrollController: scrollController,
          title: 'Rental Details',
          content: SingleChildScrollView(
            controller: scrollController,
            child: isSender?
            RentedItemCard(
              rentalProduct: booking,
              messageExternalId: messageExternalId,
              isVendor: false,
            )
                :
            MyItemCard(
              rentalProduct: booking,
              messageExternalId: messageExternalId,
              isVendor: true,
            ),
          ).paddingSymmetric(horizontal: kWidthPadding, vertical: 20),
        );
      },
    );
  }
}