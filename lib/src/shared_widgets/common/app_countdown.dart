import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

import '../../../core/utils/app_theme_util.dart';
import '../../../core/utils/helper_util.dart';
import '../../../core/constants/colors.dart';

class AppCountDown extends StatelessWidget {
  const AppCountDown({
    super.key,
    this.endTime,
    this.onEnd,
    this.controller,
  });

  final int? endTime;
  final void Function()? onEnd;
  final CountdownTimerController? controller;

  @override
  Widget build(BuildContext context) {
    return CountdownTimer(
      controller: controller,
      endTime: endTime,
      widgetBuilder: (_, time) {
        return time == null?
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppThemeUtil.width(12.0),
                vertical: AppThemeUtil.width(8.0),
              ),
              margin: EdgeInsets.only(left: AppThemeUtil.width(8.0)),
              decoration: BoxDecoration(
                color: kPrimaryBlack,
                borderRadius: BorderRadius.circular(AppThemeUtil.radius(32)),
              ),
              child: const Text('Resend Code').semiBold().fontSize(14.0).color(kPrimaryWhite),
            )
        :
        Text(
          time.min == null
              ? '00:${HelperUtil.addZeroToSingleInteger(time.sec)}'
              : '${HelperUtil.addZeroToSingleInteger(time.min)}:${HelperUtil.addZeroToSingleInteger(time.sec)}',
        ).bold().fontSize(16.0).color(kPrimaryBlack);
      },
      onEnd: onEnd,
    );
  }
}
