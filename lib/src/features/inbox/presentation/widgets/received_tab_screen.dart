import 'package:aider_mobile_app/core/extensions/widgets/gesture_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/utils/app_theme_util.dart';
import 'package:aider_mobile_app/src/features/inbox/presentation/widgets/inbox_loading_effect.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/routing/app_navigator.dart';
import '../../../../../core/routing/app_route.dart';
import '../../../../../core/providers/base_view.dart';
import '../../../../shared_widgets/common/aider_empty_state.dart';
import '../view_models/inbox_view_model.dart';
import 'inbox_item.dart';

class ReceivedTabScreen extends StatefulWidget {
  const ReceivedTabScreen({super.key});

  @override
  State<ReceivedTabScreen> createState() => _ReceivedTabScreenState();
}

class _ReceivedTabScreenState extends State<ReceivedTabScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<InboxViewModel>().fetchVendorBookingRequests();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<InboxViewModel>(builder: (context, inboxConsumer, child) {
      if (inboxConsumer.isComponentLoading('receivedInbox') &&
          inboxConsumer.getReceivedBookings.isEmpty) {
        return const InboxLoadingEffect();
      }

      if (inboxConsumer.getReceivedBookings.isEmpty) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AiderEmptyState(
              title: '',
              subtitle: 'You have not received any \nmessage or request yet',
              iconWidget: ZSvgIcon(
                'chat.svg',
                size: AppThemeUtil.radius(100),
              ),
            ).paddingOnly(bottom: 48),
          ],
        );
      }

      return ListView.builder(
        itemCount: inboxConsumer.getReceivedBookings.length,
        itemBuilder: (context, index) {
          final booking = inboxConsumer.getReceivedBookings[index];
          return InboxItem(
            booking: booking,
            sent: false,
          ).onPressed(() {
            AppNavigator.pushNamed(context, AppRoute.chatScreen, arguments: {
              'sent': false,
              'booking': booking,
            });
          }).paddingOnly(bottom: 16.0);
        },
      );
    });
  }
}
