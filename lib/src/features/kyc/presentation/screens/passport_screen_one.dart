import 'dart:io';

import 'package:aider_mobile_app/core/constants/colors.dart';
import 'package:aider_mobile_app/core/constants/common.dart';
import 'package:aider_mobile_app/core/extensions/widgets/center_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/flexible_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/gesture_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/core/utils/app_theme_util.dart';
import 'package:aider_mobile_app/src/shared_widgets/base/app_screen_scaffold.dart';
import 'package:aider_mobile_app/src/shared_widgets/buttons/app_primary_button.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/app_bottom_nav_wrapper.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/app_dotted_border.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/h_space.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/v_space.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../../core/routing/app_navigator.dart';
import '../../../../../core/routing/app_route.dart';
import '../../../../../core/utils/media_file_util.dart';
import '../../../../../core/utils/permission_util.dart';
import '../../../../shared_widgets/common/linear_percent_indicator.dart';
import '../../../../shared_widgets/forms/app_input_field.dart';
import '../view_model/kyc_view_model.dart';

class PassportScreenOne extends StatefulWidget {
  const PassportScreenOne({super.key});

  @override
  State<PassportScreenOne> createState() => _PassportScreenOneState();
}

class _PassportScreenOneState extends State<PassportScreenOne> {
  final phoneFocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;
  final passportNumberController = TextEditingController();
  String uploadedImagePath = '';
  @override
  void dispose() {
    passportNumberController.text;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AppScreenScaffold(
      title: 'User Identification',
      titleFontSize: 24.0,
      bottomNavigationBar: AppBottomNavWrapper(
        child: AppPrimaryButton(
          text: "Proceed",
          onPressed: (passportNumberController.text.isEmpty || uploadedImagePath.isEmpty)
              ? null :() async {
            context.read<KycViewModel>().captureNiNInfo({
              "type": "passport",
              "idNumber": passportNumberController.text,
              "documentImage": uploadedImagePath
            });
            AppNavigator.pushNamed(context, AppRoute.passportSelfie);
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
                    percent: 0.55,
                    progressColor: kAider700,
                    backgroundColor: const Color(0xFFFEECF0),
                    padding: EdgeInsets.zero,
                    barRadius: const Radius.circular(100),
                  ).flexible(),
                  const Text('1/2').extraBold().fontSize(20).color(kPrimaryBlack),
                ],
              ),
              const VSpace(height: 29),
              const Text(
                'Provide Passport details',
              ).semiBold().fontSize(20).letterSpacing(-0.22).color(kPrimaryBlack),
              const VSpace(height: 8),
              const Text(
                'Provide all required details below',
              ).regular().fontSize(16).color(kGrey500),
              const VSpace(height: 48),
              Form(
                key: formKey,
                autovalidateMode: autoValidate,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Enter Passport Number',
                    ).regular().fontSize(16).color(kPrimaryBlack).letterSpacing(-0.18),
                    const VSpace(height: 16),
                    AppInputField(
                      controller: passportNumberController,
                      keyboardType: TextInputType.text,
                      focusNode: phoneFocusNode,
                      hintText: "Passport Number",
                      customBorderColor: const Color(0xFFBDC2C6),
                      validator: (value) {
                        if (value!.isEmpty) return 'Passport Number is required';
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const VSpace(height: 32),
              const Text(
                'Passport Image',
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
                        'Upload Passport Image',
                      ).semiBold().fontSize(16).color(kAider700),
                    ],
                  ).toCenter(),
                ),
              ).onPressed(() async {
                await showDialog<File?>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Select Image Source"),
                    surfaceTintColor: kPrimaryWhite,
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: const Icon(Icons.camera),
                          title: const Text('Take a picture'),
                          onTap: () async {
                            Navigator.of(context).pop();
                            if(await PermissionUtil.getCameraPermissions()){
                              final croppedFile = await MediaFileUtil.getPickedSourceImage();
                              if(croppedFile != null){
                                setState(() => uploadedImagePath = croppedFile);
                              }
                            }

                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.photo_library),
                          title: const Text('Choose from gallery'),
                          onTap: () async {
                            Navigator.of(context).pop();
                            if(await PermissionUtil.getStoragePermission()){
                              String? croppedFile = await MediaFileUtil.getPickedImage();
                              if(croppedFile != null){
                                setState(() => uploadedImagePath = croppedFile);
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                );
                // if(await PermissionUtil.getStoragePermission()){
                //   String? croppedFile = await MediaFileUtil.getPickedImage();
                //   if(croppedFile != null){
                //     setState(() => uploadedImagePath = croppedFile);
                //     // context.read<KycViewModel>().setShopInfo = {
                //     //   "passportPhoto": uploadedImagePath,
                //     // };
                //   }
                // }
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
                        'Retake Image',
                      ).semiBold().fontSize(16).color(kAider700),
                    ],
                  ).toCenter().onPressed(() async {
                    await showDialog<File?>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Select Image Source"),
                        surfaceTintColor: kPrimaryWhite,
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: const Icon(Icons.camera),
                              title: const Text('Take a picture'),
                              onTap: () async {
                                Navigator.of(context).pop();
                                if(await PermissionUtil.getCameraPermissions()){
                                  final croppedFile = await MediaFileUtil.getPickedSourceImage();
                                  if(croppedFile != null){
                                    setState(() => uploadedImagePath = croppedFile);
                                  }
                                }

                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.photo_library),
                              title: const Text('Choose from gallery'),
                              onTap: () async {
                                Navigator.of(context).pop();
                                if(await PermissionUtil.getStoragePermission()){
                                  String? croppedFile = await MediaFileUtil.getPickedImage();
                                  if(croppedFile != null){
                                    setState(() => uploadedImagePath = croppedFile);
                                  }
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ]
        ).paddingSymmetric(horizontal: kWidthPadding),
      ),
    );
  }
}
