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
import '../../domain/models/chat/chat_model.dart';

class InboxItem extends StatelessWidget {
  const InboxItem({
    super.key,
    this.sent = false,
    required this.chat,
  });

  final bool sent;
  final ChatModel chat;

  @override
  Widget build(BuildContext context) {
    final firstMessage = chat.messages.first;
    final bookModel = firstMessage.type == kChatBookingType? BookingModel.fromJson(firstMessage.senderMessage?? {}) : const BookingModel();

    return AppCard(
      padding: EdgeInsets.all(AppThemeUtil.radius(12.0)),
      backgroundColor: sent? kGrey50 : kGrey100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              (bookModel.bookedProduct?.product?.hasPhotos == true) ?
              NetworkImageView(
                imageUrl: bookModel.bookedProduct?.product?.firstPhoto?? '',
                height: AppThemeUtil.radius(64),
                width: AppThemeUtil.radius(64),
                radius: 4,
              )
                  :
              Container(
                width: AppThemeUtil.radius(64.0),
                height: AppThemeUtil.radius(64.0),
                decoration: BoxDecoration(
                  color: kError600,
                  borderRadius: BorderRadius.circular(AppThemeUtil.radius(4.0)),
                ),
              ),
              const HSpace(width: 12.0),
              if(!sent) Text(bookModel.bookedProduct?.product?.name?? '').bold().fontSize(14).color(kGrey1200).textMaxLines(2).overflowText(TextOverflow.ellipsis).flexible(),
              if(sent) Text(bookModel.bookedProduct?.product?.name?? '').medium().fontSize(14).color(kGrey600).textMaxLines(2).overflowText(TextOverflow.ellipsis).flexible(),
            ],
          ),
          const VSpace(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if(!sent) Text('${DateTime.parse(chat.createdAt?? '').timeFormat('')} • ${DateTime.parse(chat.createdAt?? '').format('dd MMM, y')}').semiBold().fontSize(12).color(kGrey1200).flexible(),
              if(sent) Text('${DateTime.parse(chat.createdAt?? '').timeFormat('')} • ${DateTime.parse(chat.createdAt?? '').format('dd MMM, y')}').regular().fontSize(12).color(kGrey400).flexible(),
              (sent? chat.vendor?.hasProfilePhoto == true : chat.user?.hasProfilePhoto == true) ?
              NetworkImageView(
                imageUrl: sent? (chat.vendor?.profilePhotoUrl?? '') : (chat.user?.profilePhotoUrl?? ''),
                height: AppThemeUtil.radius(24),
                width: AppThemeUtil.radius(24),
                radius: 100,
              )
              :
              CircleAvatar(
                maxRadius: AppThemeUtil.radius(12),
                backgroundImage: const AssetImage('$kImagePath/profile_placeholder.png'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
