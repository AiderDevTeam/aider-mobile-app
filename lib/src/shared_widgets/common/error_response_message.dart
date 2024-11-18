import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/core/utils/app_theme_util.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/svg_icon.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/v_space.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../buttons/app_text_button.dart';

class ErrorResponseMessage extends StatelessWidget {
  const ErrorResponseMessage({
    super.key,
    required this.message,
    this.onRetry,
    this.hasErrorIcon = false,
  });

  final String message;
  final void Function()? onRetry;
  final bool hasErrorIcon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if(hasErrorIcon) ...[
            Container(
              width: AppThemeUtil.radius(56.0),
              height: AppThemeUtil.radius(56.0),
              decoration: BoxDecoration(
                color: AppThemeUtil.getThemeColor(kError600),
                borderRadius: BorderRadius.circular(AppThemeUtil.radius(12.0)),
              ),
              padding: EdgeInsets.all(AppThemeUtil.radius(6.0)),
              child: ZSvgIcon(
                'danger_triangle_bold.svg',
                size: AppThemeUtil.radius(24.0),
                color: AppThemeUtil.getThemeColor(kPrimaryWhite),
              ),
            ),
            const VSpace(height: 12.0),
          ],
          Text(
            message,
          ).regular().fontSize(16.0).color(kError600).alignText(TextAlign.center),
          if(onRetry != null) ...[
            const VSpace(height: 12.0),
            AppTextButton(
              onPressed: onRetry,
              child: const Text(
                'Retry',
              ).semiBold().fontSize(16.0).color(kError600),
            ),
          ]
        ],
      ),
    );
  }
}
