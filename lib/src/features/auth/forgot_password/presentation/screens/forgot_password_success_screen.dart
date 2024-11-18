import 'package:aider_mobile_app/core/extensions/widgets/align_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/core/routing/app_navigator.dart';
import 'package:aider_mobile_app/core/constants/common.dart';
import 'package:aider_mobile_app/src/shared_widgets/buttons/app_primary_button.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/v_space.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/routing/app_route.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../shared_widgets/base/app_screen_scaffold.dart';


class ForgotPasswordSuccessScreen extends StatelessWidget {
  const ForgotPasswordSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScreenScaffold(
      appBar: false,
      hasBottomBorder: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Check your mail 👋').semiBold().color(kBlack.withOpacity(0.8)).fontSize(28.0).letterSpacing(-0.31).alignText(TextAlign.center).alignCenter(),
          const VSpace(height: 20.0),
          const Text('We have sent you a link to reset your password.').semiBold().color(kBlack).fontSize(20.0).letterSpacing(-1.1).alignText(TextAlign.center).alignCenter(),
          const VSpace(height: 64.0),
          AppPrimaryButton(
            onPressed: (){
              AppNavigator.pushNamedAndRemoveUntil(context, AppRoute.onboardingScreen, (p0) => false);
            },
            text: 'Okay',
            minWidth: double.infinity,
          ),
          const VSpace(height: 16.0),
        ],
      ).paddingSymmetric(horizontal: kWidthPadding),
    );
  }
}