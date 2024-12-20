
import 'package:aider_mobile_app/core/constants/common.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/src/shared_widgets/base/app_screen_scaffold.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/colors.dart';
import '../../../rentals/presentation/widgets/button_switcher.dart';
import '../widgets/received_tab_screen.dart';
import '../widgets/sent_tab_screen.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScreenScaffold(
      hasLeading: false,
      title: 'Inbox',
      titleFontSize: 24.0,
      child: ButtonSwitcher(
        tabs: [
          Tab(
            child: Align(
              alignment: Alignment.center,
              child: const Text('Received').semiBold().fontSize(16.0)
            ),
          ),
          Tab(
            child: Align(
              alignment: Alignment.center,
              child: const Text("Sent").semiBold().fontSize(16.0),
            ),
          ),
        ],
        unselectedLabelColor: kPrimaryBlack,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: kPrimaryBlack,
        ),
        children: [
          const ReceivedTabScreen().paddingSymmetric(horizontal: kWidthPadding),
          const SentTabScreen().paddingSymmetric(horizontal: kWidthPadding)
        ],

      ),
    );
  }
}
