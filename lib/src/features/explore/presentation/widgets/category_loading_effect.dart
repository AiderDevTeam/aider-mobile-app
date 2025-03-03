

import 'package:aider_mobile_app/core/constants/common.dart';
import 'package:aider_mobile_app/core/extensions/widgets/flexible_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/shimmer_extension.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/utils/app_theme_util.dart';
import '../../../../shared_widgets/common/h_space.dart';


class CategoryLoadingEffect extends StatelessWidget {
  const CategoryLoadingEffect({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        primary: false,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 20,
        padding: EdgeInsets.only(
          top: AppThemeUtil.height(20),
          left: AppThemeUtil.width(kWidthPadding),
          right: AppThemeUtil.width(kWidthPadding),
        ),
        itemBuilder: (context, index) {
          return Column(
            children: [
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
            ],
          ).paddingOnly(bottom: 32);
        }
    );
  }
}
