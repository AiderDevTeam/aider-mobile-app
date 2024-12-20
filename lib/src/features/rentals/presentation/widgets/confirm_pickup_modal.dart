import 'package:aider_mobile_app/core/constants/colors.dart';
import 'package:aider_mobile_app/core/extensions/widgets/center_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/core/utils/app_theme_util.dart';
import 'package:aider_mobile_app/src/shared_widgets/buttons/app_primary_button.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/app_bottom_nav_wrapper.dart';
import 'package:flutter/material.dart';
import '../../../../../core/constants/common.dart';
import '../../../../shared_widgets/base/draggable_bottom_sheet.dart';
import '../../../../shared_widgets/modals/draggable_bottom_sheet_content.dart';

class ConfirmPickupModal extends StatelessWidget {
  const ConfirmPickupModal({
    super.key,
    required this.title,
    required this.onYesPressed,
    this.onNoPressed,
  });
  final String title;
  final void Function() onYesPressed;
  final void Function()? onNoPressed;

  @override
  Widget build(BuildContext context) {
    return DraggableBottomSheet(
      initialChildSize: 0.45,
      minChildSize: 0.40,
      maxChildSize: 0.60,
      builder: (context, scrollController) {
        return DraggableBottomSheetContent(
          bottomNavigationBar: AppBottomNavWrapper(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppPrimaryButton(
                  text: "Not Yet",
                  textColor: kGrey1000,
                  borderColor: kGrey1000,
                  color: kPrimaryWhite,
                  minWidth: AppThemeUtil.width(181.50),
                  height: AppThemeUtil.height(52),
                  onPressed: ()=> Navigator.pop(context),
                ),
                AppPrimaryButton(
                  text: "Yes",
                  minWidth: AppThemeUtil.width(181.50),
                  height: AppThemeUtil.height(52),
                  onPressed: onYesPressed,
                )
              ],
            ),
          ),
          draggableKey: GlobalKey(),
          scrollController: scrollController,
          hasBottomBorder: false,
          modalHeaderContent: Column(
            children: [
              Image.asset("$kImagePath/confirm-pickup.png", width: AppThemeUtil.width(158), height: AppThemeUtil.height(121),),
              // const VSpace(height: 28),
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
