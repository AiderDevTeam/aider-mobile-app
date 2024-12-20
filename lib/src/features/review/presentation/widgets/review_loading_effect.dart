
import 'package:aider_mobile_app/core/extensions/widgets/flexible_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/shimmer_extension.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/v_space.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/utils/app_theme_util.dart';

class ReviewLoadingEffect extends StatelessWidget {
  const ReviewLoadingEffect({
    super.key,
    this.itemCount = 5,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      primary: false,
      // padding: EdgeInsets.symmetric(
      //     horizontal: AppThemeUtil.width(24.0),
      //     vertical: AppThemeUtil.height(24.0)
      // ),
      itemBuilder: (context, index){
        return Container(
          decoration: BoxDecoration(
              border: Border.all(color: kGrey100),
              borderRadius: BorderRadius.circular(AppThemeUtil.radius(20))
          ),
          padding: EdgeInsets.all(AppThemeUtil.radius(16.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: AppThemeUtil.radius(32.0),
                        width: AppThemeUtil.radius(32.0),
                        decoration: BoxDecoration(
                            color: AppThemeUtil.getThemeColor(kPrimaryWhite),
                            borderRadius: BorderRadius.circular(AppThemeUtil.radius(32.0)),
                            border: Border.all(color: kGrey100)
                        ),
                      ).applyShimmer().paddingOnly(right: 12),
                      Container(
                        height: AppThemeUtil.height(12.0),
                        width: AppThemeUtil.width(50.0),
                        decoration: BoxDecoration(
                            color: AppThemeUtil.getThemeColor(kPrimaryWhite),
                            borderRadius: BorderRadius.circular(AppThemeUtil.radius(4.0)),
                            border: Border.all(color: kGrey100)
                        ),
                      ).applyShimmer(),
                    ],
                  ).flexible(),
                  Container(
                    height: AppThemeUtil.height(12.0),
                    width: AppThemeUtil.width(50.0),
                    decoration: BoxDecoration(
                        color: AppThemeUtil.getThemeColor(kPrimaryWhite),
                        borderRadius: BorderRadius.circular(AppThemeUtil.radius(4.0)),
                        border: Border.all(color: kGrey100)
                    ),
                  ).applyShimmer(),
                ],
              ),
              const VSpace(height: 16.0),
              Container(
                height: AppThemeUtil.height(10.0),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppThemeUtil.getThemeColor(kPrimaryWhite),
                    borderRadius: BorderRadius.circular(AppThemeUtil.radius(32.0)),
                    border: Border.all(color: kGrey100)
                ),
              ).applyShimmer(),
              const VSpace(height: 4.0),
              Container(
                height: AppThemeUtil.height(10.0),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppThemeUtil.getThemeColor(kPrimaryWhite),
                    borderRadius: BorderRadius.circular(AppThemeUtil.radius(32.0)),
                    border: Border.all(color: kGrey100)
                ),
              ).applyShimmer(),
              const VSpace(height: 4.0),
              Container(
                height: AppThemeUtil.height(10.0),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppThemeUtil.getThemeColor(kPrimaryWhite),
                    borderRadius: BorderRadius.circular(AppThemeUtil.radius(32.0)),
                    border: Border.all(color: kGrey100)
                ),
              ).applyShimmer(),
              const VSpace(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: AppThemeUtil.height(10.0),
                    width: MediaQuery.of(context).size.width * 0.15,
                    decoration: BoxDecoration(
                        color: AppThemeUtil.getThemeColor(kPrimaryWhite),
                        borderRadius: BorderRadius.circular(AppThemeUtil.radius(32.0)),
                        border: Border.all(color: kGrey100)
                    ),
                  ).applyShimmer(),
                ],
              ),
            ],
          ),
        ).paddingOnly(bottom: 24);
      },
    );
  }
}
