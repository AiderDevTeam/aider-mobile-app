import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/v_space.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/text_style.dart';
import '../../../../../core/utils/app_theme_util.dart';
import '../../../../../core/view_models/user_view_model.dart';
import '../../../../shared_widgets/cards/app_card.dart';
import '../../../../shared_widgets/common/h_space.dart';
import '../../../../shared_widgets/common/svg_icon.dart';
import '../../domain/models/message/message_model.dart';

class TextChatItem extends StatelessWidget {
  const TextChatItem({
    super.key,
    required this.message,
  });

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.all(AppThemeUtil.height(12.0)),
      decoration: BoxDecoration(
        color: kPrimaryWhite,
        borderRadius: BorderRadius.circular(AppThemeUtil.radius(12.0)),
      ),
      child: Column(
        children: [
          RichText(
            text: TextSpan(
              text: message.senderExternalId == context.read<UserViewModel>().getUser.externalId? message.senderMessage.toString() : message.receiverMessage.toString(),
              style: kBoldFontStyle.copyWith(
                fontSize: AppThemeUtil.radius(14),
                color: kGrey1200,
              ),
            ),
          ),
          const VSpace(height: 12.0),
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
