import 'package:aider_mobile_app/core/constants/colors.dart';
import 'package:aider_mobile_app/core/extensions/widgets/flexible_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/core/utils/app_theme_util.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/h_space.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/v_space.dart';
import 'package:flutter/material.dart';
import '../../../../../core/auth/domain/models/statistics/statistic_model.dart';
import '../../../../../core/constants/common.dart';
import '../../../../../core/utils/helper_util.dart';
import '../../../../shared_widgets/cards/app_card.dart';

class ReviewRatingWidget extends StatelessWidget {
  const ReviewRatingWidget({
    super.key,
    required this.statistics,
    this.type = false,
  });

  final StatisticModel statistics;
  final bool type;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: type == false? Column(
        children: [
          Row(
            children: [
              const Text(
                '5',
              ).regular().fontSize(16).letterSpacing(0-.18).height(0.09, 16).color(kPrimaryBlack),
              const HSpace(width: 22),
              ratingLength(
                width: HelperUtil.calculateRatingWidth(
                  statistics.vendorIndividualRatingCounts?.fiveRating?.toInt() ?? 0,
                  statistics.vendorReviewsCount ?? 0,
                ),
              ),
            ],
          ),
          const VSpace(height: 18),
          Row(
            children: [
              const Text(
                '4',
              ).regular().fontSize(16).letterSpacing(0-.18).height(0.09, 16).color(kPrimaryBlack),
              const HSpace(width: 22),
              ratingLength(
                width: HelperUtil.calculateRatingWidth(
                  statistics.vendorIndividualRatingCounts?.fourRating?.toInt() ?? 0,
                  statistics.vendorReviewsCount ?? 0,
                ),
              ),
            ],
          ),
          const VSpace(height: 18),
          Row(
            children: [
              const Text(
                '3',
              ).regular().fontSize(16).letterSpacing(0-.18).height(0.09, 16).color(kPrimaryBlack),
              const HSpace(width: 22),
              ratingLength(
                width: HelperUtil.calculateRatingWidth(
                  statistics.vendorIndividualRatingCounts?.threeRating?.toInt() ?? 0,
                  statistics.vendorReviewsCount ?? 0,
                ),
              ),
            ],
          ),
          const VSpace(height: 18),
          Row(
            children: [
              const Text(
                '2',
              ).regular().fontSize(16).letterSpacing(0-.18).height(0.09, 16).color(kPrimaryBlack),
              const HSpace(width: 22),
              ratingLength(
                width: HelperUtil.calculateRatingWidth(
                  statistics.vendorIndividualRatingCounts?.twoRating?.toInt() ?? 0,
                  statistics.vendorReviewsCount ?? 0,
                ),
              ),
            ],
          ),
          const VSpace(height: 18),
          Row(
            children: [
              const Text(
                '1',
              ).regular().fontSize(16).letterSpacing(0-.18).height(0.09, 16).color(kPrimaryBlack),
              const HSpace(width: 22),
              ratingLength(
                width: HelperUtil.calculateRatingWidth(
                  statistics.vendorIndividualRatingCounts?.oneRating?.toInt() ?? 0,
                  statistics.vendorReviewsCount ?? 0,
                ),
              ),
            ],
          ),
        ],
      ) : Column(
        children: [
          Row(
            children: [
              const Text(
                '5',
              ).regular().fontSize(16).letterSpacing(0-.18).height(0.09, 16).color(kPrimaryBlack),
              const HSpace(width: 22),
              ratingLength(
                width: HelperUtil.calculateRatingWidth(
                  statistics.renterIndividualRatingCounts?.fiveRating?.toInt() ?? 0,
                  statistics.renterReviewsCount ?? 0,
                ),
              ),
            ],
          ),
          const VSpace(height: 18),
          Row(
            children: [
              const Text(
                '4',
              ).regular().fontSize(16).letterSpacing(0-.18).height(0.09, 16).color(kPrimaryBlack),
              const HSpace(width: 22),
              ratingLength(
                width: HelperUtil.calculateRatingWidth(
                  statistics.renterIndividualRatingCounts?.fourRating?.toInt() ?? 0,
                  statistics.renterReviewsCount ?? 0,
                ),
              ),
            ],
          ),
          const VSpace(height: 18),
          Row(
            children: [
              const Text(
                '3',
              ).regular().fontSize(16).letterSpacing(0-.18).height(0.09, 16).color(kPrimaryBlack),
              const HSpace(width: 22),
              ratingLength(
                width: HelperUtil.calculateRatingWidth(
                  statistics.renterIndividualRatingCounts?.threeRating?.toInt() ?? 0,
                  statistics.renterReviewsCount ?? 0,
                ),
              ),
            ],
          ),
          const VSpace(height: 18),
          Row(
            children: [
              const Text(
                '2',
              ).regular().fontSize(16).letterSpacing(0-.18).height(0.09, 16).color(kPrimaryBlack),
              const HSpace(width: 22),
              ratingLength(
                width: HelperUtil.calculateRatingWidth(
                  statistics.renterIndividualRatingCounts?.twoRating?.toInt() ?? 0,
                  statistics.renterReviewsCount ?? 0,
                ),
              ),
            ],
          ),
          const VSpace(height: 18),
          Row(
            children: [
              const Text(
                '1',
              ).regular().fontSize(16).letterSpacing(0-.18).height(0.09, 16).color(kPrimaryBlack),
              const HSpace(width: 22),
              ratingLength(
                width: HelperUtil.calculateRatingWidth(
                  statistics.renterIndividualRatingCounts?.oneRating?.toInt() ?? 0,
                  statistics.renterReviewsCount ?? 0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  ratingLength({double width = 0.0}){
    return Container(
      width: AppThemeUtil.width(kRatingWidth),
      decoration: ShapeDecoration(
        color: kGrey100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppThemeUtil.radius(100)),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: AppThemeUtil.width(width),
            height: AppThemeUtil.height(8),
            decoration: ShapeDecoration(
              color: kPrimaryBlack,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppThemeUtil.radius(100)),
              ),
            ),
          ).flexible(),
        ],
      ),
    );
  }
}
