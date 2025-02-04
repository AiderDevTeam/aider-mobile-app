import 'package:aider_mobile_app/core/extensions/widgets/gesture_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/routing/app_navigator.dart';
import 'package:aider_mobile_app/core/routing/app_route.dart';
import 'package:aider_mobile_app/core/providers/base_view.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/aider_empty_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/utils/app_theme_util.dart';
import '../../../../../core/providers/user_provider.dart';
import '../../../../shared_widgets/common/svg_icon.dart';
import '../view_models/inbox_view_model.dart';
import 'inbox_item.dart';
import 'inbox_loading_effect.dart';

class SentTabScreen extends StatefulWidget {
  const SentTabScreen({super.key});

  @override
  State<SentTabScreen> createState() => _SentTabScreenState();
}

class _SentTabScreenState extends State<SentTabScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<InboxViewModel>().fetchRenterBookingRequests();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<InboxViewModel>(builder: (context, inboxConsumer, child) {
      if (inboxConsumer.isComponentLoading('sentInbox') &&
          inboxConsumer.getSentBookings.isEmpty) {
        return const InboxLoadingEffect();
      }

      if (inboxConsumer.getSentBookings.isEmpty) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AiderEmptyState(
              title: '',
              subtitle: 'You have not sent any \nmessage or request yet',
              iconWidget: ZSvgIcon(
                'chat.svg',
                size: AppThemeUtil.radius(100),
              ),
            ),
          ],
        );
      }

      return ListView.builder(
        itemCount: inboxConsumer.getSentBookings.length,
        itemBuilder: (context, index) {
          final booking = inboxConsumer.getSentBookings[index];
          return InboxItem(
            booking: booking,
            sent: true,
          ).onPressed(() {
            AppNavigator.pushNamed(context, AppRoute.chatScreen, arguments: {
              'sent': true,
              'booking': booking,
            });
          }).paddingOnly(bottom: 16.0);
        },
      );
    });
  }
}
