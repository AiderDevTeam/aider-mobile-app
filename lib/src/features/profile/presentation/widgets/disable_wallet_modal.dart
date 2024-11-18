import 'package:aider_mobile_app/core/constants/colors.dart';
import 'package:aider_mobile_app/core/extensions/widgets/flexible_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/core/utils/app_theme_util.dart';
import 'package:aider_mobile_app/src/shared_widgets/buttons/app_primary_button.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/h_space.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/v_space.dart';
import 'package:flutter/material.dart';
import '../../../../../core/constants/common.dart';
import '../../../../shared_widgets/base/popup_modal_body.dart';

class DisableWalletModal extends StatelessWidget {
  const DisableWalletModal({
    super.key,
    required this.onYesPressed,
    this.onNoPressed,
  });
  final void Function() onYesPressed;
  final void Function()? onNoPressed;

  @override
  Widget build(BuildContext context) {
    return PopupModalBody(
      verticalPadding: 16.0,
      title: Column(
        children: [
          const VSpace(height: 32.0),
          Image.asset("$kImagePath/disable_wallet.png", width: AppThemeUtil.width(158), height: AppThemeUtil.height(121),),
          const VSpace(height: 16.0),
            const Text(
              "Disable Wallet",
            ).extraBold().fontSize(20.0).color(kPrimaryBlack).alignText(TextAlign.center),
          const VSpace(height: 32),
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppPrimaryButton(
              text: "Yes",
              textColor: kGrey1000,
              borderColor: kGrey1000,
              color: kPrimaryWhite,
              // minWidth: AppThemeUtil.width(135),
              height: AppThemeUtil.height(56),
              onPressed: ()=> Navigator.pop(context),
            ).flexible(),
            const HSpace(width: 16),
            AppPrimaryButton(
              text: "No",
              // minWidth: AppThemeUtil.width(135),
              height: AppThemeUtil.height(56),
              onPressed: onYesPressed,
            ).flexible()
          ],
        )
      ],
      child: const Text("Are you really sure you want to delete your account?").regular().fontSize(16.0).color(kPrimaryBlack).alignText(TextAlign.center).paddingOnly(bottom: 32),
    );
  }
}
