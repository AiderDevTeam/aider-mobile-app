import 'package:aider_mobile_app/core/extensions/widgets/gesture_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/aider_empty_state.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/h_space.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/v_space.dart';
import 'package:flutter/material.dart';

import '../../../../../core/auth/domain/models/user/user_model.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/common.dart';
import '../../../../../core/routing/app_navigator.dart';
import '../../../../../core/routing/app_route.dart';
import '../../../../../core/utils/app_theme_util.dart';
import '../../../../shared_widgets/base/draggable_bottom_sheet.dart';
import '../../../../shared_widgets/cards/app_card.dart';
import '../../../../shared_widgets/common/network_image_view.dart';
import '../../../../shared_widgets/common/row_text.dart';
import '../../../../shared_widgets/common/svg_icon.dart';
import '../../../../shared_widgets/modals/draggable_bottom_sheet_content.dart';
import '../../../review/domain/review/review_model.dart';

class SeeRentersReview extends StatefulWidget {
  const SeeRentersReview({
    super.key,
    required this.renterReview,
  });

  final ReviewModel renterReview;

  @override
  State<SeeRentersReview> createState() => _SeeRentersReviewState();
}

class _SeeRentersReviewState extends State<SeeRentersReview> {
  @override
  Widget build(BuildContext context) {
    final review = widget.renterReview;
    return DraggableBottomSheet(
      initialChildSize: 0.30,
      minChildSize: 0.25,
      maxChildSize: 0.58,
      builder: (context, scrollController) {
        return DraggableBottomSheetContent(
          draggableKey: GlobalKey(),
          scrollController: scrollController,
          title: "Renter’s review",
          content: SingleChildScrollView(
            child: Column(
              children: [
                AppCard(
                        width: double.infinity,
                        padding: EdgeInsets.all(AppThemeUtil.radius(12)),
                        decoration: ShapeDecoration(
                          color: kGrey50,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(AppThemeUtil.radius(12)),
                          ),
                        ),
                        child: (review.comment != null)
                            ? Column(
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
                              )
                            : const AiderEmptyState(
                              title: "",
                              subtitle: "No Review Yet",

                            ))
                    .paddingAll(AppThemeUtil.radius(20)),
              ],
            ),
          ),
        );
      },
    );
  }
}
