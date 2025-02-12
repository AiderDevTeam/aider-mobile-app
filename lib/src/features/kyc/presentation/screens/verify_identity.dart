import 'package:aider_mobile_app/core/constants/colors.dart';
import 'package:aider_mobile_app/core/constants/common.dart';
import 'package:aider_mobile_app/core/extensions/widgets/gesture_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/core/utils/app_theme_util.dart';
import 'package:aider_mobile_app/src/shared_widgets/base/app_screen_scaffold.dart';
import 'package:aider_mobile_app/src/shared_widgets/cards/app_card.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/app_list_tile.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/svg_icon.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/v_space.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../../../core/routing/app_navigator.dart';
import '../../../../../core/routing/app_route.dart';
import '../../../../../core/providers/base_view.dart';
import '../../../../../core/providers/user_provider.dart';
import '../../domain/verification_model/verification_model.dart';
import '../view_model/kyc_view_model.dart';

class VerifyIdentity extends StatefulWidget {
  const VerifyIdentity({super.key});

  @override
  State<VerifyIdentity> createState() => _VerifyIdentityState();
}

class _VerifyIdentityState extends State<VerifyIdentity> {
  final List<Map<String, dynamic>> kycTypes = [
    {
      'type': "bvn",
    },
    {
      'type': "nin",
    },
    {
      'type': "driver license",
    },
    {
      'type': "passport",
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScreenScaffold(
      title: 'User Identification',
      titleFontSize: 24.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const VSpace(height: 16),
          const Text(
            'Verify your identity',
          ).semiBold().fontSize(20).letterSpacing(-0.22).color(kPrimaryBlack),
          const VSpace(height: 8),
          const Text(
            'Please verify your identity with any of the options below.',
          ).regular().fontSize(16).color(kGrey500),
          const VSpace(height: 32),
          ListView.builder(
              itemCount: kycTypes.length,
              shrinkWrap: true,
              primary: false,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final kycType = kycTypes[index];
                return BaseView<UserProvider>(
                    builder: (context, userViewConsumer, child) {
                  final userIdentifications =
                      userViewConsumer.getUser.userIdentifications;

                  // Find the matching user identification based on the type
                  final matchingIdentification =
                      userIdentifications?.firstWhere(
                    (identification) =>
                        identification.type?.toLowerCase() ==
                        kycType['type'].toLowerCase(),
                    orElse: () => VerificationModel(
                      externalId: '',
                      idNumber: '',
                      documentUrl: '',
                      selfieUrl: '',
                      type: '',
                      status: '',
                      rejectionReason: '',
                    ),
                  );

                  return AppCard(
                    height: AppThemeUtil.height(72),
                    decoration: ShapeDecoration(
                      color: kGrey50,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppThemeUtil.radius(12)),
                      ),
                    ),
                    child: AppListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      leading: ZSvgIcon(
                        "UserFocus.svg",
                        size: AppThemeUtil.radius(28.0),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            kycType['type'].toUpperCase(),
                          )
                              .semiBold()
                              .fontSize(14)
                              .letterSpacing(-0.15)
                              .color(kGrey1200),
                          Text(matchingIdentification?.status?.toUpperCase() ??
                                  '')
                              .semiBold()
                              .fontSize(14)
                              .letterSpacing(-0.15)
                              .color(kAider700),
                        ],
                      ),
                      trailing: Icon(
                        CupertinoIcons.forward,
                        size: AppThemeUtil.radius(32),
                        color: kGrey500,
                      ),
                    ),
                  ).onPressed(() {
                    if (kycType['type'] == 'bvn') {
                      context.read<KycViewModel>().clearCaptureInfo();
                      AppNavigator.pushNamed(
                          context, AppRoute.bvnVerificationScreen);
                      return;
                    }
                    if (kycType['type'] == 'nin') {
                      context.read<KycViewModel>().clearCaptureInfo();
                      AppNavigator.pushNamed(
                          context, AppRoute.ninVerificationScreenOne);
                      return;
                    }
                    if (kycType['type'] == 'driver license') {
                      context.read<KycViewModel>().clearCaptureInfo();
                      AppNavigator.pushNamed(
                          context, AppRoute.driversVerificationScreen);
                      return;
                    }
                    if (kycType['type'] == 'passport') {
                      context.read<KycViewModel>().clearCaptureInfo();
                      AppNavigator.pushNamed(context, AppRoute.passportScreen);
                      return;
                    }
                  }).paddingSymmetric(vertical: AppThemeUtil.height(16.0));
                });
              }),
        ],
      ).paddingSymmetric(horizontal: kWidthPadding),
    );
  }
}
