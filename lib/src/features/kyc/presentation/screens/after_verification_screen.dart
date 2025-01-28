import 'package:aider_mobile_app/core/constants/common.dart';
import 'package:aider_mobile_app/core/extensions/widgets/gesture_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/routing/app_navigator.dart';
import '../../../../../core/routing/app_route.dart';
import '../../../../../core/utils/app_theme_util.dart';
import '../../../../../core/providers/base_view.dart';
import '../../../../../core/providers/user_provider.dart';
import '../../../../shared_widgets/base/app_screen_scaffold.dart';
import '../../../../shared_widgets/buttons/app_primary_button.dart';
import '../../../../shared_widgets/common/h_space.dart';
import '../../../../shared_widgets/common/kyc_rejection_min_card.dart';
import '../../../../shared_widgets/common/v_space.dart';
import '../../domain/verification_model/verification_model.dart';
import '../view_model/kyc_view_model.dart';
import '../widgets/kyc_status_card.dart';
import '../../../../../core/services/logger_service.dart';

class AfterVerification extends StatelessWidget {
  const AfterVerification({
    super.key,
    required this.param,
  });

  final Map<String, dynamic> param;
  @override
  Widget build(BuildContext context) {
    return AppScreenScaffold(
      onNavigateBack: () {
        if (param['kycType'] != null && param['fromProfile'] == false) {
          AppNavigator.pop(context);
          AppNavigator.pop(context);
          AppNavigator.pop(context);
          return;
        }
        if (param['fromProfile'] != false) {
          AppNavigator.pop(context);
        }
      },
      child:
          BaseView<UserProvider>(builder: (context, userViewConsumer, child) {
        VerificationModel? kycStatus =
            userViewConsumer.getUser.userIdentifications?.firstWhere(
          (model) => model.type == param['kycType'],
        );
        final user = context.read<UserProvider>().getUser;
        ZLoggerService.logOnInfo('KYC Details.... $user');
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const VSpace(height: 16),
            const Text(
              'Verify your identity',
            ).semiBold().fontSize(20).letterSpacing(-0.22).color(kPrimaryBlack),
            const VSpace(height: 8),
            if (kycStatus?.status == kPendingStatus) ...[
              const Text(
                'Your details have been submitted. Progress will be updated as soon as possible.',
              ).regular().fontSize(16).color(kGrey500),
            ],
            if (kycStatus?.status == kRejected) ...[
              const Text(
                'Your details have been rejected. Please re-submit it.',
              ).regular().fontSize(16).color(kGrey500),
            ],
            if (kycStatus?.status == kBookingAcceptedStatus) ...[
              const Text(
                'Your details have been approve.',
              ).regular().fontSize(16).color(kGrey500),
            ],
            const VSpace(height: 32),
            if (kycStatus?.status == kBookingAcceptedStatus) ...[
              KycStatusCard(
                statusColor: kSuccess100,
                statusBorderColor: const Color(0xFFB2E5CD),
                type: kycStatus?.type?.toUpperCase() ?? "",
                statusTypeColor: kSuccess600,
                statusType: const Text(
                  'Accepted',
                )
                    .semiBold()
                    .fontSize(14)
                    .letterSpacing(-0.15)
                    .color(kPrimaryWhite),
              ),
              const VSpace(height: 32),
            ],
            if (kycStatus?.status == kPendingStatus) ...[
              KycStatusCard(
                statusColor: const Color(0xFFFEF4E6),
                statusBorderColor: const Color(0xFFFCDAAD),
                type: kycStatus?.type?.toUpperCase() ?? "",
                statusTypeColor: const Color(0xFFFAB55B),
                statusType: Row(
                  children: [
                    Container(
                      width: AppThemeUtil.width(8),
                      height: AppThemeUtil.height(8),
                      // padding: EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                          color: kPrimaryWhite,
                          borderRadius: BorderRadius.all(Radius.circular(100))),
                    ),
                    const HSpace(width: 8),
                    const Text(
                      'Pending',
                    )
                        .semiBold()
                        .fontSize(14)
                        .letterSpacing(-0.15)
                        .color(kPrimaryWhite),
                  ],
                ),
              ),
              const VSpace(height: 32),
            ],
            if (kycStatus?.status == kRejected) ...[
              KycStatusCard(
                statusColor: const Color(0xFFFEECEB),
                statusBorderColor: const Color(0xFFFAC1BD),
                statusTypeColor: kError600,
                isRejected: true,
                type: kycStatus?.type?.toUpperCase() ?? "",
                statusType: const Text(
                  'Rejected',
                )
                    .semiBold()
                    .fontSize(14)
                    .letterSpacing(-0.15)
                    .color(kPrimaryWhite),
                tryAgain: AppPrimaryButton(
                  onPressed: () {
                    context.read<KycViewModel>().clearCaptureInfo();
                    // AppNavigator.pushReplacementNamed(context, AppRoute.verifyIdentityScreen);
                  },
                  text: "Try again",
                  height: 46,
                  minWidth: double.infinity,
                ),
              ).onPressed(() {
                context.read<KycViewModel>().clearCaptureInfo();
                AppNavigator.pushReplacementNamed(
                    context, AppRoute.verifyIdentityScreen);
              }),
              const VSpace(height: 20),
              KycRejectionCard(
                reason: kycStatus?.rejectionReason ?? '',
              ),
            ],
          ],
        ).paddingSymmetric(horizontal: kWidthPadding);
      }),
      // Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     const VSpace(height: 16),
      //     const Text(
      //       'Verify your identity',
      //     ).semiBold().fontSize(20).letterSpacing(-0.22).color(kPrimaryBlack),
      //     const VSpace(height: 8),
      //     const Text(
      //       'Your details have been submitted. Progress will be updated as soon as possible.',
      //     ).regular().fontSize(16).color(kGrey500),
      //     const VSpace(height: 32),
      //     BaseView<UserViewProvider>(builder: (context, userViewConsumer, child) {
      //       VerificationModel? kycStatus =
      //           userViewConsumer.getUser.userIdentifications?.firstWhere(
      //         (model) => model.type == param['kycType'],
      //       );
      //       // print(param['kycType']);
      //       // print(userViewConsumer.getUser.idVerificationStatus);
      //       return Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           if (kycStatus?.status == kBookingAcceptedStatus) ...[
      //             KycStatusCard(
      //               statusColor: kSuccess100,
      //               statusBorderColor: const Color(0xFFB2E5CD),
      //               type: kycStatus?.type?.toUpperCase() ?? "",
      //               statusTypeColor: kSuccess600,
      //               statusType: const Text(
      //                 'Accepted',
      //               )
      //                   .semiBold()
      //                   .fontSize(14)
      //                   .letterSpacing(-0.15)
      //                   .color(kPrimaryWhite),
      //             ),
      //             const VSpace(height: 32),
      //           ],
      //           if (kycStatus?.status == kPendingStatus) ...[
      //             KycStatusCard(
      //               statusColor: const Color(0xFFFEF4E6),
      //               statusBorderColor: const Color(0xFFFCDAAD),
      //               type: kycStatus?.type?.toUpperCase() ?? "",
      //               statusTypeColor: const Color(0xFFFAB55B),
      //               statusType: Row(
      //                 children: [
      //                   Container(
      //                     width: AppThemeUtil.width(8),
      //                     height: AppThemeUtil.height(8),
      //                     // padding: EdgeInsets.all(10),
      //                     decoration: const BoxDecoration(
      //                         color: kPrimaryWhite,
      //                         borderRadius:
      //                             BorderRadius.all(Radius.circular(100))),
      //                   ),
      //                   const HSpace(width: 8),
      //                   const Text(
      //                     'Pending',
      //                   )
      //                       .semiBold()
      //                       .fontSize(14)
      //                       .letterSpacing(-0.15)
      //                       .color(kPrimaryWhite),
      //                 ],
      //               ),
      //             ),
      //             const VSpace(height: 32),
      //           ],
      //           if (kycStatus?.status == kRejected) ...[
      //             KycStatusCard(
      //               statusColor: const Color(0xFFFEECEB),
      //               statusBorderColor: const Color(0xFFFAC1BD),
      //               statusTypeColor: kError600,
      //               isRejected: true,
      //               type: kycStatus?.type?.toUpperCase() ?? "",
      //               statusType: const Text(
      //                 'Rejected',
      //               )
      //                   .semiBold()
      //                   .fontSize(14)
      //                   .letterSpacing(-0.15)
      //                   .color(kPrimaryWhite),
      //               tryAgain: AppPrimaryButton(
      //                 onPressed: () {
      //                   context.read<KycViewModel>().clearCaptureInfo();
      //                   AppNavigator.pushNamed(
      //                       context, AppRoute.verifyIdentityScreen);
      //                 },
      //                 text: "Try again",
      //                 height: 46,
      //                 minWidth: double.infinity,
      //               ),
      //             ).onPressed(() {
      //               context.read<KycViewModel>().clearCaptureInfo();
      //               AppNavigator.pushNamed(
      //                   context, AppRoute.verifyIdentityScreen);
      //             }),
      //             const VSpace(height: 20),
      //             KycRejectionCard(
      //               reason: kycStatus?.rejectionReason ?? '',
      //             ),
      //           ],
      //         ],
      //       );
      //     })
      //   ],
      // ).paddingSymmetric(
      //   horizontal: kWidthPadding,
      // ),
    );
  }
}
