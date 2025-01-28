import 'package:aider_mobile_app/core/utils/app_theme_util.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/v_space.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/constants/common.dart';
import '../../../../../../core/constants/text_style.dart';
import '../../../../../../core/providers/auth_provider.dart';
import '../../../../../../core/providers/user_provider.dart';
import '../../../../../shared_widgets/base/app_screen_scaffold.dart';
import '../../../../../shared_widgets/buttons/app_primary_button.dart';
import '../../../../../shared_widgets/forms/app_input_field.dart';
import '../../../../../shared_widgets/forms/field_eye.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final newPasswordController = TextEditingController();
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;
  bool isHidden = true;
  bool isHidden2 = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    super.initState();
  }

  @override
  void dispose() {
    newPasswordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScreenScaffold(
      title: 'Reset Password',
      hasBottomBorder: false,
      child: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: AppThemeUtil.width(kWidthPadding),
        ),
        physics: const ClampingScrollPhysics(),
        children: [
          const VSpace(
            height: 134,
          ),
          Text(
            'Let’s help you reset your password.',
            style: kRegularFontStyle.copyWith(
              color: AppThemeUtil.getThemeColor(kPrimaryBlack),
              fontSize: AppThemeUtil.fontSize(20),
              height: AppThemeUtil.getLineHeight(30, 20),
              letterSpacing: AppThemeUtil.getLetterSpacing(-0.22),
            ),
          ),
          const VSpace(height: 24.0),
          Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppInputField(
                  hintText: "Email",
                  controller: emailController,
                  readOnly: true,
                ),
                const VSpace(height: 5.0),
                AppInputField(
                  hintText: "New Password",
                  controller: newPasswordController,
                  validator: (String? value) {
                    if (value!.isEmpty) return "New password";
                    if (newPasswordController.text != value)
                      return 'Enter Password';
                    return null;
                  },
                  obscureText: isHidden2,
                  suffixIcon: FieldEye(
                    onPressed: () {
                      setState(() => isHidden2 = !isHidden2);
                    },
                    isHidden: isHidden2,
                  ),
                ),
              ],
            ),
          ),
          const VSpace(height: 32.0),
          AppPrimaryButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                final authProvider = context.read<AuthProvider>();
                await authProvider.resetPassword(
                  context,
                  email: emailController.text,
                  password: newPasswordController.text,
                );
              } else {
                setState(
                    () => autoValidate = AutovalidateMode.onUserInteraction);
              }
            },
            text: "Reset password",
          ),
        ],
      ),
    );
  }
}
