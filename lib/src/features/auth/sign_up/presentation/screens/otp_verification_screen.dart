import 'package:aider_mobile_app/core/extensions/widgets/align_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/core/constants/common.dart';
import 'package:aider_mobile_app/core/providers/auth_provider.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/v_space.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/routing/app_navigator.dart';
import '../../../../../../core/routing/app_route.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../shared_widgets/common/app_countdown.dart';
import '../../../../../shared_widgets/base/app_screen_scaffold.dart';
import '../../../../../shared_widgets/forms/otp_fields.dart';

class OtpVerificationScreen extends StatefulWidget {
  final bool isResetPassword;

  const OtpVerificationScreen({
    super.key,
    this.isResetPassword = false,
  });

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  int initialSeconds = 60;
  int timerIncrement = 300;
  int endTime = 0;
  bool isResendBtnEnabled = false;
  bool isResetPassword = false;

  void onEnd() {
    if (!mounted) return;
    setState(() => isResendBtnEnabled = true);
  }

  @override
  void initState() {
    endTime = DateTime.now().millisecondsSinceEpoch + 1000 * initialSeconds;
    isResetPassword = widget.isResetPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final otpData = context.read<AuthProvider>().getOTPData;
    return AppScreenScaffold(
      appBar: false,
      hasBottomBorder: false,
      title: 'OTP Verification',
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const VSpace(height: 32.0),
            const Text('OTP Verification')
                .semiBold()
                .color(kBlack.withOpacity(0.8))
                .fontSize(28.0)
                .letterSpacing(-0.31)
                .alignCenter(),
            const VSpace(height: 110.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'We\'ve sent you an OTP verification\nto your email',
                )
                    .regular()
                    .fontSize(20)
                    .color(kPrimaryBlack)
                    .letterSpacing(-1.1)
                    .alignText(TextAlign.center),
              ],
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [ const Text(
            //       ('email'),
            //     ).bold()
            //         .fontSize(20)
            //         .color(kPrimaryBlack)
            //         .letterSpacing(-1.1)
            //         .alignText(TextAlign.center)
            //   ],
            // ),

            const VSpace(height: 32.0),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const VSpace(height: 20.0),
                OtpFields(
                  onCompleted: (code) async {
                    if (code.length == 4) {
                      final authProvider = context.read<AuthProvider>();
                      if (widget.isResetPassword) {
                        authProvider.setOTPData({
                          'action': kResetPassAction,
                          "email": authProvider.getOTPData['email'],
                          "otp": code,
                        });
                      } else {
                        authProvider.setOTPData({
                          'action': kSignupAction,
                          "email": authProvider.getOTPData['email'],
                          "otp": code,
                        });
                      }

                      await authProvider.verifyOTP(context, code,
                          isResetPassword: widget.isResetPassword);
                    }
                  },
                ),
                const VSpace(height: 32.0),
                GestureDetector(
                  onTap: isResendBtnEnabled
                      ? () async {
                          final authProvider = context.read<AuthProvider>();
                          setState(() {
                            isResendBtnEnabled = false;
                            if (initialSeconds == 60) {
                              initialSeconds = timerIncrement;
                            } else {
                              initialSeconds += timerIncrement;
                            }
                          });
                          if (otpData['action'] == kResetPassAction) {
                            await authProvider.forgotPassword(
                              context,
                              email: authProvider.getOTPData['email'],
                            );
                          }

                          if (!mounted) return;
                          setState(() {
                            endTime = DateTime.now().millisecondsSinceEpoch +
                                1000 * initialSeconds;
                            isResendBtnEnabled = false;
                          });
                        }
                      : null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Didn\'t receive a code? ',
                      )
                          .regular()
                          .fontSize(16)
                          .color(kGrey400)
                          .letterSpacing(-0.18)
                          .alignText(TextAlign.center),
                      AppCountDown(
                        endTime: endTime,
                        onEnd: onEnd,
                      ),
                    ],
                  ),
                ),
                const VSpace(height: 24.0),
              ],
            ),
          ],
        ).paddingSymmetric(horizontal: kWidthPadding),
      ),
    );
  }

  void signup() {
    AppNavigator.pushReplacementNamed(context, AppRoute.personalDetailScreen);
  }

  void resetPassword() {
    AppNavigator.pushReplacementNamed(context, AppRoute.resetPasswordScreen);
  }
}
