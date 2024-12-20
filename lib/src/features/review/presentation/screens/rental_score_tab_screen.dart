import 'package:aider_mobile_app/core/extensions/widgets/gesture_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/h_space.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/v_space.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/auth/domain/models/statistics/statistic_model.dart';
import '../../../../../core/auth/domain/models/user/user_model.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/common.dart';
import '../../../../../core/routing/app_navigator.dart';
import '../../../../../core/routing/app_route.dart';
import '../../../../../core/utils/app_theme_util.dart';
import '../../../../../core/view_models/base_view.dart';
import '../../../../../core/view_models/user_view_model.dart';
import '../../../../shared_widgets/cards/app_card.dart';
import '../../../../shared_widgets/common/aider_empty_state.dart';
import '../../../../shared_widgets/common/app_load_more.dart';
import '../../../../shared_widgets/common/error_response_message.dart';
import '../../../../shared_widgets/common/network_image_view.dart';
import '../../../../shared_widgets/common/row_text.dart';
import '../../../../shared_widgets/common/svg_icon.dart';
import '../../../../shared_widgets/common/zloading.dart';
import '../../../profile/presentation/widgets/review_rating_widget.dart';
import '../view_models/review_view_model.dart';

class RentalScoreTabScreen extends StatefulWidget {
  const RentalScoreTabScreen({super.key});

  @override
  State<RentalScoreTabScreen> createState() => _RentalScoreTabScreenState();
}

class _RentalScoreTabScreenState extends State<RentalScoreTabScreen> {

  Future<void> fetchRenterReviews([String? nextPage, page = 1]) async {
    if (!mounted) return;
    await context.read<ReviewViewModel>().fetchRenterReviews(context,
        userExternalId: context.read<UserViewModel>().getUser.externalId ?? "",
        queryParam: {
          'page': page,
          'pageSize': kProductPerPage,
        });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await fetchRenterReviews();

    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final statistics = context.read<UserViewModel>().getUser.statistics;
    return BaseView<ReviewViewModel>(
      builder: (context, reviewConsumer, child) {
        if (reviewConsumer
            .getComponentLoading('fetchRenterReviews')) {
          return const Center(
            child: ZLoading(),
          );// const ReviewLoadingEffect();
        }
        if (reviewConsumer
            .isComponentErrorType('fetchRenterReviews')) {
          return Center(
            child: ErrorResponseMessage(
              message: reviewConsumer.componentErrorType?['error'] ?? '',
              onRetry: () async {
                await fetchRenterReviews(reviewConsumer.getRenterReviewsMeta?.next);
              },
            ),
          );
        }

        if(reviewConsumer.getRenterReviews.isEmpty) {
          return Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.20,
            ),
            child: const AiderEmptyState(
              title: '',
              subtitle: 'No Items yet',
            ),
          );
        }
        return RefreshIndicator.adaptive(
          onRefresh: fetchRenterReviews,
          child: AppLoadMore(
            isFinish: reviewConsumer.getRenterReviewsMeta?.next == null,
            onLoadMore: () => fetchRenterReviews(reviewConsumer.getRenterReviewsMeta?.next),
            children: [
              RowText(
                rightWidget: Text('${reviewConsumer.getRenterReviews.length} ${(reviewConsumer.getRenterReviews.length) > 1? 'Reviews':'Review'}').bold().fontSize(16.0).color(kPrimaryBlack),
                leftWidget: Row(
                  children: [
                    ZSvgIcon(
                      'star.svg',
                      color: kWarning700,
                      size: AppThemeUtil.radius(32.0),
                    ),
                    const HSpace(width: 4.0),
                    Text("${statistics?.renterAverageRating ?? 0}").extraBold().fontSize(28).letterSpacing(-0.44).color(kPrimaryBlack),
                  ],
                ),
              ),
              const VSpace(height: 32.0),
              ReviewRatingWidget(
                statistics: statistics ?? const StatisticModel(),
                type: true,
              ),
              const VSpace(height: 32.0),
              ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: reviewConsumer.getRenterReviews.length,
                itemBuilder: (context, index){
                  final review = reviewConsumer.getRenterReviews[index];
                  return AppCard(
                    width: double.infinity,
                    padding: EdgeInsets.all(AppThemeUtil.radius(12)),
                    decoration: ShapeDecoration(
                      color: kGrey50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppThemeUtil.radius(12)),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RowText(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          rightWidget: Text(
                            review.date ?? '',
                          ).regular().fontSize(12).color(kGrey700).alignText(TextAlign.right),
                          leftWidget: Row(
                            children: [
                              (review.reviewer?.hasProfilePhoto == true) ?
                              NetworkImageView(
                                imageUrl: review.reviewer?.profilePhotoUrl ?? '',
                                width: AppThemeUtil.radius(70),
                                height: AppThemeUtil.radius(70),
                                radius: 32.0,
                              ) : CircleAvatar(
                                maxRadius: AppThemeUtil.radius(32.0),
                                backgroundImage: const AssetImage('$kImagePath/profile_placeholder.png'),
                              ),
                              const HSpace(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    review.reviewer?.fullName ?? '',
                                  ).bold().fontSize(14).color(kGrey1200),
                                  const VSpace(height: 8),
                                  Wrap(
                                    runSpacing: 12.0,
                                    children: List.generate(review.rating ?? 0, (index) {
                                      return ZSvgIcon(
                                        'star.svg',
                                        color: kWarning700,
                                        size: AppThemeUtil.radius(14.0),
                                      );
                                    }),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ).onPressed((){
                          AppNavigator.pushNamed(context, AppRoute.vendorProfileScreen, arguments: review.reviewer?? const UserModel());
                        }),
                        const VSpace(height: 12),
                        Text(
                          review.comment ?? '',
                        ).regular().fontSize(14).color(kGrey1200),
                      ],
                    ),
                  ).paddingOnly(bottom: 16.0);
                },
              ),
              const VSpace(height: 16.0),
            ],
          ),
        );
      },
    );
  }
}
