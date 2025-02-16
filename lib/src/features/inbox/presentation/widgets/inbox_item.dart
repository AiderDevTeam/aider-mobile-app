import 'package:aider_mobile_app/core/constants/common.dart';
import 'package:aider_mobile_app/core/extensions/date_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/flexible_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/network_image_view.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/utils/app_theme_util.dart';
import '../../../../shared_widgets/cards/app_card.dart';
import '../../../../shared_widgets/common/h_space.dart';
import '../../../../shared_widgets/common/v_space.dart';
import '../../../rentals/domain/models/booking/booking_model.dart';

class InboxItem extends StatelessWidget {
  const InboxItem({
    super.key,
    this.sent = false,
    required this.booking,
  });

  final bool sent;
  final BookingModel booking;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.all(AppThemeUtil.radius(12.0)),
      backgroundColor: sent ? kGrey50 : kGrey100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              (booking.bookedProduct?.product?.hasPhotos == true)
                  ? NetworkImageView(
                      imageUrl:
                          booking.bookedProduct?.product?.firstPhoto ?? '',
                      height: AppThemeUtil.radius(64),
                      width: AppThemeUtil.radius(64),
                      radius: 4,
                    )
                  : Container(
                      width: AppThemeUtil.radius(64.0),
                      height: AppThemeUtil.radius(64.0),
                      decoration: BoxDecoration(
                        color: kError600,
                        borderRadius:
                            BorderRadius.circular(AppThemeUtil.radius(4.0)),
                      ),
                    ),
              const HSpace(width: 12.0),
              if (!sent)
                Text(booking.bookedProduct?.product?.name ?? '')
                    .bold()
                    .fontSize(14)
                    .color(kGrey1200)
                    .textMaxLines(2)
                    .overflowText(TextOverflow.ellipsis)
                    .flexible(),
              if (sent)
                Text(booking.bookedProduct?.product?.name ?? '')
                    .medium()
                    .fontSize(14)
                    .color(kGrey600)
                    .textMaxLines(2)
                    .overflowText(TextOverflow.ellipsis)
                    .flexible(),
            ],
          ),
          const VSpace(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (!sent)
                Text('${DateTime.tryParse(booking.createdAt?.toString() ?? '')?.timeFormat('')} • ${DateTime.tryParse(booking.createdAt?.toString() ?? '')?.format('dd MMM, y') ?? ''}')
                    .semiBold()
                    .fontSize(12)
                    .color(kGrey1200)
                    .flexible(),
              if (sent)
                Text('${DateTime.tryParse(booking.createdAt?.toString() ?? '')?.timeFormat('') ?? ''} • ${DateTime.tryParse(booking.createdAt?.toString() ?? '')?.format('dd MMM, y') ?? ''}')
                    .regular()
                    .fontSize(12)
                    .color(kGrey400)
                    .flexible(),
              Row(
                children: [
                  (sent
                          ? booking.vendor?.hasProfilePhoto == true
                          : booking.user?.hasProfilePhoto == true)
                      ? NetworkImageView(
                          imageUrl: sent
                              ? (booking.vendor?.profilePhotoUrl ?? '')
                              : (booking.user?.profilePhotoUrl ?? ''),
                          height: AppThemeUtil.radius(24),
                          width: AppThemeUtil.radius(24),
                          radius: 100,
                        )
                      : CircleAvatar(
                          maxRadius: AppThemeUtil.radius(12),
                          backgroundImage: const AssetImage(
                              '$kImagePath/profile_placeholder.png'),
                        ),
                  const HSpace(width: 8.0),
                  Text(sent
                          ? booking.vendor?.firstName ?? ''
                          : booking.user?.firstName ?? '')
                      .regular()
                      .fontSize(12)
                      .color(kGrey600)
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
