
import 'package:aider_mobile_app/core/extensions/widgets/flexible_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/shimmer_extension.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/h_space.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/utils/app_theme_util.dart';
import '../../../../shared_widgets/cards/app_card.dart';
import '../../../../shared_widgets/common/v_space.dart';


class InboxLoadingEffect extends StatelessWidget {
  const InboxLoadingEffect({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        primary: false,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 12,
        padding: EdgeInsets.only(
          bottom: AppThemeUtil.height(20),
        ),
        itemBuilder: (context, index) {
          return AppCard(
            padding: EdgeInsets.all(AppThemeUtil.radius(12.0)),
            backgroundColor: kGrey50,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: AppThemeUtil.radius(64),
                      height: AppThemeUtil.radius(64),
                      decoration: BoxDecoration(
                        color: AppThemeUtil.getThemeColor(kPrimaryWhite),
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(color: kGrey100)
                      ),
                    ).applyShimmer(),
                    const HSpace(width: 12.0),
                    Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: AppThemeUtil.height(10),
                          decoration: BoxDecoration(
                              color: AppThemeUtil.getThemeColor(kPrimaryWhite),
                              borderRadius: BorderRadius.circular(4.0),
                              border: Border.all(color: kGrey100)
                          ),
                        ).applyShimmer(),
                        const VSpace(height: 12),
                        Container(
                          width: double.infinity,
                          height: AppThemeUtil.height(10),
                          decoration: BoxDecoration(
                              color: AppThemeUtil.getThemeColor(kPrimaryWhite),
                              borderRadius: BorderRadius.circular(4.0),
                              border: Border.all(color: kGrey100)
                          ),
                        ).applyShimmer(),
                      ],
                    ).flexible(),
                  ],
                ),
                const VSpace(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                    width: AppThemeUtil.width(100),
                    height: AppThemeUtil.height(10),
                    decoration: BoxDecoration(
                        color: AppThemeUtil.getThemeColor(kPrimaryWhite),
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(color: kGrey100)
                    ),
                  ).applyShimmer(),
                    const HSpace(width: 12.0),
                    Container(
                      width: AppThemeUtil.radius(24),
                      height: AppThemeUtil.radius(24),
                      decoration: BoxDecoration(
                          color: AppThemeUtil.getThemeColor(kPrimaryWhite),
                          borderRadius: BorderRadius.circular(100.0),
                          border: Border.all(color: kGrey100)
                      ),
                    ).applyShimmer(),
                  ],
                ),
              ],
            ),
          ).paddingOnly(bottom: 32);
        }
    );
  }
}
