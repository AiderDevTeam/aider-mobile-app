import 'package:aider_mobile_app/core/constants/common.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/src/shared_widgets/base/app_screen_scaffold.dart';
import 'package:aider_mobile_app/src/shared_widgets/buttons/app_primary_button.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/v_space.dart';
import 'package:flutter/material.dart';

import '../../../../shared_widgets/forms/app_input_field.dart';
import '../../../../shared_widgets/forms/field_eye.dart';
import '../../../../shared_widgets/forms/form_label.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;
  bool isHidden = true;
  bool isHidden2 = true;

  @override
  void dispose() {
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScreenScaffold(
      title: "Security",
      child: Form(
        key: formKey,
        autovalidateMode: autoValidate,
        child: ListView(
          children: [
            const VSpace(height: 24),
            const FormLabel(text: 'Current Password',),

            const VSpace(height: 12),

            AppInputField(
              hintText: "Enter Password",
              controller: passwordController,
              validator: (String? value) {
                if (value!.isEmpty) return "Enter new password";
                return null;
              },
              obscureText: isHidden,
              suffixIcon: FieldEye(
                onPressed: (){
                  setState(() => isHidden = !isHidden );
                },
                isHidden: isHidden,
              ),
            ),
            const FormLabel(text: 'New Password',),

            const VSpace(height: 12),

            AppInputField(
              hintText: "Enter Password",
              controller: confirmController,
              validator: (String? value) {
                if (value!.isEmpty) return "Enter Password";
                if(passwordController.text != value) return 'Password does not match';
                return null;
              },
              obscureText: isHidden2,
              suffixIcon: FieldEye(
                onPressed: (){
                  setState(() => isHidden2 = !isHidden2 );
                },
                isHidden: isHidden2,
              ),
            ),
            const FormLabel(text: 'Repeat Password',),

            const VSpace(height: 12),

            AppInputField(
              hintText: "Repeat Password",
              controller: confirmController,
              validator: (String? value) {
                if (value!.isEmpty) return "Repeat Password";
                if(passwordController.text != value) return 'Password does not match';
                return null;
              },
              obscureText: isHidden2,
              suffixIcon: FieldEye(
                onPressed: (){
                  setState(() => isHidden2 = !isHidden2 );
                },
                isHidden: isHidden2,
              ),
            ),
            const VSpace(height: 12),
            AppPrimaryButton(
              onPressed: () async{
                if (formKey.currentState!.validate()) {

                } else {
                  setState(() => autoValidate = AutovalidateMode.onUserInteraction);
                }
              },
              text: "Submit",
            )
          ],
        ).paddingSymmetric(
          horizontal: kWidthPadding
        ),
      ),
    );
  }
}
