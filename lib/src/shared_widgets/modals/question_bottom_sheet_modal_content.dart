import 'package:aider_mobile_app/core/constants/colors.dart';
import 'package:aider_mobile_app/core/extensions/widgets/center_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/flexible_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/core/utils/app_theme_util.dart';
import 'package:aider_mobile_app/src/shared_widgets/buttons/app_primary_button.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/app_bottom_nav_wrapper.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/h_space.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/common.dart';
import '../base/draggable_bottom_sheet.dart';
import 'draggable_bottom_sheet_content.dart';

class QuestionBottomSheetContent extends StatelessWidget {
  const QuestionBottomSheetContent({
    super.key,
    required this.title,
    required this.onYesPressed,
    this.onNoPressed,
    this.noButtonText,
    this.yesButtonText,
    this.image,
    this.buttonReversed = false,
  });
  final String title;
  final void Function() onYesPressed;
  final void Function()? onNoPressed;
  final String? noButtonText;
  final String? yesButtonText;
  final String? image;
  final bool buttonReversed;

  @override
  Widget build(BuildContext context) {
    return DraggableBottomSheet(
      initialChildSize: 0.45,
      minChildSize: 0.45,
      maxChildSize: 0.45,
      builder: (context, scrollController) {
        return DraggableBottomSheetContent(
          bottomNavigationBar: AppBottomNavWrapper(
            child: buttonReversed ?
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppPrimaryButton(
                  text: yesButtonText?? "Yes",
                  minWidth: double.infinity,
                  height: 52,
                  onPressed: onYesPressed,
                ).flexible(),
                const HSpace(width: 12.0),
                AppPrimaryButton(
                  text: noButtonText?? "Not Yet",
                  textColor: kGrey1000,
                  borderColor: kGrey1000,
                  color: kPrimaryWhite,
                  minWidth: double.infinity,
                  height: 52,
                  onPressed: onNoPressed?? () => Navigator.pop(context),
                ).flexible(),
              ],
            )
            :
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppPrimaryButton(
                  text: noButtonText?? "Not Yet",
                  textColor: kGrey1000,
                  borderColor: kGrey1000,
                  color: kPrimaryWhite,
                  minWidth: double.infinity,
                  height: 52,
                  onPressed: onNoPressed?? () => Navigator.pop(context),
                ).flexible(),
                const HSpace(width: 12.0),
                AppPrimaryButton(
                  text: yesButtonText?? "Yes",
                  minWidth: double.infinity,
                  height: 52,
                  onPressed: onYesPressed,
                ).flexible(),
              ],
            ),
          ),
          draggableKey: GlobalKey(),
          scrollController: scrollController,
          hasBottomBorder: false,
          modalHeaderContent: Column(
            children: [
              Image.asset("$kImagePath/${image?? 'confirm-pickup.png'}", width: AppThemeUtil.width(158), height: AppThemeUtil.height(121),),
              Text(
                title,
              ).semiBold().fontSize(16).color(kGrey1200).alignText(TextAlign.center).toCenter(),
            ],
          ),
          content: const SizedBox.shrink()
        );
      },
    );
  }
}
