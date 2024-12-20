import 'package:aider_mobile_app/core/constants/colors.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/core/utils/app_theme_util.dart';
import 'package:aider_mobile_app/src/shared_widgets/cards/app_card.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/v_space.dart';
import 'package:flutter/material.dart';

class DaysRemainingCard extends StatelessWidget {
  const DaysRemainingCard({
    super.key,
    this.textColor,
    this.numberOfDays,
    this.cardColor,
    this.overDue,
  });
  final Color? textColor;
  final String? numberOfDays;
  final Color? cardColor;
  final String? overDue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppCard(
          width: double.infinity,
          height: AppThemeUtil.height(40),
          padding: EdgeInsets.symmetric(horizontal: AppThemeUtil.width(14), vertical: AppThemeUtil.height(10)),
          decoration: ShapeDecoration(
            color: cardColor ?? kGrey100,
            shape: RoundedRectangleBorder(
              // side: BorderSide(width: AppThemeUtil.width(1), color: kGrey200),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.access_time_filled_rounded, size: AppThemeUtil.radius(20), color: textColor?? kGrey700,),
              const VSpace(height: 4),
              Text(
                overDue ??'$numberOfDays days remaining',
              ).bold().fontSize(14).color(textColor??kGrey700)
            ],
          ),
        ),
        // AppTextButton(
        //   text: 'Return Now',
        //   fontSize: 14,
        //   textColor: kError700,
        //   onPressed: (){
        //     AppDialogUtil.showScrollableBottomSheet(
        //       context: context,
        //       builder: (context) => ConfirmPickupModal(
        //         title: 'Are you sure you want to return\nthis item 2 days early, there will be no\nrefunds',
        //         onYesPressed: (){},
        //       ),
        //     );
        //   },
        // )
      ],
    );
  }
}
