import 'package:aider_mobile_app/core/constants/common.dart';
import 'package:aider_mobile_app/core/extensions/date_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/flexible_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/src/features/inbox/presentation/view_models/inbox_view_model.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/network_image_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/providers/base_view.dart';
import '../../../../../core/utils/app_theme_util.dart';
import '../../../../shared_widgets/cards/app_card.dart';
import '../../../../shared_widgets/common/h_space.dart';
import '../../../../shared_widgets/common/v_space.dart';
import '../../../rentals/domain/models/booking/booking_model.dart';

class InboxItem extends StatefulWidget {
  const InboxItem({super.key, this.sent = false, required this.booking});

  final bool sent;
  final BookingModel booking;

  @override
  State<InboxItem> createState() => _InboxItemState();
}

class _InboxItemState extends State<InboxItem> {
  @override
  void initState() {
    super.initState();
    context.read<InboxViewModel>().listenToUnreadMessages(
          bookingUid: widget.booking.uid,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<InboxViewModel>(builder: (context, inboxProvider, child) {
      final unread = inboxProvider.bookingUnread[widget.booking.uid];
      final hasUnread = unread != null && unread > 0;
      return AppCard(
        padding: EdgeInsets.all(AppThemeUtil.radius(12.0)),
        backgroundColor: widget.sent ? kGrey50 : kGrey100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                (widget.booking.bookedProduct?.product?.hasPhotos == true)
                    ? NetworkImageView(
                        imageUrl:
                            widget.booking.bookedProduct?.product?.firstPhoto ??
                                '',
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
                if (hasUnread)
                  Text(widget.booking.bookedProduct?.product?.name ?? '')
                      .bold()
                      .fontSize(14)
                      .color(kGrey1200)
                      .textMaxLines(2)
                      .overflowText(TextOverflow.ellipsis)
                      .flexible(),
                if (!hasUnread)
                  Text(widget.booking.bookedProduct?.product?.name ?? '')
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
                if (hasUnread)
                  Text('${DateTime.tryParse(widget.booking.createdAt?.toString() ?? '')?.timeFormat('')} • ${DateTime.tryParse(widget.booking.createdAt?.toString() ?? '')?.format('dd MMM, y') ?? ''}')
                      .semiBold()
                      .fontSize(12)
                      .color(kGrey1200)
                      .flexible(),
                if (!hasUnread)
                  Text('${DateTime.tryParse(widget.booking.createdAt?.toString() ?? '')?.timeFormat('') ?? ''} • ${DateTime.tryParse(widget.booking.createdAt?.toString() ?? '')?.format('dd MMM, y') ?? ''}')
                      .regular()
                      .fontSize(12)
                      .color(kGrey400)
                      .flexible(),
                Row(
                  children: [
                    (widget.sent
                            ? widget.booking.vendor?.hasProfilePhoto == true
                            : widget.booking.user?.hasProfilePhoto == true)
                        ? NetworkImageView(
                            imageUrl: widget.sent
                                ? (widget.booking.vendor?.profilePhotoUrl ?? '')
                                : (widget.booking.user?.profilePhotoUrl ?? ''),
                            height: AppThemeUtil.radius(24),
                            width: AppThemeUtil.radius(24),
                            radius: 100,
                          )
                        : CircleAvatar(
                            maxRadius: AppThemeUtil.radius(12),
                            backgroundImage: const AssetImage(
                                '$kImagePath/profile_placeholder.png'),
                            backgroundColor: kGrey50,
                          ),
                    const HSpace(width: 8.0),
                    Text(widget.sent
                            ? widget.booking.vendor?.firstName ?? ''
                            : widget.booking.user?.firstName ?? '')
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
    });
  }
}
