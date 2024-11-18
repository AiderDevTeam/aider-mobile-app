import 'package:aider_mobile_app/core/constants/colors.dart';
import 'package:aider_mobile_app/core/constants/common.dart';
import 'package:aider_mobile_app/core/extensions/widgets/flexible_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/src/shared_widgets/base/app_screen_scaffold.dart';
import 'package:aider_mobile_app/src/shared_widgets/buttons/app_primary_button.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/app_bottom_nav_wrapper.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/app_keyboard_action.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/v_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_actions/keyboard_actions_item.dart';
import 'package:provider/provider.dart';
import '../../../../../core/routing/app_navigator.dart';
import '../../../../../core/routing/app_route.dart';
import '../../../../shared_widgets/common/linear_percent_indicator.dart';
import '../../../../shared_widgets/forms/app_input_field.dart';
import '../view_model/kyc_view_model.dart';

class BvnScreen extends StatefulWidget {
  const BvnScreen({super.key});

  @override
  State<BvnScreen> createState() => _BvnScreenState();
}

class _BvnScreenState extends State<BvnScreen> {
  final phoneFocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;
  final bvnNumberController = TextEditingController();
  @override
  void dispose() {
    bvnNumberController.text;
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
          onPressed: bvnNumberController.text.isEmpty
              ? null
              : () async {
                  context.read<KycViewModel>().captureNiNInfo({"type": "bvn", "idNumber": bvnNumberController.text});
                  AppNavigator.pushNamed(context, AppRoute.bvnSelfieScreen);
                },
        ),
      ),
      child: AppKeyboardAction(
        actions: [
          KeyboardActionsItem(focusNode: phoneFocusNode),
        ],
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
                'Provide BVN details',
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
                      'Enter BVN Number',
                    ).regular().fontSize(16).color(kPrimaryBlack).letterSpacing(-0.18),
                    const VSpace(height: 16),
                    AppInputField(
                      controller: bvnNumberController,
                      keyboardType: TextInputType.number,
                      focusNode: phoneFocusNode,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      hintText: "BVN Number",
                      customBorderColor: const Color(0xFFBDC2C6),
                      validator: (value) {
                        if (value!.isEmpty) return 'BVN number is required';
                        return null;
                      },
                    ),
                  ],
                ),
              )
            ],
          ).paddingSymmetric(horizontal: kWidthPadding),
        ),
      ),
    );
  }
}
