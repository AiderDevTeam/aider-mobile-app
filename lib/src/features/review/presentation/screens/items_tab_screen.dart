import 'package:aider_mobile_app/core/extensions/widgets/gesture_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/app_list_tile.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/h_space.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/v_space.dart';
import 'package:flutter/cupertino.dart';
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

class ItemsTabScreen extends StatefulWidget {
  const ItemsTabScreen({super.key, required this.vendor});
  final UserModel vendor;

  @override
  State<ItemsTabScreen> createState() => _ItemsTabScreenState();
}

class _ItemsTabScreenState extends State<ItemsTabScreen> {
  Future<void> fetchVendorProductsAndReviews([String? nextPage, page = 1]) async {
    if (!mounted) return;
    await context.read<ReviewViewModel>().fetchVendorProductsAndReviews(context,
        userExternalId: widget.vendor.externalId,
        queryParam: {
          'page': page,
          'pageSize': kProductPerPage,
        });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await fetchVendorProductsAndReviews();

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final statistics = widget.vendor.statistics;
    return BaseView<ReviewViewModel>(
      builder: (context, reviewConsumer, child) {
        if (reviewConsumer
            .getComponentLoading('fetchVendorProductsAndReview')) {
          return const Center(
            child: ZLoading(),
          );// const ReviewLoadingEffect();
        }
        if (reviewConsumer
            .isComponentErrorType('fetchVendorProductsAndReview')) {
          return Center(
            child: ErrorResponseMessage(
              message: reviewConsumer.componentErrorType?['error'] ?? '',
              onRetry: () async {
                await fetchVendorProductsAndReviews(reviewConsumer.getVendorProductAndReviewsMeta?.next);
              },
            ),
          );
        }

        if(reviewConsumer.getVendorProductsAndReviews.isEmpty) {
          return Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.20,
            ),
            child:  AiderEmptyState(
              title: '',
              subtitle: 'No reviews yet',
              iconWidget: ZSvgIcon(
                'star.svg',
                color: kPrimaryBlack,
                size: AppThemeUtil.radius(20),
              ),
            ).paddingOnly(bottom: 48),
          );
        }
        return RefreshIndicator.adaptive(
          onRefresh: fetchVendorProductsAndReviews,
          child: AppLoadMore(
            isFinish: reviewConsumer.getVendorProductAndReviewsMeta?.next == null,
            onLoadMore: () => fetchVendorProductsAndReviews(reviewConsumer.getVendorProductAndReviewsMeta?.next),
            children: [
              RowText(
                rightWidget: Text('${reviewConsumer.getVendorProductsAndReviews.length} ${(reviewConsumer.getVendorProductsAndReviews.length) > 1? 'Reviews':'Review'}').bold().fontSize(16.0).color(kPrimaryBlack),
                leftWidget: Row(
                  children: [
                    ZSvgIcon(
                      'star.svg',
                      color: kWarning700,
                      size: AppThemeUtil.radius(32.0),
                    ),
                    const HSpace(width: 4.0),
                    Text("${statistics?.vendorAverageRating ?? 0}").extraBold().fontSize(28).letterSpacing(-0.44).color(kPrimaryBlack),
                  ],
                ),
              ),
              const VSpace(height: 32.0),
              ReviewRatingWidget(
                statistics: statistics ?? const StatisticModel(),
              ),
              const VSpace(height: 32.0),
              ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: reviewConsumer.getVendorProductsAndReviews.length,
                itemBuilder: (context, index){
                  final product = reviewConsumer.getVendorProductsAndReviews[index];
                  final review = product.reviews?[0];
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
                            review?.date ?? '',
                          ).regular().fontSize(12).color(kGrey700).alignText(TextAlign.right),
                          leftWidget: Row(
                            children: [
                              (review?.reviewer?.hasProfilePhoto == true) ?
                              NetworkImageView(
                                imageUrl: review?.reviewer?.profilePhotoUrl ?? '',
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
                                    review?.reviewer?.fullName ?? '',
                                  ).bold().fontSize(14).color(kGrey1200),
                                  const VSpace(height: 8),
                                  Wrap(
                                    runSpacing: 12.0,
                                    children: List.generate(review?.rating ?? 0, (index) {
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
                          ).onPressed((){
                            AppNavigator.pushNamed(context, AppRoute.vendorProfileScreen, arguments: review?.reviewer?? const UserModel());
                          }),
                        ),
                        const VSpace(height: 12),
                        Text(
                          review?.comment ?? '',
                        ).regular().fontSize(14).color(kGrey1200),
                        const VSpace(height: 12),
                        AppCard(
                          padding: const EdgeInsets.all(12),
                          decoration: ShapeDecoration(
                            color: kGrey200,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppThemeUtil.radius(8))),
                          ),
                          child: AppListTile(
                            leading: product.hasPhotos ?
                            NetworkImageView(
                              imageUrl: product.hasPhotos? (product.photos?.first.photoUrl?? '') : '',
                              width: AppThemeUtil.radius(44),
                              height: AppThemeUtil.radius(44),
                              radius: 3.54,
                            ): Container(
                              width: AppThemeUtil.width(44),
                              height: AppThemeUtil.height(44),
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: Colors.black.withOpacity(0.30000001192092896),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3.54),
                                ),
                              ),
                            ),
                            title: Text(
                              product.name ?? '',
                            ).regular().fontSize(14).color(kGrey1200),
                            subtitle: Text(
                              product.getFirstPrice,
                            ).semiBold().fontSize(14).color(kGrey1200),
                            trailing: const Icon(CupertinoIcons.forward),
                            onTap: (){
                              AppNavigator.pushNamed(context, AppRoute.productDetailScreen, arguments: product);
                            },
                          ),
                        )
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
