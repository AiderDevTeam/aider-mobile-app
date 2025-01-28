import 'package:aider_mobile_app/core/extensions/widgets/flexible_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/gesture_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/core/routing/app_navigator.dart';
import 'package:aider_mobile_app/core/routing/app_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/auth/domain/models/user/user_model.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/common.dart';
import '../../../../../core/utils/app_dialog_util.dart';
import '../../../../../core/utils/app_theme_util.dart';
import '../../../../../core/providers/base_view.dart';
import '../../../../../core/providers/user_provider.dart';
import '../../../../shared_widgets/base/app_screen_scaffold.dart';
import '../../../../shared_widgets/buttons/app_primary_button.dart';
import '../../../../shared_widgets/cards/app_card.dart';
import '../../../../shared_widgets/common/app_bottom_nav_wrapper.dart';
import '../../../../shared_widgets/common/h_space.dart';
import '../../../../shared_widgets/common/network_image_view.dart';
import '../../../../shared_widgets/common/row_text.dart';
import '../../../../shared_widgets/common/svg_icon.dart';
import '../../../../shared_widgets/common/v_space.dart';
import '../../../review/presentation/view_models/review_view_model.dart';
import '../../domain/models/product/product_model.dart';
import '../view_models/product_view_model.dart';
import 'product_detail_carousel.dart';
import 'renting/renting_modal.dart';

