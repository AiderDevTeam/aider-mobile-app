import 'package:aider_mobile_app/core/extensions/widgets/gesture_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/routing/app_navigator.dart';
import 'package:aider_mobile_app/core/routing/app_route.dart';
import 'package:aider_mobile_app/core/view_models/base_view.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/aider_empty_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/utils/app_theme_util.dart';
import '../../../../../core/view_models/user_view_model.dart';
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
      if(!mounted) return;
      context.read<InboxViewModel>().emitRenderConversations(
        context.read<UserViewModel>().getUser.externalId?? '',
      );

      if(!mounted) return;
      context.read<InboxViewModel>().fetchRenterConversations();
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BaseView<InboxViewModel>(
      builder: (context, inboxConsumer, child) {
        if(inboxConsumer.getComponentLoading('sentInbox') && inboxConsumer.getSentChats.isEmpty){
          return const InboxLoadingEffect();
        }

        if(inboxConsumer.getSentChats.isEmpty){
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
          itemCount: inboxConsumer.getSentChats.length,
          itemBuilder: (context, index){
            final chat = inboxConsumer.getSentChats[index];
            return InboxItem(
              chat: chat,
              sent: true,
            ).onPressed((){
              AppNavigator.pushNamed(context, AppRoute.chatScreen, arguments: {
                'sent': true,
                'chat': chat,
              });
            }).paddingOnly(bottom: 16.0);
          },
        );
      }
    );
  }
}
