import 'package:aider_mobile_app/core/extensions/widgets/flexible_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/core/routing/app_navigator.dart';
import 'package:aider_mobile_app/core/routing/app_route.dart';
import 'package:aider_mobile_app/core/constants/common.dart';
import 'package:aider_mobile_app/core/utils/app_dialog_util.dart';
import 'package:aider_mobile_app/core/utils/app_theme_util.dart';
import 'package:aider_mobile_app/core/view_models/base_view.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/app_bottom_nav_wrapper.dart';
import 'package:aider_mobile_app/src/shared_widgets/buttons/app_primary_button.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/zloading.dart';
import 'package:aider_mobile_app/src/shared_widgets/forms/app_input_field.dart';
import 'package:aider_mobile_app/src/shared_widgets/forms/field_eye.dart';
import 'package:aider_mobile_app/src/shared_widgets/forms/form_label.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/v_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/view_models/user_view_model.dart';
import '../../../../../shared_widgets/base/app_screen_scaffold.dart';
import '../../../../../shared_widgets/common/linear_percent_indicator.dart';
import '../widgets/country_code_modal.dart';
import '../widgets/country_code_prefix.dart';

class PersonalDetailScreen extends StatefulWidget {
  const PersonalDetailScreen({super.key});

  @override
  State<PersonalDetailScreen> createState() => _PersonalDetailScreenState();
}

