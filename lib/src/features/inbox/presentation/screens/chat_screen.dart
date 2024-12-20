import 'package:aider_mobile_app/core/constants/common.dart';
import 'package:aider_mobile_app/core/extensions/widgets/flexible_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/core/utils/app_theme_util.dart';
import 'package:aider_mobile_app/core/view_models/user_view_model.dart';
import 'package:aider_mobile_app/src/features/inbox/presentation/view_models/inbox_view_model.dart';
import 'package:aider_mobile_app/src/features/inbox/presentation/widgets/nudge_chat_item.dart';
import 'package:aider_mobile_app/src/features/inbox/presentation/widgets/nudge_modal_content.dart';
import 'package:aider_mobile_app/src/features/inbox/presentation/widgets/request_chat_item.dart';
import 'package:aider_mobile_app/src/shared_widgets/base/app_screen_scaffold.dart';
import 'package:aider_mobile_app/src/shared_widgets/buttons/app_primary_button.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/h_space.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/routing/app_navigator.dart';
import '../../../../../core/utils/app_dialog_util.dart';
import '../../../../../core/view_models/base_view.dart';
import '../../../../shared_widgets/common/network_image_view.dart';
import '../../domain/models/chat/chat_model.dart';
import '../widgets/text_chat_item.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    required this.param,
  });

  final Map<String, dynamic> param;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<InboxViewModel>().emitMessages((widget.param['chat'] as ChatModel).id ?? 0);
      context.read<InboxViewModel>().fetchMessages();
    });
    super.initState();
  }

  @override
  void deactivate() {
    context.read<InboxViewModel>().closeFetchMessage();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final chat = widget.param['chat'] as ChatModel;
    final sent = widget.param['sent'] as bool;
    final user = context.read<UserViewModel>().getUser;
    return AppScreenScaffold(
      backgroundColor: kGrey50,
      titleWidget: Row(
        children: [
          const HSpace(width: 12.0),
          (sent ? chat.vendor?.hasProfilePhoto == true : chat.user?.hasProfilePhoto == true)
              ? NetworkImageView(
                  imageUrl: sent ? (chat.vendor?.profilePhotoUrl ?? '') : (chat.user?.profilePhotoUrl ?? ''),
                  height: AppThemeUtil.radius(44),
                  width: AppThemeUtil.radius(44),
                  radius: 100,
                )
              : CircleAvatar(
                  maxRadius: AppThemeUtil.radius(22.0),
                  backgroundImage: const AssetImage('$kImagePath/profile_placeholder.png'),
                ),
          const HSpace(width: 12.0),
          Text(sent ? chat.vendor?.greetingName ?? '' : chat.user?.greetingName ?? '')
              .semiBold()
              .fontSize(20.0)
              .color(kPrimaryBlack)
              .letterSpacing(-0.31)
              .overflowText(TextOverflow.ellipsis)
              .flexible(),
        ],
      ).flexible(),
      bottomNavigationBar: BaseView<InboxViewModel>(builder: (context, inboxConsumer, child) {
        if (user.externalId == chat.messages.first.senderExternalId && inboxConsumer.canNudge && inboxConsumer.getMessages.first.isOngoing) {
          return AppPrimaryButton(
            text: 'Nudge 👋',
            height: 52,
            onPressed: () {
              AppDialogUtil.showScrollableBottomSheet(
                context: context,
                builder: (modalContext) => NudgeModalContent(
                  chat: chat,
                  onYesPressed: () async {
                    AppNavigator.pop(modalContext);
                    await context.read<InboxViewModel>().sendNudge(
                      context,
                      conversationId: chat.externalId,
                      requestBody: {"message": "Hey! can you please look at my request and respond accordingly thanks.", "type": "nudge"},
                    );
                  },
                ),
              );
            },
          ).paddingSymmetric(horizontal: kWidthPadding, vertical: 14.0);
        }

        return const SizedBox.shrink();
      }),
      child: BaseView<InboxViewModel>(builder: (context, inboxConsumer, child) {
        return ListView.builder(
          padding: EdgeInsets.symmetric(vertical: AppThemeUtil.height(20.0)),
          itemCount: inboxConsumer.getMessages.length,
          reverse: true,
          itemBuilder: (context, index) {
            final message = inboxConsumer.getMessages[index];

            if (message.type == kChatTextType) {
              return TextChatItem(
                message: message,
              ).paddingOnly(
                right: user.externalId == message.senderExternalId ? 0 : (MediaQuery.of(context).size.width * 0.17),
                left: user.externalId == message.senderExternalId ? (MediaQuery.of(context).size.width * 0.17) : 0,
                bottom: 12.0,
              );
            }

            if (message.type == kChatNudgeType) {
              return NudgeChatItem(
                message: message,
                senderName: (chat.user?.greetingName ?? ''),
              ).paddingOnly(
                left: user.externalId == message.senderExternalId ? (MediaQuery.of(context).size.width * 0.17) : 0,
                right: user.externalId == message.senderExternalId ? 0 : (MediaQuery.of(context).size.width * 0.17),
                bottom: 12.0,
              );
            }

            return RequestChatItem(
              message: message,
              senderName: (sent ? chat.vendor?.greetingName ?? '' : chat.user?.greetingName ?? ''),
            ).paddingOnly(
              right: user.externalId == message.senderExternalId ? 0 : (MediaQuery.of(context).size.width * 0.17),
              left: user.externalId == message.senderExternalId ? (MediaQuery.of(context).size.width * 0.17) : 0,
              bottom: 12.0,
            );
          },
        ).paddingSymmetric(horizontal: kWidthPadding);
      }),
    );
  }
}
