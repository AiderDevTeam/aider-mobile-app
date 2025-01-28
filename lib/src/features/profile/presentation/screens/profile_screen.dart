import 'dart:ui';

import 'package:aider_mobile_app/core/constants/colors.dart';
import 'package:aider_mobile_app/core/constants/common.dart';
import 'package:aider_mobile_app/core/constants/text_style.dart';
import 'package:aider_mobile_app/core/extensions/widgets/align_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/flexible_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/gesture_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/core/routing/app_navigator.dart';
import 'package:aider_mobile_app/core/routing/app_route.dart';
import 'package:aider_mobile_app/core/utils/app_theme_util.dart';
import 'package:aider_mobile_app/src/features/kyc/domain/verification_model/verification_model.dart';
import 'package:aider_mobile_app/src/features/profile/presentation/widgets/profile_tab_navigate.dart';
import 'package:aider_mobile_app/src/shared_widgets/base/app_screen_scaffold.dart';
import 'package:aider_mobile_app/src/shared_widgets/base/custom_scroll_behaviour.dart';
import 'package:aider_mobile_app/src/shared_widgets/cards/app_card.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/h_space.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/svg_icon.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/v_space.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/providers/auth_provider.dart';
import '../../../../../core/utils/app_dialog_util.dart';
import '../../../../../core/utils/url_launcher_util.dart';
import '../../../../../core/providers/base_view.dart';
import '../../../../../core/providers/user_provider.dart';
import '../../../../shared_widgets/common/network_image_view.dart';
import '../../../../shared_widgets/modals/question_modal_content.dart';
import '../../../kyc/presentation/view_model/kyc_view_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    _loadKYCData();
    super.initState();
  }

  void _loadKYCData() async {
    await context.read<KycViewModel>().fetchUserKYCData();
  }

  @override
  Widget build(BuildContext context) {
    return AppScreenScaffold(
      backgroundColor: kGrey50,
      hasLeading: false,
      title: 'Profile',
      titleFontSize: 24.0,
      child: CustomScrollBehaviour(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const VSpace(height: 12.0),
              DecoratedBox(
                decoration: BoxDecoration(
                    color: kPrimaryWhite,
                    borderRadius:
                        BorderRadius.circular(AppThemeUtil.radius(12))),
                child: BaseView<UserProvider>(
                  builder: (context, userConsumer, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            (!userConsumer.getUser.hasProfilePhoto)
                                ? CircleAvatar(
                                    backgroundColor: kGrey200,
                                    maxRadius: AppThemeUtil.radius(50.0),
                                    child: ZSvgIcon(
                                      'user.svg',
                                      size: AppThemeUtil.radius(24.0),
                                    ),
                                  )
                                : NetworkImageView(
                                    imageUrl:
                                        userConsumer.getUser.profilePhotoUrl ??
                                            '',
                                    width: AppThemeUtil.radius(100),
                                    height: AppThemeUtil.radius(100),
                                    radius: 50.0,
                                  ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppThemeUtil.width(14.0),
                                vertical: AppThemeUtil.height(8.0),
                              ),
                              decoration: BoxDecoration(
                                  color: kPrimaryBlack,
                                  borderRadius: BorderRadius.circular(
                                      AppThemeUtil.radius(8.0))),
                              child: Row(
                                children: [
                                  ZSvgIcon(
                                    'seal_check.svg',
                                    size: AppThemeUtil.radius(24.0),
                                  ),
                                  const HSpace(width: 8.0),
                                  (userConsumer.getUser.idVerificationStatus ==
                                          kCompletedStatus)
                                      ? const Text('KYC Completed')
                                          .semiBold()
                                          .fontSize(14.0)
                                          .color(kPrimaryWhite)
                                      : const Text('Complete KYC')
                                          .semiBold()
                                          .fontSize(14.0)
                                          .color(kPrimaryWhite)
                                ],
                              ),
                            ),
                          ],
                        ),
                        const VSpace(height: 14.0),
                        Text(userConsumer.getUser.fullName)
                            .bold()
                            .fontSize(20.0)
                            .color(kGrey1200)
                            .letterSpacing(-0.4),
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
                                Text(userConsumer.getUser.address?.originName ??
                                        '')
                                    .medium()
                                    .fontSize(14.0)
                                    .color(kGrey800)
                                    .flexible(),
                              ],
                            ).flexible(),
                            const HSpace(width: 8.0),
                            Row(
                              children: [
                                const Text('Rental Score')
                                    .regular()
                                    .fontSize(14.0)
                                    .color(kGrey800),
                                const HSpace(width: 4.0),
                                ZSvgIcon(
                                  'star.svg',
                                  size: AppThemeUtil.radius(14.0),
                                ),
                                const HSpace(width: 4.0),
                                Text('${userConsumer.getUser.statistics?.renterAverageRating ?? 0.0}')
                                    .semiBold()
                                    .fontSize(14.0)
                                    .color(kGrey800),
                              ],
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ).paddingAll(20.0),
              ),
              const VSpace(height: 12.0),
              BaseView<UserProvider>(builder: (context, userConsumer, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: AppThemeUtil.height(180.0),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          AppCard(
                            height: AppThemeUtil.height(180.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    AppThemeUtil.radius(12)),
                                image: const DecorationImage(
                                  image: AssetImage('$kImagePath/shop_bg.png'),
                                  fit: BoxFit.cover,
                                )),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(
                                bottom:
                                    Radius.circular(AppThemeUtil.radius(12))),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                              child: AppCard(
                                decoration: BoxDecoration(
                                  color: const Color(0x66F4F6FF),
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(
                                          AppThemeUtil.radius(12))),
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: AppThemeUtil.height(18.0),
                                  horizontal: AppThemeUtil.width(16.0),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ZSvgIcon(
                                      'rental_outline.svg',
                                      size: AppThemeUtil.radius(20),
                                      color: kGrey1200,
                                    ).flexible(),
                                    const HSpace(width: 8.0),
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Items listed ',
                                            style: kMediumFontStyle.copyWith(
                                              color: kGrey1200,
                                              fontSize:
                                                  AppThemeUtil.fontSize(16.0),
                                              letterSpacing: -0.48,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                '(${userConsumer.getUser.statistics?.listedItemsCount ?? 0})',
                                            style: kBoldFontStyle.copyWith(
                                              color: kGrey1200,
                                              fontSize:
                                                  AppThemeUtil.fontSize(16.0),
                                              letterSpacing: -0.48,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ).onPressed(() {
                      AppNavigator.pushNamed(
                          context, AppRoute.listedProductsScreen,
                          arguments: false);
                    }).flexible(flex: 5),
                    const HSpace(width: 12.0),
                    SizedBox(
                      height: AppThemeUtil.height(180.0),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          AppCard(
                            height: AppThemeUtil.height(180.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    AppThemeUtil.radius(12)),
                                image: const DecorationImage(
                                  image:
                                      AssetImage('$kImagePath/rating_bg.png'),
                                  fit: BoxFit.cover,
                                )),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(
                                bottom:
                                    Radius.circular(AppThemeUtil.radius(12))),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                              child: AppCard(
                                decoration: BoxDecoration(
                                  color: const Color(0x66F4F6FF),
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(
                                          AppThemeUtil.radius(12))),
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: AppThemeUtil.height(18.0),
                                  horizontal: AppThemeUtil.width(16.0),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ZSvgIcon(
                                      'star.svg',
                                      size: AppThemeUtil.radius(20),
                                      color: kGrey1200,
                                    ).flexible(),
                                    const HSpace(width: 8.0),
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Reviews ',
                                            style: kMediumFontStyle.copyWith(
                                              color: kGrey1200,
                                              fontSize:
                                                  AppThemeUtil.fontSize(16.0),
                                              letterSpacing: -0.48,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                '(${userConsumer.getUser.statistics?.vendorReviewsCount ?? 0})',
                                            style: kBoldFontStyle.copyWith(
                                              color: kGrey1200,
                                              fontSize:
                                                  AppThemeUtil.fontSize(16.0),
                                              letterSpacing: -0.48,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ).onPressed(() {
                        AppNavigator.pushNamed(context, AppRoute.reviewScreen);
                      }),
                    ).flexible(flex: 5),
                  ],
                );
              }),
              const VSpace(height: 32.0),
              const Text('ACCOUNT SETTINGS')
                  .bold()
                  .fontSize(12.0)
                  .color(kGrey700)
                  .height(18.0, 12.0),
              const VSpace(height: 12.0),
              DecoratedBox(
                decoration: BoxDecoration(
                    color: kPrimaryWhite,
                    borderRadius:
                        BorderRadius.circular(AppThemeUtil.radius(12))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileTabNavigate(
                      text: 'Account Settings',
                      iconName: 'settings.svg',
                      onPressed: () {
                        AppNavigator.pushNamed(
                            context, AppRoute.accountSettingsScreen);
                      },
                    ),
                    const VSpace(height: 12.0),
                    ProfileTabNavigate(
                      text: 'User Identification',
                      iconName: 'seal_check_outline.svg',
                      onPressed: () {
                        if (context
                                .read<UserProvider>()
                                .getUser
                                .idVerificationStatus ==
                            kCompletedStatus) {
                          VerificationModel? kycStatus = context
                              .read<UserProvider>()
                              .getUser
                              .userIdentifications
                              ?.firstWhere(
                                (model) =>
                                    model.status == kBookingAcceptedStatus,
                              );
                          AppNavigator.pushNamed(
                            context,
                            AppRoute.afterVerificationScreen,
                            arguments: {
                              'kycType': kycStatus?.type,
                              'fromProfile': true
                            },
                          );
                          return;
                        }
                        if (context
                                .read<UserProvider>()
                                .getUser
                                .userIdentifications
                                ?.first
                                .status ==
                            kRejected) {
                          AppNavigator.pushNamed(
                            context,
                            AppRoute.afterVerificationScreen,
                            arguments: {
                              'kycType': context
                                  .read<UserProvider>()
                                  .getUser
                                  .userIdentifications
                                  ?.first
                                  .type,
                              'fromProfile': true
                            },
                          );
                          return;
                        }
                        if (context
                                .read<UserProvider>()
                                .getUser
                                .userIdentifications
                                ?.first
                                .status ==
                            kPendingStatus) {
                          AppNavigator.pushNamed(
                            context,
                            AppRoute.afterVerificationScreen,
                            arguments: {
                              'kycType': context
                                  .read<UserProvider>()
                                  .getUser
                                  .userIdentifications
                                  ?.first
                                  .type,
                              'fromProfile': true
                            },
                          );
                          return;
                        } else {
                          AppNavigator.pushNamed(
                              context, AppRoute.userIdentityScreen);
                        }
                      },
                    ),
                    const VSpace(height: 12.0),
                    ProfileTabNavigate(
                      text: 'Payments',
                      iconName: 'wallet.svg',
                      onPressed: () {
                        AppNavigator.pushNamed(context, AppRoute.paymentScreen);
                      },
                    ),
                    const VSpace(height: 12.0),
                    ProfileTabNavigate(
                      text: 'Notifications',
                      iconName: 'bell.svg',
                      onPressed: () {
                        AppNavigator.pushNamed(
                            context, AppRoute.notificationScreen);
                      },
                    ),
                  ],
                ).paddingAll(12.0),
              ),
              const VSpace(height: 32.0),
              const Text('MISC')
                  .bold()
                  .fontSize(12.0)
                  .color(kGrey700)
                  .height(18.0, 12.0),
              const VSpace(height: 12.0),
              DecoratedBox(
                decoration: BoxDecoration(
                    color: kPrimaryWhite,
                    borderRadius:
                        BorderRadius.circular(AppThemeUtil.radius(12))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileTabNavigate(
                      text: 'Terms & Privacy Policy',
                      iconName: 'policy.svg',
                      onPressed: () async {
                        await UrlLauncherUtil().openUrl(
                            'https://aidar-terms-and-conditions.onrender.com');
                      },
                    ),
                    const VSpace(height: 12.0),
                    ProfileTabNavigate(
                      text: 'Support',
                      iconName: 'support.svg',
                      onPressed: () {
                        AppNavigator.pushNamed(context, AppRoute.supportScreen);
                      },
                    ),
                    const VSpace(height: 12.0),
                    ProfileTabNavigate(
                      text: 'Rate Us',
                      iconName: 'star_outline.svg',
                      onPressed: () {},
                    ),
                    const VSpace(height: 12.0),
                    ProfileTabNavigate(
                      text: 'Logout',
                      iconName: 'logout.svg',
                      onPressed: () {
                        AppDialogUtil.showScrollableBottomSheet(
                          context: context,
                          builder: (context) => QuestionModalContent(
                            questionText: 'Are you sure want to logout?',
                            onYesPressed: () async {
                              await context.read<AuthProvider>().logout(
                                    context,
                                  );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ).paddingAll(12.0),
              ),
              const VSpace(height: 12.0),
              const Text('v1.0.1')
                  .medium()
                  .fontSize(12.0)
                  .color(kGrey700)
                  .paddingSymmetric(vertical: 8.0)
                  .alignCenter(),
              const VSpace(height: 32.0),
            ],
          ).paddingSymmetric(horizontal: kWidthPadding),
        ),
      ),
    );
  }
}
