import 'dart:io';

import 'package:aider_mobile_app/core/constants/colors.dart';
import 'package:aider_mobile_app/core/constants/common.dart';
import 'package:aider_mobile_app/core/extensions/widgets/center_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/flexible_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/gesture_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/src/shared_widgets/base/app_screen_scaffold.dart';
import 'package:aider_mobile_app/src/shared_widgets/buttons/app_primary_button.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/app_bottom_nav_wrapper.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/h_space.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/v_space.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../../core/utils/app_theme_util.dart';
import '../../../../../core/utils/media_file_util.dart';
import '../../../../../core/utils/permission_util.dart';
import '../../../../shared_widgets/common/app_dotted_border.dart';
import '../../../../shared_widgets/common/linear_percent_indicator.dart';
import '../view_model/kyc_view_model.dart';

class PassportSelfieScreen extends StatefulWidget {
  const PassportSelfieScreen({super.key});

  @override
  State<PassportSelfieScreen> createState() => _PassportSelfieScreenState();
}

class _PassportSelfieScreenState extends State<PassportSelfieScreen> {
  final phoneFocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;
  String uploadedImagePath = '';

  @override
  Widget build(BuildContext context) {
    return AppScreenScaffold(
      title: 'User Identification',
      titleFontSize: 24.0,
      bottomNavigationBar: AppBottomNavWrapper(
        child: AppPrimaryButton(
          text: "Complete",
          onPressed: uploadedImagePath.isEmpty ? null: () async{
            await context.read<KycViewModel>().initializeVerification(
                context,
                requestBody: {
                  ...context.read<KycViewModel>().getCapturedNiNInfo,
                  "selfie": uploadedImagePath
                }
            );
          },
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const VSpace(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LinearPercentIndicator(
                  animation: true,
                  width: MediaQuery.of(context).size.width - 90,
                  lineHeight: 12.0,
                  percent: uploadedImagePath.isEmpty ? 0.55 : 0.99,
                  progressColor: kAider700,
                  backgroundColor: const Color(0xFFFEECF0),
                  padding: EdgeInsets.zero,
                  barRadius: const Radius.circular(100),
                ).flexible(),
                Text(uploadedImagePath.isEmpty ? '1/2' : '2/2').extraBold().fontSize(20).color(kPrimaryBlack),
              ],
            ),
            const VSpace(height: 29),
            const Text(
              'Take a selfie to complete verification',
            ).semiBold().fontSize(20).letterSpacing(-0.22).color(kPrimaryBlack),
            const VSpace(height: 8),
            const Text(
              'Tap on the field below to take a selfie.',
            ).semiBold().fontSize(16).color(kGrey500),
            const VSpace(height: 48),
            const Text(
              'Take a Selfie',
            ).regular().fontSize(16).color(kPrimaryBlack).letterSpacing(-0.18),
            const VSpace(height: 16),
            if (uploadedImagePath.isEmpty) Container(
              width: double.infinity,
              height: AppThemeUtil.height(200),
              decoration: BoxDecoration(
                color: kAider100,
                borderRadius: BorderRadius.circular(
                  AppThemeUtil.radius(20.0),
                ),
              ),
              child: AppDottedBorder(
                borderType: BorderType.RRect,
                radius: 20.0,
                color: kAider100,
                strokeWidth: 1,
                padding: EdgeInsets.all(AppThemeUtil.height(25.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "$kSvgPath/camera.svg",
                      width: 24,
                      height: 24,
                      color: kAider700,
                    ),
                    const HSpace(width: 6),
                    const Text(
                      'Take a selfie',
                    ).semiBold().fontSize(16).color(kAider700),
                  ],
                ).toCenter(),
              ),
            ).onPressed(() async {
              if(await PermissionUtil.getCameraPermissions()){
                final croppedFile = await MediaFileUtil.getPickedSourceImage(cameraFront: true);
                if(croppedFile != null){
                  setState(() => uploadedImagePath = croppedFile);
                }
              }
            }) else Column(
              children: [
                Container(
                  width: double.infinity,
                  height: AppThemeUtil.height(200),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        AppThemeUtil.radius(20.0),
                      ),
                      border: Border.all(color: kGrey200),
                      image: uploadedImagePath.isEmpty ? null : DecorationImage(
                          image: FileImage(File(uploadedImagePath)),
                          fit: BoxFit.cover
                      )
                  ),
                ),
                const VSpace(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "$kSvgPath/camera.svg",
                      width: 24,
                      height: 24,
                      color: kAider700,
                    ),
                    const HSpace(width: 6),
                    const Text(
                      'Retake selfie',
                    ).semiBold().fontSize(16).color(kAider700),
                  ],
                ).toCenter().onPressed(() async {
                  if(await PermissionUtil.getCameraPermissions()){
                    final croppedFile = await MediaFileUtil.getPickedSourceImage(cameraFront: true);
                    if(croppedFile != null){
                      setState(() => uploadedImagePath = croppedFile);
                    }
                  }
                }),
              ],
            ),
          ],
        ).paddingSymmetric(horizontal: kWidthPadding),
      ),
    );
  }
}
