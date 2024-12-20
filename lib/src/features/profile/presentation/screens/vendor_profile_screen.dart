
import 'package:aider_mobile_app/core/constants/colors.dart';
import 'package:aider_mobile_app/core/constants/common.dart';
import 'package:aider_mobile_app/core/extensions/widgets/flexible_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/core/utils/app_theme_util.dart';
import 'package:aider_mobile_app/src/features/profile/presentation/widgets/vendor_listed_product_tab.dart';
import 'package:aider_mobile_app/src/features/profile/presentation/widgets/vendor_profile_tabs.dart';
import 'package:aider_mobile_app/src/shared_widgets/base/app_screen_scaffold.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/h_space.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/svg_icon.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/v_space.dart';
import 'package:flutter/material.dart';
import '../../../../../core/auth/domain/models/user/user_model.dart';
import '../../../../shared_widgets/common/network_image_view.dart';
import '../../../review/presentation/screens/items_tab_screen.dart';

class VendorProfileScreen extends StatefulWidget {
  const VendorProfileScreen({super.key, required this.user,});

  final UserModel user;

  @override
  State<VendorProfileScreen> createState() => _VendorProfileScreenState();
}

class _VendorProfileScreenState extends State<VendorProfileScreen> with TickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.user;

    return AppScreenScaffold(
      title: 'Profile',
      child: NestedScrollView(
        headerSliverBuilder: (context, _) {
          return [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const VSpace(height: 12.0),
                      DecoratedBox(
                        decoration: BoxDecoration(
                            color: kPrimaryWhite,
                            borderRadius: BorderRadius.circular(AppThemeUtil.radius(12))
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                (!user.hasProfilePhoto)?
                                CircleAvatar(
                                  backgroundColor: kGrey200,
                                  maxRadius: AppThemeUtil.radius(50.0),
                                  child: ZSvgIcon(
                                    'user.svg',
                                    size: AppThemeUtil.radius(24.0),
                                  ),
                                )
                                    :
                                NetworkImageView(
                                  imageUrl: user.profilePhotoUrl?? '',
                                  width: AppThemeUtil.radius(100),
                                  height: AppThemeUtil.radius(100),
                                  radius: 50.0,
                                ),
                                (user.idVerificationStatus == kCompletedStatus)
                                    ? Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: AppThemeUtil.width(14.0),
                                    vertical: AppThemeUtil.height(8.0),
                                  ),
                                  decoration: BoxDecoration(
                                    color: kSuccess100,
                                    borderRadius: BorderRadius.circular(AppThemeUtil.radius(8.0)),
                                    border: Border.all(color: kSuccess200),
                                  ),
                                  child: Row(
                                    children: [
                                      ZSvgIcon(
                                        'seal_check.svg',
                                        size: AppThemeUtil.radius(20.0),
                                        color: kSuccess600,
                                      ),
                                      const HSpace(width: 8.0),
                                      const Text('Verified').semiBold().fontSize(14.0).color(kSuccess600)
                                    ],
                                  ),
                                )
                                    : Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: AppThemeUtil.width(14.0),
                                    vertical: AppThemeUtil.height(8.0),
                                  ),
                                  decoration: BoxDecoration(
                                    color: kError100,
                                    borderRadius: BorderRadius.circular(AppThemeUtil.radius(8.0)),
                                    border: Border.all(color: kError700),
                                  ),
                                  child: Row(
                                    children: [
                                      ZSvgIcon(
                                        'seal_check.svg',
                                        size: AppThemeUtil.radius(20.0),
                                        color: kError700,
                                      ),
                                      const HSpace(width: 8.0),
                                      const Text('Unverified').semiBold().fontSize(14.0).color(kError700)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const VSpace(height: 14.0),
                            Text(user.fullName).bold().fontSize(20.0).color(kGrey1200).letterSpacing(-0.4),
                            const VSpace(height: 8.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ZSvgIcon(
                                      'map_pin.svg',
                                      size: AppThemeUtil.radius(16.0),
                                    ).paddingOnly(top: 2.0),
                                    const HSpace(width: 4.0),
                                    Text(user.address?.originName?? '').medium().fontSize(14.0).color(kGrey800).flexible(),
                                  ],
                                ).flexible(),
                                const HSpace(width: 8.0),
                                Row(
                                  children: [
                                    const Text('Rental Score').regular().fontSize(14.0).color(kGrey800),
                                    const HSpace(width: 4.0),
                                    ZSvgIcon(
                                      'star.svg',
                                      size: AppThemeUtil.radius(14.0),
                                    ),
                                    const HSpace(width: 4.0),
                                    Text('${user.statistics?.renterAverageRating ?? 0.0}').semiBold().fontSize(14.0).color(kGrey800),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ).paddingAll(20.0),
                      ),
                      const VSpace(height: 12.0),
                    ],
                  ).paddingSymmetric(horizontal: kWidthPadding)
                ],
              ),
            ),
          ];
        },
        body: Column(
          children: [
            VendorProfileTabBar(
              tabController: _controller,
              tabs: [
                const Text("Items")
                    .semiBold()
                    .fontSize(16.0)
                    .paddingSymmetric(vertical: 10),
                const Text("Reviews")
                    .semiBold()
                    .fontSize(16.0)
                    .paddingSymmetric(vertical: 10),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _controller,
                children: [
                  VendorListedProductTab(vendorExternalId: widget.user.externalId),
                  ItemsTabScreen(vendor: widget.user,).paddingOnly(
                    top: kWidthPadding,
                    left: kWidthPadding,
                    right: kWidthPadding
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
