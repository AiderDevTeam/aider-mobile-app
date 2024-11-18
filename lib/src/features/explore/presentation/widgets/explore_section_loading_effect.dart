

import 'package:aider_mobile_app/core/extensions/widgets/flexible_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/shimmer_extension.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/v_space.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/utils/app_theme_util.dart';
import '../../../../shared_widgets/common/h_space.dart';


class ExploreSectionLoadingEffect extends StatelessWidget {
  const ExploreSectionLoadingEffect({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        primary: false,
        // physics: const NeverScrollableScrollPhysics(),
        itemCount: 1,
        padding: EdgeInsets.only(top: AppThemeUtil.height(20)),
        itemBuilder: (context, index) {
          return Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: AppThemeUtil.height(16),
                    padding: EdgeInsets.all(AppThemeUtil.radius(20.0)),
                    margin: EdgeInsets.only(bottom: AppThemeUtil.height(16.0)),
                    decoration: BoxDecoration(
                        color: AppThemeUtil.getThemeColor(kPrimaryWhite),
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(color: kGrey100)
                    ),
                  ).applyShimmer().flexible(flex: 7),
                  const HSpace(width: 60),
                  Container(
                    height: AppThemeUtil.height(15),
                    padding: EdgeInsets.all(AppThemeUtil.radius(20.0)),
                    margin: EdgeInsets.only(bottom: AppThemeUtil.height(16.0)),
                    decoration: BoxDecoration(
                        color: AppThemeUtil.getThemeColor(kPrimaryWhite),
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(color: kGrey100)
                    ),
                  ).applyShimmer().flexible(flex: 3),
                ],
              ),

              const VSpace(height: 24.0),

              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: double.infinity,
                    height: AppThemeUtil.height(110),
                    decoration: BoxDecoration(
                        color: AppThemeUtil.getThemeColor(kPrimaryWhite),
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(color: kGrey100)
                    ),
                  ).applyShimmer().flexible(),
                  const HSpace(width: 12),
                  Container(
                    width: double.infinity,
                    height: AppThemeUtil.height(110),
                    decoration: BoxDecoration(
                        color: AppThemeUtil.getThemeColor(kPrimaryWhite),
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(color: kGrey100)
                    ),
                  ).applyShimmer().flexible(),
                  const HSpace(width: 12),
                  Container(
                    width: double.infinity,
                    height: AppThemeUtil.height(110),
                    decoration: BoxDecoration(
                        color: AppThemeUtil.getThemeColor(kPrimaryWhite),
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(color: kGrey100)
                    ),
                  ).applyShimmer().flexible(),
                ],
              ),

              const VSpace(height: 48.0),

              Container(
                width: double.infinity,
                height: AppThemeUtil.height(350),
                decoration: BoxDecoration(
                    color: AppThemeUtil.getThemeColor(kPrimaryWhite),
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: kGrey100)
                ),
              ).applyShimmer(),

              const VSpace(height: 48.0),

              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: AppThemeUtil.height(16),
                    padding: EdgeInsets.all(AppThemeUtil.radius(20.0)),
                    margin: EdgeInsets.only(bottom: AppThemeUtil.height(16.0)),
                    decoration: BoxDecoration(
                        color: AppThemeUtil.getThemeColor(kPrimaryWhite),
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(color: kGrey100)
                    ),
                  ).applyShimmer().flexible(flex: 7),
                  const HSpace(width: 60),
                  Container(
                    height: AppThemeUtil.height(15),
                    padding: EdgeInsets.all(AppThemeUtil.radius(20.0)),
                    margin: EdgeInsets.only(bottom: AppThemeUtil.height(16.0)),
                    decoration: BoxDecoration(
                        color: AppThemeUtil.getThemeColor(kPrimaryWhite),
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(color: kGrey100)
                    ),
                  ).applyShimmer().flexible(flex: 3),
                ],
              ),
              const VSpace(height: 24.0),

              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: AppThemeUtil.height(200),
                        decoration: BoxDecoration(
                            color: AppThemeUtil.getThemeColor(kPrimaryWhite),
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(color: kGrey100)
                        ),
                      ).applyShimmer(),
                      const VSpace(height: 12.0),
                      Container(
                        width: double.infinity,
                        height: AppThemeUtil.height(12),
                        decoration: BoxDecoration(
                            color: AppThemeUtil.getThemeColor(kPrimaryWhite),
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(color: kGrey100)
                        ),
                      ).applyShimmer(),
                      const VSpace(height: 4.0),
                      Container(
                        width: double.infinity,
                        height: AppThemeUtil.height(12),
                        decoration: BoxDecoration(
                            color: AppThemeUtil.getThemeColor(kPrimaryWhite),
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(color: kGrey100)
                        ),
                      ).applyShimmer(),
                      const VSpace(height: 4.0),
                      Container(
                        width: AppThemeUtil.width(50),
                        height: AppThemeUtil.height(12),
                        decoration: BoxDecoration(
                            color: AppThemeUtil.getThemeColor(kPrimaryWhite),
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(color: kGrey100)
                        ),
                      ).applyShimmer(),
                    ],
                  ).flexible(),
                  const HSpace(width: 12),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: AppThemeUtil.height(200),
                        decoration: BoxDecoration(
                            color: AppThemeUtil.getThemeColor(kPrimaryWhite),
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(color: kGrey100)
                        ),
                      ).applyShimmer(),
                      const VSpace(height: 12.0),
                      Container(
                        width: double.infinity,
                        height: AppThemeUtil.height(12),
                        decoration: BoxDecoration(
                            color: AppThemeUtil.getThemeColor(kPrimaryWhite),
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(color: kGrey100)
                        ),
                      ).applyShimmer(),
                      const VSpace(height: 4.0),
                      Container(
                        width: double.infinity,
                        height: AppThemeUtil.height(12),
                        decoration: BoxDecoration(
                            color: AppThemeUtil.getThemeColor(kPrimaryWhite),
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(color: kGrey100)
                        ),
                      ).applyShimmer(),
                      const VSpace(height: 4.0),
                      Container(
                        width: AppThemeUtil.width(50),
                        height: AppThemeUtil.height(12),
                        decoration: BoxDecoration(
                            color: AppThemeUtil.getThemeColor(kPrimaryWhite),
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(color: kGrey100)
                        ),
                      ).applyShimmer(),
                    ],
                  ).flexible(),
                ],
              ),

              const VSpace(height: 24.0),
            ],
          ).paddingOnly(bottom: 16);
        }
    );
  }
}