class _PersonalDetailScreenState extends State<PersonalDetailScreen> {
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final birthdayController = TextEditingController();
  final passwordController = TextEditingController();
  final displayNameController = TextEditingController();
  final isHidden = ValueNotifier<bool>(true);
  final phoneFocusNode = FocusNode();
  final phoneNumberController = TextEditingController();
  final selectedCountry = ValueNotifier<Map<String, dynamic>>({
    'path': 'assets/flags/ng.png',
    'package': 'fl_country_code_picker',
    'code': '+234',
  });

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userProvider = context.read<UserViewModel>();
      userProvider.setEmailAvailable('', true);
      userProvider.setDisplayNameAvailable('', true);
      firstNameController.text = userProvider.getSignupRequestBody['firstName']?? '';
      lastNameController.text = userProvider.getSignupRequestBody['lastName']?? '';
      emailController.text = userProvider.getSignupRequestBody['email']?? '';
      passwordController.text = userProvider.getSignupRequestBody['password']?? '';
    });
    super.initState();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    birthdayController.dispose();
    displayNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScreenScaffold(
      title: 'Create an account',
      bottomNavigationBar: AppBottomNavWrapper(
        child: AppPrimaryButton(
          onPressed: () {
            final userProvider = context.read<UserViewModel>();
            if(userProvider.getComponentLoading('verifyDisplayName') || userProvider.getComponentLoading('verifyEmail')) return;

            if (formKey.currentState!.validate()) {

              // if(userProvider.emailAvailableStatus != kAvailable){
              //   AppDialogUtil.showWarningAlert(
              //     context,
              //     userProvider.emailAvailableStatus.isNotEmpty? userProvider.emailAvailableStatus.trim(): 'Email field can not be empty',
              //   );
              //   return;
              // }
              if(userProvider.displayNameAvailableStatus != kAvailable){
                AppDialogUtil.showWarningAlert(
                  context,
                  userProvider.displayNameAvailableStatus.isNotEmpty? userProvider.displayNameAvailableStatus.trim(): 'Display name field can not be empty',
                );
                return;
              }

              userProvider.setSignupRequestBody({
                "firstName": firstNameController.text,
                "lastName": lastNameController.text,
                "email": userProvider.getOTPData['email'],
                "password": passwordController.text,
                "displayName": displayNameController.text,
                "phone": phoneNumberController.text,
                "callingCode": selectedCountry.value['code']
              });
              AppNavigator.pushNamed(
                context,
                AppRoute.additionalDetailScreen,
              );
            } else {
              setState(() => autoValidate = AutovalidateMode.onUserInteraction);
            }
          },
          text: 'Next',
          minWidth: double.infinity,
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
                  percent: 0.66,
                  progressColor: kAider700,
                  backgroundColor: const Color(0xFFFEECF0),
                  padding: EdgeInsets.zero,
                  barRadius: const Radius.circular(100),
                ).flexible(),
                const Text('2/4').extraBold().fontSize(20).color(kPrimaryBlack),
              ],
            ),
            const VSpace(height: 48.0),
            const Text('Add some personal details')
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
                  const FormLabel(text: 'First name'),
                  const VSpace(height: 8.0),
                  AppInputField(
                    hintText: 'Enter first name',
                    controller: firstNameController,
                    validator: (value) {
                      if (value!.isEmpty) return 'First name is required';
                      return null;
                    },
                    textCapitalization: TextCapitalization.words,
                  ),
                  const FormLabel(text: 'Last name'),
                  const VSpace(height: 8.0),
                  AppInputField(
                    hintText: 'Enter last name',
                    controller: lastNameController,
                    validator: (value) {
                      if (value!.isEmpty) return 'Last name is required';
                      return null;
                    },
                    textCapitalization: TextCapitalization.words,
                  ),
                  const FormLabel(text: 'Display name'),
                  const VSpace(height: 8.0),
                  BaseView<UserViewModel>(
                    builder: (context, userConsumer, child) {
                      return FocusScope(
                        child: Focus(
                          onFocusChange: (focus) async{
                            if(!focus && displayNameController.text.isNotEmpty){
                              if(userConsumer.getComponentLoading('verifyDisplayName')) return;
                              await context.read<UserViewModel>().verifyDisplayName(
                                context,
                                requestBody: {
                                  "displayName": displayNameController.text,
                                },
                              );
                            }
                          },
                          child: AppInputField(
                            hintText: 'Enter display name',
                            controller: displayNameController,
                            validator: (value) {
                              if (value!.isEmpty) return 'Display name is required';
                              return null;
                            },
                            onChanged: (value){
                              if(value!.isEmpty){
                                context.read<UserViewModel>().setDisplayNameAvailable('', true);
                              }
                            },
                            suffixIcon: userConsumer.getComponentLoading('verifyDisplayName')?
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const ZLoading().paddingOnly(right: 16.0),
                              ],
                            ) : userConsumer.displayNameAvailableStatus == kAvailable?
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: kSuccess700,
                                  size: AppThemeUtil.radius(24.0),
                                ).paddingOnly(right: 16.0),
                              ],
                            ) : null,
                            customBorderColor: (userConsumer.displayNameAvailableStatus.isNotEmpty && userConsumer.displayNameAvailableStatus != kAvailable)? kError600:null,
                            helperText: (userConsumer.displayNameAvailableStatus.isNotEmpty && userConsumer.displayNameAvailableStatus != kAvailable)? userConsumer.displayNameAvailableStatus : ' ',
                            helperStyleColor: (userConsumer.displayNameAvailableStatus.isNotEmpty && userConsumer.displayNameAvailableStatus != kAvailable)? kError600 : null,
                          ),
                        ),
                      );
                    }
                  ),
                  const FormLabel(text: 'Phone'),
                  const VSpace(height: 8.0),
                  // BaseView<UserViewModel>(
                  //   builder: (context, userConsumer, child) {
                  //     return FocusScope(
                  //       child: Focus(
                  //         onFocusChange: (focus) async{
                  //           if(!focus && emailController.text.isNotEmpty && emailController.text.isValidEmail()){
                  //             if(userConsumer.getComponentLoading('verifyEmail')) return;
                  //             await context.read<UserViewModel>().verifyEmail(
                  //               context,
                  //               requestBody: {
                  //                 "email": emailController.text,
                  //               },
                  //             );
                  //           }
                  //         },
                  //         child: AppInputField(
                  //           hintText: 'Enter email',
                  //           keyboardType: TextInputType.emailAddress,
                  //           controller: emailController,
                  //           validator: (value) {
                  //             if (value!.isEmpty) return 'Email is required';
                  //             if(!value.isValidEmail()){
                  //               return 'Email address is invalid';
                  //             }
                  //             return null;
                  //           },
                  //           suffixIcon: userConsumer.getComponentLoading('verifyEmail')?
                  //           Row(
                  //             mainAxisAlignment: MainAxisAlignment.end,
                  //             mainAxisSize: MainAxisSize.min,
                  //             children: [
                  //               const ZLoading().paddingOnly(right: 16.0),
                  //             ],
                  //           ) : userConsumer.emailAvailableStatus == 'available'?
                  //           Row(
                  //             mainAxisAlignment: MainAxisAlignment.end,
                  //             mainAxisSize: MainAxisSize.min,
                  //             children: [
                  //               Icon(
                  //                 Icons.check_circle,
                  //                 color: kSuccess700,
                  //                 size: AppThemeUtil.radius(24.0),
                  //               ).paddingOnly(right: 16.0),
                  //             ],
                  //           ) : null,
                  //           customBorderColor: (userConsumer.emailAvailableStatus.isNotEmpty && userConsumer.emailAvailableStatus != kAvailable)? kError600:null,
                  //           helperText: (userConsumer.emailAvailableStatus.isNotEmpty && userConsumer.emailAvailableStatus != kAvailable)? userConsumer.emailAvailableStatus : ' ',
                  //           helperStyleColor: (userConsumer.emailAvailableStatus.isNotEmpty && userConsumer.emailAvailableStatus != kAvailable)? kError600 : null,
                  //         ),
                  //       ),
                  //     );
                  //   }
                  // ),
                  AppInputField(
                    controller: phoneNumberController,
                    keyboardType: TextInputType.number,
                    focusNode: phoneFocusNode,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    prefixIcon: CountryCodePrefix(
                      selectedCountry: selectedCountry,
                      onTap: () async {
                        final country =
                        await CountryCodeModal.showDialog(context);

                        if (country != null) {
                          selectedCountry.value = {
                            'package': country.flagImagePackage,
                            'path': country.flagUri,
                            'code': country.dialCode,
                          };
                        }
                      },
                    ).paddingOnly(right: 8),
                    validator: (value) {
                      if (value!.isEmpty) return 'Phone number is required';
                      return null;
                    },
                  ),
                  const FormLabel(text: 'Password'),
                  const VSpace(height: 8.0),
                  ValueListenableBuilder<bool>(
                    valueListenable: isHidden,
                    builder: (context, isHiddenValue, child) {
                      return AppInputField(
                        hintText: 'Enter password',
                        obscureText: isHiddenValue,
                        suffixIcon: FieldEye(
                          onPressed: (){
                            isHidden.value = !isHiddenValue;
                          },
                          isHidden: isHiddenValue,
                        ),
                        controller: passwordController,
                        validator: (value) {
                          if (value!.isEmpty) return 'Password is required';
                          if (value.length < 6) return 'Password must be at least 6 characters';
                          return null;
                        },
                      );
                    }
                  ),
                ],
              ),
            )
          ],
        ),
      ).paddingSymmetric(horizontal: kWidthPadding),
    );
  }
}
