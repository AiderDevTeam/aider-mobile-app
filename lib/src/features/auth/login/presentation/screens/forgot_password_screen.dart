import 'package:aider_mobile_app/core/extensions/widgets/align_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/gesture_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/utils/app_theme_util.dart';
import 'package:aider_mobile_app/core/constants/colors.dart';
import 'package:aider_mobile_app/core/constants/common.dart';
import 'package:aider_mobile_app/core/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/providers/auth_provider.dart';
import '../../../../../shared_widgets/buttons/app_primary_button.dart';
import '../../../../../shared_widgets/forms/app_input_field.dart';
import '../../../../../shared_widgets/forms/form_label.dart';
import '../../../../../shared_widgets/common/v_space.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;
  final emailFocusNode = FocusNode();
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const VSpace(height: 18.0),
          const FormLabel(text: 'Email'),
          const VSpace(height: 8.0),
          AppInputField(
            hintText: 'Enter email',
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          const VSpace(height: 16.0),
          AppPrimaryButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                Provider.of<AuthProvider>(context, listen: false)
                    .forgotPassword(
                  context,
                  email: emailController.text,
                );
              } else {
                setState(
                    () => autoValidate = AutovalidateMode.onUserInteraction);
              }
            },
            minWidth: double.infinity,
            text: 'Send request',
          ),
          const VSpace(height: 32.0),
          RichText(
            text: TextSpan(
                text: 'I remember password now. ',
                style: kRegularFontStyle.copyWith(
                  fontSize: AppThemeUtil.fontSize(16.0),
                  color: kPrimaryBlack,
                ),
                children: [
                  TextSpan(
                    text: 'Login',
                    style: kSemiBoldFontStyle.copyWith(
                      fontSize: AppThemeUtil.fontSize(16.0),
                      color: kPrimaryBlack,
                    ),
                  ),
                ]),
          ).onPressed(() {
            if (widget.pageController.page == 1) {
              widget.pageController.animateToPage(
                0,
                duration: const Duration(milliseconds: 400),
                curve: Curves.ease,
              );
            }
          }).alignCenter(),
          const VSpace(height: 16.0),
        ],
      ),
    ).paddingSymmetric(horizontal: kWidthPadding);
  }
}
