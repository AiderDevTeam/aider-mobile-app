import 'package:aider_mobile_app/core/constants/colors.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';


class AppKeyboardAction extends StatelessWidget {
  const AppKeyboardAction({
    super.key,
    required this.child,
    this.actions,
    this.bothPlatform = false,
  });

  final Widget child;
  final List<KeyboardActionsItem>? actions;
  final bool bothPlatform;

  @override
  Widget build(BuildContext context) {
    return KeyboardActions(
      config: KeyboardActionsConfig(
        keyboardActionsPlatform: bothPlatform? KeyboardActionsPlatform.ALL : KeyboardActionsPlatform.IOS,
        nextFocus: false,
        keyboardBarColor: kGrey200,
        defaultDoneWidget: const Text('Done').semiBold().fontSize(16.0).color(kPrimaryBlack),
        actions: actions,
      ),
      child: child,
    );
  }
}