class ProductDetailsBody extends StatefulWidget {
  const ProductDetailsBody({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  State<ProductDetailsBody> createState() => _ProductDetailsBodyState();
}

class _ProductDetailsBodyState extends State<ProductDetailsBody> {
  Future<void> fetchVendorReviews([String? nextPage, page = 1]) async {
    if (!mounted) return;
    await context.read<ReviewViewModel>().fetchVendorReviews(
      context,
      userExternalId: widget.product.user?.externalId ?? '',
      queryParam: {
        'page': page,
        'pageSize': kProductPerPage,
      },
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await fetchVendorReviews();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScreenScaffold(
      bottomNavigationBar: AppBottomNavWrapper(
        child: AppPrimaryButton(
          onPressed: () {
            final user = context.read<UserProvider>().getUser;
            if (user.externalId == widget.product.user!.externalId) {
              AppDialogUtil.showWarningAlert(
                  context, "Oops! You can't rent your own item");
              return;
            }
            // if (user.idVerificationStatus != kCompletedStatus) {
            //   AppNavigator.pushNamed(context, AppRoute.verifyIdentityScreen);
            //   return;
            // }
            // if(user.userHasWallet == false){
            //   AppNavigator.pushNamed(context, AppRoute.paymentScreen);
            //   return;
            // }

            context.read<ProductViewModel>().removeDates();
            context.read<ProductViewModel>().setQuantity = 1;
            AppDialogUtil.showScrollableBottomSheet(
              context: context,
              builder: (context) => RentingModal(product: widget.product),
            );
          },
          text: 'Check availability and price',
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const VSpace(height: 12.0),
            ProductDetailCarousel(product: widget.product),
            const VSpace(height: 25.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.product.name ?? '')
                    .medium()
                    .fontSize(16.0)
                    .color(kGrey1200)
                    .flexible(),
                const HSpace(width: 116.0),
                // Container(
                //   height: AppThemeUtil.radius(44.0),
                //   width: AppThemeUtil.radius(44.0),
                //   padding: EdgeInsets.all(AppThemeUtil.radius(10.0)),
                //   decoration: BoxDecoration(
                //     color: kGrey50,
                //     borderRadius: BorderRadius.circular(AppThemeUtil.radius(12.0)),
                //   ),
                //   child: ZSvgIcon(
                //     'share.svg',
                //     color: kGrey1200,
                //     size: AppThemeUtil.radius(24.0),
                //   ),
                // ),
              ],
            ).paddingSymmetric(horizontal: kWidthPadding),
            const VSpace(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                (widget.product.prices?.length ?? 0),
                (index) {
                  final price = widget.product.prices![index];
                  // Calculate the total days
                  int totalDays;
                  if (price.endDay != null) {
                    totalDays = price.endDay! - price.startDay! + 1;
                  } else {
                    totalDays = 999; // Representing 30+
                  }

                  // Define the text to display based on totalDays
                  String dailyText;
                  if (totalDays >= 1 && totalDays <= 6) {
                    dailyText = 'Daily';
                  } else if (totalDays >= 7 && totalDays <= 29) {
                    dailyText = '7+';
                  } else {
                    dailyText = '30+';
                  }

                  String duration;
                  if (totalDays >= 1 && totalDays <= 6) {
                    duration = 'per day';
                  } else if (totalDays >= 7 && totalDays <= 29) {
                    duration = 'per week';
                  } else {
                    duration = 'per month';
                  }

                  return Container(
                    height: AppThemeUtil.radius(92.0),
                    width: double.infinity,
                    padding: EdgeInsets.all(AppThemeUtil.radius(12.0)),
                    margin: EdgeInsets.only(
                      left: index == 0 ? 0 : AppThemeUtil.width(6),
                      right: index == 2 ? 0 : AppThemeUtil.width(6),
                    ),
                    decoration: BoxDecoration(
                      color: kGrey50,
                      borderRadius:
                          BorderRadius.circular(AppThemeUtil.radius(12.0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(dailyText).regular().fontSize(12).color(kGrey600),
                        Text('$kCurrency ${price.price}')
                            .bold()
                            .fontSize(16)
                            .color(kGrey1200),
                        Text(duration)
                            .regular()
                            .fontSize(12.0)
                            .color(kGrey1200),
                      ],
                    ),
                  ).flexible();
                },
              ),
            ).paddingSymmetric(horizontal: kWidthPadding),
            const VSpace(height: 20.0),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(AppThemeUtil.radius(12.0)),
              decoration: BoxDecoration(
                color: kGrey50,
                borderRadius: BorderRadius.circular(AppThemeUtil.radius(12.0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('DESCRIPTION')
                      .bold()
                      .fontSize(12.0)
                      .color(kGrey700),
                  const VSpace(height: 12.0),
                  Text('${widget.product.description}')
                      .regular()
                      .fontSize(14.0)
                      .color(kGrey1200),

                  // const VSpace(height: 12.0),
                  // const Text('See more').semiBold().fontSize(16.0).color(kGrey1200).alignBottomCenter(),
                ],
              ),
            ).paddingSymmetric(horizontal: kWidthPadding),
            const VSpace(height: 20.0),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(AppThemeUtil.radius(12.0)),
              decoration: BoxDecoration(
                color: kGrey50,
                borderRadius: BorderRadius.circular(AppThemeUtil.radius(12.0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('ITEM OWNER')
                      .bold()
                      .fontSize(12.0)
                      .color(kGrey700),
                  const VSpace(height: 12.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          (!widget.product.user!.hasProfilePhoto)
                              ? CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  maxRadius: AppThemeUtil.radius(26),
                                  backgroundImage: const AssetImage(
                                      "$kImagePath/profile_placeholder.png"),
                                )
                              : NetworkImageView(
                                  imageUrl:
                                      widget.product.user!.profilePhotoUrl ??
                                          '',
                                  width: AppThemeUtil.radius(52),
                                  height: AppThemeUtil.radius(52),
                                  radius: 26.0,
                                ),
                          const HSpace(width: 12.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.product.user?.displayName ?? '')
                                  .bold()
                                  .fontSize(14.0)
                                  .color(kGrey1200)
                                  .overflowText(TextOverflow.ellipsis),
                              Row(
                                children: [
                                  ZSvgIcon(
                                    'star.svg',
                                    size: AppThemeUtil.radius(14.0),
                                  ),
                                  const HSpace(width: 4.0),
                                  Text('${widget.product.user?.statistics?.vendorAverageRating ?? 0.0}')
                                      .regular()
                                      .fontSize(12.0)
                                      .color(kGrey700),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ).flexible(),
                      Container(
                        height: AppThemeUtil.radius(44.0),
                        width: AppThemeUtil.radius(44.0),
                        padding: EdgeInsets.all(AppThemeUtil.radius(10.0)),
                        decoration: BoxDecoration(
                          color: kGrey200,
                          borderRadius:
                              BorderRadius.circular(AppThemeUtil.radius(12.0)),
                        ),
                        child: ZSvgIcon(
                          'profile_outline.svg',
                          color: kGrey1200,
                          size: AppThemeUtil.radius(24.0),
                        ),
                      ),
                    ],
                  ),
                ],
              ).onPressed(() {
                AppNavigator.pushNamed(context, AppRoute.vendorProfileScreen,
                    arguments: widget.product.user ?? const UserModel());
              }),
            ).paddingSymmetric(horizontal: kWidthPadding),
            const VSpace(height: 20.0),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(AppThemeUtil.radius(12.0)),
              decoration: BoxDecoration(
                color: kGrey50,
                borderRadius: BorderRadius.circular(AppThemeUtil.radius(12.0)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.product.address?.originName ?? '')
                      .medium()
                      .fontSize(14.0)
                      .color(kGrey1200)
                      .flexible(),
                  const HSpace(width: 12.0),
                  Container(
                    height: AppThemeUtil.radius(44.0),
                    width: AppThemeUtil.radius(44.0),
                    padding: EdgeInsets.all(AppThemeUtil.radius(10.0)),
                    decoration: BoxDecoration(
                      color: kGrey200,
                      borderRadius:
                          BorderRadius.circular(AppThemeUtil.radius(12.0)),
                    ),
                    child: ZSvgIcon(
                      'map.svg',
                      color: kGrey1200,
                      size: AppThemeUtil.radius(24.0),
                    ),
                  ),
                ],
              ),
            ).paddingSymmetric(horizontal: kWidthPadding),
            // const VSpace(height: 64.0),
            // const Text('Other listings from Charles').bold().fontSize(20.0).color(kGrey1200).alignCenterLeft().paddingSymmetric(horizontal: kWidthPadding),
            // const VSpace(height: 20.0),
            // AppPrimaryButton(
            //   onPressed: (){},
            //   text: 'See all listings from Charles',
            //   height: 40.0,
            //   fontSize: 14.0,
            //   color: kPrimaryWhite,
            //   textColor: kGrey1000,
            //   borderColor: kGrey700,
            // ),
            const VSpace(height: 32.0),
            BaseView<ReviewViewModel>(
                builder: (context, reviewConsumer, child) {
              if (reviewConsumer.getVendorReviews.isEmpty) {
                return const SizedBox.shrink();
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${widget.product.user?.displayName ?? ''}`s review")
                      .bold()
                      .fontSize(14.0)
                      .color(kGrey1200)
                      .overflowText(TextOverflow.ellipsis),
                  const VSpace(height: 24.0),
                  ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: reviewConsumer.getVendorReviews.length,
                    itemBuilder: (context, index) {
                      final review = reviewConsumer.getVendorReviews[index];
                      return AppCard(
                        width: double.infinity,
                        padding: EdgeInsets.all(AppThemeUtil.radius(12)),
                        decoration: ShapeDecoration(
                          color: kGrey50,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(AppThemeUtil.radius(12)),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RowText(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              rightWidget: Text(
                                review.date ?? '',
                              )
                                  .regular()
                                  .fontSize(12)
                                  .color(kGrey700)
                                  .alignText(TextAlign.right),
                              leftWidget: Row(
                                children: [
                                  (review.reviewer?.hasProfilePhoto == true)
                                      ? NetworkImageView(
                                          imageUrl: review
                                                  .reviewer?.profilePhotoUrl ??
                                              '',
                                          width: AppThemeUtil.radius(70),
                                          height: AppThemeUtil.radius(70),
                                          radius: 32.0,
                                        )
                                      : CircleAvatar(
                                          maxRadius: AppThemeUtil.radius(32.0),
                                          backgroundImage: const AssetImage(
                                              '$kImagePath/profile_placeholder.png'),
                                        ),
                                  const HSpace(width: 12),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        review.reviewer?.fullName ?? '',
                                      ).bold().fontSize(14).color(kGrey1200),
                                      const VSpace(height: 8),
                                      Wrap(
                                        runSpacing: 12.0,
                                        children: List.generate(
                                            review.rating ?? 0, (index) {
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
                            ).onPressed(() {
                              AppNavigator.pushNamed(
                                  context, AppRoute.vendorProfileScreen,
                                  arguments:
                                      review.reviewer ?? const UserModel());
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
                ],
              ).paddingSymmetric(horizontal: kWidthPadding);
            }),
            // Text("${product.user?.displayName?? ''}`s review").bold().fontSize(14.0).color(kGrey1200).overflowText(TextOverflow.ellipsis).paddingSymmetric(horizontal: kWidthPadding),
            // const VSpace(height: 24.0),
          ],
        ),
      ),
    );
  }
}
