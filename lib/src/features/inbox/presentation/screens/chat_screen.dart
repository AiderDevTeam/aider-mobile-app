import 'package:aider_mobile_app/core/constants/common.dart';
import 'package:aider_mobile_app/core/extensions/widgets/flexible_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/core/utils/app_theme_util.dart';
import 'package:aider_mobile_app/core/providers/user_provider.dart';
import 'package:aider_mobile_app/src/features/inbox/presentation/view_models/inbox_view_model.dart';
import 'package:aider_mobile_app/src/features/inbox/presentation/widgets/nudge_chat_item.dart';
import 'package:aider_mobile_app/src/features/inbox/presentation/widgets/nudge_modal_content.dart';
import 'package:aider_mobile_app/src/features/inbox/presentation/widgets/request_chat_item.dart';
import 'package:aider_mobile_app/src/features/rentals/domain/models/booking/booking_model.dart';
import 'package:aider_mobile_app/src/shared_widgets/base/app_screen_scaffold.dart';
import 'package:aider_mobile_app/src/shared_widgets/buttons/app_primary_button.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/h_space.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/auth/domain/models/user/user_model.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/routing/app_navigator.dart';
import '../../../../../core/utils/app_dialog_util.dart';
import '../../../../../core/providers/base_view.dart';
import '../../../../shared_widgets/common/network_image_view.dart';
import '../widgets/text_chat_item.dart';
import '../../../../features/rentals/presentation/providers/rental_provider.dart';

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
  late bool sent;
  late UserModel user;

  @override
  void initState() {
    super.initState();
    final booking = widget.param['booking'] as BookingModel;
    sent = widget.param['sent'] as bool;
    user = context.read<UserProvider>().getUser;

    context.read<InboxViewModel>().clearMessages();

    // Start listening to booking updates
    context.read<RentalProvider>().listenToBooking(context, booking);
    // Start listening to messages
    context.read<InboxViewModel>().listenToMessages(booking.uid ?? '');
  }

  @override
  void deactivate() {
    context.read<InboxViewModel>().closeFetchMessage();
    context.read<RentalProvider>().closeBookingListener();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RentalProvider>(
      builder: (context, rentalProvider, child) {
        final booking = rentalProvider.currentBooking;
        if (booking == null) return const CircularProgressIndicator();

        return AppScreenScaffold(
          backgroundColor: kGrey50,
          titleWidget: Row(
            children: [
              const HSpace(width: 12.0),
              (sent
                      ? booking.vendor?.hasProfilePhoto == true
                      : booking.user?.hasProfilePhoto == true)
                  ? NetworkImageView(
                      imageUrl: sent
                          ? (booking.vendor?.profilePhotoUrl ?? '')
                          : (booking.user?.profilePhotoUrl ?? ''),
                      height: AppThemeUtil.radius(44),
                      width: AppThemeUtil.radius(44),
                      radius: 100,
                    )
                  : CircleAvatar(
                      maxRadius: AppThemeUtil.radius(22.0),
                      backgroundImage: const AssetImage(
                          '$kImagePath/profile_placeholder.png'),
                    ),
              const HSpace(width: 12.0),
              Text(sent
                      ? booking.vendor?.greetingName ?? ''
                      : booking.user?.greetingName ?? '')
                  .semiBold()
                  .fontSize(20.0)
                  .color(kPrimaryBlack)
                  .letterSpacing(-0.31)
                  .overflowText(TextOverflow.ellipsis)
                  .flexible(),
            ],
          ).flexible(),
          bottomNavigationBar: BaseView<InboxViewModel>(
              builder: (context, inboxConsumer, child) {
            if (user.uid == booking.user?.uid &&
                inboxConsumer.canNudge &&
                inboxConsumer.getMessages.first.isOngoing) {
              return AppPrimaryButton(
                text: 'Nudge 👋',
                height: 52,
                onPressed: () {
                  AppDialogUtil.showScrollableBottomSheet(
                    context: context,
                    builder: (modalContext) => NudgeModalContent(
                      booking: booking,
                      onYesPressed: () async {
                        AppNavigator.pop(modalContext);
                        await context
                            .read<InboxViewModel>()
                            .sendNudge(context, booking: booking);
                      },
                    ),
                  );
                },
              ).paddingSymmetric(horizontal: kWidthPadding, vertical: 14.0);
            }

            return const SizedBox.shrink();
          }),
          child: BaseView<InboxViewModel>(
              builder: (context, inboxConsumer, child) {
            return ListView.builder(
              padding:
                  EdgeInsets.symmetric(vertical: AppThemeUtil.height(20.0)),
              itemCount: inboxConsumer.getMessages.length,
              reverse: true,
              itemBuilder: (context, index) {
                final message = inboxConsumer.getMessages[index];

                if (message.type == kChatTextType) {
                  return TextChatItem(
                    message: message,
                  ).paddingOnly(
                    right: user.uid == message.senderUid
                        ? 0
                        : (MediaQuery.of(context).size.width * 0.17),
                    left: user.uid == message.senderUid
                        ? (MediaQuery.of(context).size.width * 0.17)
                        : 0,
                    bottom: 12.0,
                  );
                }

                if (message.type == kChatNudgeType) {
                  return NudgeChatItem(
                    message: message,
                    senderName: (booking.user?.greetingName ?? ''),
                  ).paddingOnly(
                    left: user.uid == message.senderUid
                        ? (MediaQuery.of(context).size.width * 0.17)
                        : 0,
                    right: user.uid == message.senderUid
                        ? 0
                        : (MediaQuery.of(context).size.width * 0.17),
                    bottom: 12.0,
                  );
                }

                return RequestChatItem(
                  message: message,
                  booking: booking,
                  senderName: (sent
                      ? booking.vendor?.greetingName ?? ''
                      : booking.user?.greetingName ?? ''),
                ).paddingOnly(
                  right: user.uid == message.senderUid
                      ? 0
                      : (MediaQuery.of(context).size.width * 0.17),
                  left: user.uid == message.senderUid
                      ? (MediaQuery.of(context).size.width * 0.17)
                      : 0,
                  bottom: 12.0,
                );
              },
            ).paddingSymmetric(horizontal: kWidthPadding);
          }),
        );
      },
    );
  }
}
