import 'package:aider_mobile_app/core/constants/colors.dart';
import 'package:aider_mobile_app/core/constants/common.dart';
import 'package:aider_mobile_app/core/constants/text_style.dart';
import 'package:aider_mobile_app/core/extensions/widgets/flexible_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/core/utils/app_theme_util.dart';
import 'package:aider_mobile_app/src/shared_widgets/buttons/app_primary_button.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/app_bottom_nav_wrapper.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/h_space.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/v_space.dart';
import 'package:flutter/material.dart';
import '../../../../shared_widgets/base/draggable_bottom_sheet.dart';
import '../../../../shared_widgets/modals/draggable_bottom_sheet_content.dart';
import '../../../rentals/domain/models/booking/booking_model.dart';

class NudgeModalContent extends StatelessWidget {
  const NudgeModalContent({
    super.key,
    required this.booking,
    this.onYesPressed,
  });

  final BookingModel booking;
  final void Function()? onYesPressed;

  @override
  Widget build(BuildContext context) {
    return DraggableBottomSheet(
      initialChildSize: 0.50,
      minChildSize: 0.50,
      maxChildSize: 0.65,
      builder: (context, scrollController) {
        return DraggableBottomSheetContent(
          bottomNavigationBar: AppBottomNavWrapper(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppPrimaryButton(
                  text: "Cancel",
                  textColor: kGrey1000,
                  borderColor: kGrey1000,
                  color: kPrimaryWhite,
                  minWidth: double.infinity,
                  height: 52,
                  onPressed: () => Navigator.pop(context),
                ).flexible(),
                const HSpace(width: 12.0),
                AppPrimaryButton(
                  text: "Send Nudge 👋",
                  minWidth: double.infinity,
                  height: 52,
                  onPressed: onYesPressed,
                ).flexible(),
              ],
            ),
          ),
          draggableKey: GlobalKey(),
          scrollController: scrollController,
          modalHeaderContent: Row(
            children: [
              Text(
                'Nudge 👋 ${booking.vendor?.greetingName ?? ''}',
              )
                  .semiBold()
                  .fontSize(16)
                  .color(kGrey1200)
                  .alignText(TextAlign.center)
                  .flexible(),
            ],
          ).paddingOnly(left: kWidthPadding, right: kWidthPadding, bottom: 10),
          content: Column(
            children: [
              RichText(
                text: TextSpan(
                    text: 'Send the message below to nudge ',
                    style: kRegularFontStyle.copyWith(
                      fontSize: AppThemeUtil.fontSize(14.0),
                      color: kGrey800,
                      height: AppThemeUtil.getLineHeight(20, 14),
                    ),
                    children: [
                      TextSpan(
                        text: booking.vendor?.greetingName ?? '',
                        style: kBoldFontStyle.copyWith(
                          fontSize: AppThemeUtil.fontSize(14.0),
                          color: kGrey1200,
                          height: AppThemeUtil.getLineHeight(20, 14),
                        ),
                      ),
                      TextSpan(
                        text: ' to react to your request.',
                        style: kRegularFontStyle.copyWith(
                          fontSize: AppThemeUtil.fontSize(14.0),
                          color: kGrey800,
                          height: AppThemeUtil.getLineHeight(20, 14),
                        ),
                      ),
                    ]),
              ),
              const VSpace(height: 20.0),
              Container(
                padding: EdgeInsets.all(AppThemeUtil.radius(24)),
                decoration: BoxDecoration(
                  color: kGrey50,
                  borderRadius: BorderRadius.circular(AppThemeUtil.radius(12)),
                ),
                child: const Text(
                        'Hey! can you please look at my request and respond accordingly thanks.')
                    .regular()
                    .fontSize(14.0)
                    .color(kGrey1200),
              ),
            ],
          ).paddingSymmetric(
            horizontal: kWidthPadding,
            vertical: 20,
          ),
        );
      },
    );
  }
}
