import 'dart:async';

import 'package:aider_mobile_app/core/extensions/email_validator_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/flexible_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/core/constants/common.dart';
import 'package:aider_mobile_app/core/providers/auth_provider.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/app_bottom_nav_wrapper.dart';
import 'package:aider_mobile_app/src/shared_widgets/buttons/app_primary_button.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/app_keyboard_action.dart';
import 'package:aider_mobile_app/src/shared_widgets/forms/app_input_field.dart';
import 'package:aider_mobile_app/src/shared_widgets/forms/form_label.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/v_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_actions/keyboard_actions_item.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/utils/app_theme_util.dart';
import '../../../../../../core/providers/base_view.dart';
import '../../../../../../core/providers/user_provider.dart';
import '../../../../../shared_widgets/base/app_screen_scaffold.dart';
import '../../../../../shared_widgets/common/linear_percent_indicator.dart';
import '../../../../../shared_widgets/common/zloading.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({super.key});

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final phoneNumberController = TextEditingController();
  final phoneFocusNode = FocusNode();
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;
  Timer? _debounce;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final signUpRequest = context.read<AuthProvider>().getSignupRequestBody;
      phoneNumberController.text = signUpRequest.phone ?? '';
    });
    super.initState();
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScreenScaffold(
      title: 'Create an account',
      bottomNavigationBar: AppBottomNavWrapper(
        child: AppPrimaryButton(
          onPressed: () async {
            if (context
                .read<UserProvider>()
                .isComponentLoading('verifyEmail')) {
              return;
            }

            if (formKey.currentState!.validate()) {
              final authProvider = context.read<AuthProvider>();

              authProvider.setOTPData({
                'action': kSignupAction,
                "email": emailController.text,
              });

              var requestBody = authProvider.getSignupRequestBody;
              requestBody = requestBody.copyWith(
                email: emailController.text,
              );
              authProvider.setSignupRequestBody = requestBody;

              await authProvider.signUpOTP(
                context,
                email: emailController.text,
              );
            } else {
              setState(() => autoValidate = AutovalidateMode.onUserInteraction);
            }
          },
          text: 'Next',
          minWidth: double.infinity,
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
                    percent: 0.33,
                    progressColor: kAider700,
                    backgroundColor: const Color(0xFFFEECF0),
                    padding: EdgeInsets.zero,
                    barRadius: const Radius.circular(100),
                  ).flexible(),
                  const Text('1/3')
                      .extraBold()
                      .fontSize(20)
                      .color(kPrimaryBlack),
                ],
              ),
              const VSpace(height: 48.0),
              const Text('Get started by confirming your email')
                  .semiBold()
                  .color(kBlack)
                  .fontSize(20.0)
                  .letterSpacing(-1.1),
              const VSpace(height: 20.0),
              Form(
                key: formKey,
                autovalidateMode: autoValidate,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const FormLabel(text: 'Email'),
                    const VSpace(height: 8.0),
                    BaseView<UserProvider>(
                        builder: (context, userConsumer, child) {
                      return AppInputField(
                        hintText: 'Enter email',
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        validator: (value) {
                          if (value!.isEmpty) return 'Email is required';
                          if (!value.isValidEmail()) {
                            return 'Email address is invalid';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          if (_debounce?.isActive ?? false) _debounce?.cancel();
                          _debounce =
                              Timer(const Duration(seconds: 1), () async {
                            if (value!.isNotEmpty && value.isValidEmail()) {
                              if (userConsumer
                                  .isComponentLoading('verifyEmail')) return;
                              await context.read<UserProvider>().verifyEmail(
                                    context,
                                    email: value,
                                  );
                            }
                          });
                        },
                        suffixIcon: userConsumer
                                .isComponentLoading('verifyEmail')
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const ZLoading().paddingOnly(right: 16.0),
                                ],
                              )
                            : userConsumer.emailAvailableStatus == 'available'
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.check_circle,
                                        color: kSuccess700,
                                        size: AppThemeUtil.radius(24.0),
                                      ).paddingOnly(right: 16.0),
                                    ],
                                  )
                                : null,
                        customBorderColor: (userConsumer
                                    .emailAvailableStatus.isNotEmpty &&
                                userConsumer.emailAvailableStatus != kAvailable)
                            ? kError600
                            : null,
                        helperText: (userConsumer
                                    .emailAvailableStatus.isNotEmpty &&
                                userConsumer.emailAvailableStatus != kAvailable)
                            ? userConsumer.emailAvailableStatus
                            : ' ',
                        helperStyleColor: (userConsumer
                                    .emailAvailableStatus.isNotEmpty &&
                                userConsumer.emailAvailableStatus != kAvailable)
                            ? kError600
                            : null,
                      );
                    }),
                  ],
                ),
              )
            ],
          ),
        ).paddingSymmetric(horizontal: kWidthPadding),
      ),
    );
  }
}
