import 'package:aider_mobile_app/core/extensions/widgets/gesture_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/core/utils/app_theme_util.dart';
import 'package:aider_mobile_app/src/shared_widgets/cards/app_card.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/h_space.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/v_space.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../shared_widgets/common/svg_icon.dart';

class KycStatusCard extends StatelessWidget {
  const KycStatusCard({
    super.key,
    required this.statusColor,
    required this.statusBorderColor,
    required this.statusTypeColor,
    required this.statusType,
    this.isRejected = false,
    required this.type,
    this.tryAgain,
  });
  final Color statusColor;
  final Color statusBorderColor;
  final Color statusTypeColor;
  final Widget statusType;
  final bool isRejected;
  final String type;
  final Widget? tryAgain;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.all(AppThemeUtil.radius(20)),
      decoration: ShapeDecoration(
        // color: const Color(0xFFFEF4E6),
        color: statusColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: AppThemeUtil.width(1),
            // color: const Color(0xFFFCDAAD),
            color: statusBorderColor,
          ),
          borderRadius: BorderRadius.circular(
            AppThemeUtil.radius(12),
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ZSvgIcon(
                    "UserFocus.svg",
                    size: AppThemeUtil.radius(28.0),
                  ),
                  const HSpace(width: 12),
                  Text(
                    type,
                  ).semiBold().fontSize(14).letterSpacing(-0.15).color(kGrey1200),
                ],
              ),
              (isRejected)?Row(
                children: [
                  const Text("Re-submit").semiBold().fontSize(14).letterSpacing(-0.15).color(kGrey600),
                  const HSpace(width: 8),
                  Icon(CupertinoIcons.forward, color: kGrey600, size: AppThemeUtil.radius(32),)
                ],
              ).onPressed((){

              }) : const SizedBox.shrink()
            ],
          ),
          const VSpace(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Verification status',
              ).semiBold().fontSize(14).letterSpacing(-0.15).color(kGrey1200),
              AppCard(
                  padding: EdgeInsets.symmetric(horizontal: AppThemeUtil.width(12), vertical: AppThemeUtil.height(10)),
                  decoration: ShapeDecoration(
                    // color: Color(0xFFFAB55B),
                    color: statusTypeColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppThemeUtil.radius(100)),
                    ),
                  ),
                  child: statusType
              )
            ],
          ),
          const VSpace(height: 16),
          (isRejected == true) ? tryAgain?? const  SizedBox.shrink() : const SizedBox.shrink()
        ],
      ),
    );
  }

  Widget statusCard({statusColor, statusBorderColor, statusTypeColor, statusType}){
    return AppCard(
      padding: EdgeInsets.all(AppThemeUtil.radius(20)),
      decoration: ShapeDecoration(
        // color: const Color(0xFFFEF4E6),
        color: statusColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: AppThemeUtil.width(1),
            // color: const Color(0xFFFCDAAD),
            color: statusBorderColor,
          ),
          borderRadius: BorderRadius.circular(
            AppThemeUtil.radius(12),
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              ZSvgIcon(
                "UserFocus.svg",
                size: AppThemeUtil.radius(28.0),
              ),
              const HSpace(width: 12),
              const Text(
                'BVN',
              ).semiBold().fontSize(14).letterSpacing(-0.15).color(kGrey1200),
            ],
          ),
          const VSpace(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Verification status',
              ).semiBold().fontSize(14).letterSpacing(-0.15).color(kGrey1200),
              AppCard(
                padding: EdgeInsets.symmetric(horizontal: AppThemeUtil.width(12), vertical: AppThemeUtil.height(10)),
                decoration: ShapeDecoration(
                  // color: Color(0xFFFAB55B),
                  color: statusTypeColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppThemeUtil.radius(100)),
                  ),
                ),
                child: statusType
                // const Text(
                //   'Pending',
                // ).semiBold().fontSize(14).letterSpacing(-0.15).color(kPrimaryWhite),
              )
            ],
          )
        ],
      ),
    );
  }
}
