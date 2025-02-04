import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/core/utils/app_theme_util.dart';
import 'package:aider_mobile_app/core/constants/colors.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/svg_icon.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/v_space.dart';
import 'package:flutter/material.dart';

import '../../../core/routing/app_navigator.dart';
import '../base/popup_modal_body.dart';
import '../buttons/app_primary_button.dart';

class ErrorModalContent extends StatelessWidget {
  const ErrorModalContent({
    super.key,
    this.errorTitle = '',
    required this.errorMessage,
    this.onButtonPressed,
    this.showIcon = true,
  });

  final String errorTitle;
  final String errorMessage;
  final void Function()? onButtonPressed;
  final bool showIcon;

  @override
  Widget build(BuildContext context) {
    return PopupModalBody(
      title: Column(
        children: [
          if (showIcon) ...[
            const VSpace(height: 32),
            Container(
              width: AppThemeUtil.radius(56.0),
              height: AppThemeUtil.radius(56.0),
              decoration: BoxDecoration(
                color: AppThemeUtil.getThemeColor(kError700),
                borderRadius: BorderRadius.circular(AppThemeUtil.radius(12.0)),
              ),
              padding: EdgeInsets.all(AppThemeUtil.radius(6.0)),
              child: ZSvgIcon(
                'danger_triangle_bold.svg',
                size: AppThemeUtil.radius(24.0),
                color: AppThemeUtil.getThemeColor(kPrimaryWhite),
              ),
            ),
          ],
          if (errorTitle.isNotEmpty) ...[
            const VSpace(height: 16.0),
            Text(
              errorTitle,
            )
                .extraBold()
                .fontSize(20.0)
                .color(kPrimaryBlack)
                .alignText(TextAlign.center),
          ]
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppPrimaryButton(
              onPressed: onButtonPressed ??
                  () {
                    AppNavigator.pop(context);
                  },
              text: 'Okay',
            ),
          ],
        )
      ],
      child: Text(errorMessage)
          .regular()
          .fontSize(16.0)
          .color(kPrimaryBlack)
          .alignText(TextAlign.center)
          .paddingOnly(bottom: 16.0),
    );
  }
}
