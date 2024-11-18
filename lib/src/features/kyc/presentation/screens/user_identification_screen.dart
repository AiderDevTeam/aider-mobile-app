import 'package:aider_mobile_app/core/constants/colors.dart';
import 'package:aider_mobile_app/core/constants/common.dart';
import 'package:aider_mobile_app/core/extensions/widgets/center_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/src/shared_widgets/base/app_screen_scaffold.dart';
import 'package:aider_mobile_app/src/shared_widgets/buttons/app_primary_button.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/v_space.dart';
import 'package:flutter/material.dart';

import '../../../../../core/routing/app_navigator.dart';
import '../../../../../core/routing/app_route.dart';

class UserIdentificationScreen extends StatelessWidget {
  const UserIdentificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScreenScaffold(
      title: 'User Identification',
      titleFontSize: 24.0,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const VSpace(height: 196.0),
            Image.asset("$kImagePath/user.png"),
            const VSpace(height: 26.0),
            const Text(
              'To ensure safe transactions and trust on our platform we advice you verify your identity',
            ).semiBold().fontSize(16).color(kGrey1200).alignText(TextAlign.center),
            const VSpace(height: 32.0),
            AppPrimaryButton(
              text: "Verify User identity",
              minWidth: 190,
              height: 48,
              onPressed: (){
                AppNavigator.pushNamed(context, AppRoute.verifyIdentityScreen);
              },
            ).toCenter()
          ],
        ).paddingSymmetric(horizontal: kWidthPadding),
      ),
    );
  }
}
