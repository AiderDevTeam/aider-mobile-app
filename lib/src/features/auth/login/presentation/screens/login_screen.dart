import 'package:aider_mobile_app/core/extensions/widgets/align_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/gesture_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/core/constants/colors.dart';
import 'package:aider_mobile_app/core/constants/common.dart';
import 'package:aider_mobile_app/src/features/auth/login/presentation/screens/forgot_password_screen.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/h_space.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/utils/app_theme_util.dart';
import '../../../../../../core/utils/helper_util.dart';
import '../../../../../../core/view_models/user_view_model.dart';
import '../../../../../shared_widgets/base/draggable_bottom_sheet.dart';
import '../../../../../shared_widgets/buttons/app_primary_button.dart';
import '../../../../../shared_widgets/forms/app_input_field.dart';
import '../../../../../shared_widgets/forms/field_eye.dart';
import '../../../../../shared_widgets/forms/form_label.dart';
import '../../../../../shared_widgets/modals/draggable_bottom_sheet_content.dart';
import '../../../../../shared_widgets/common/v_space.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _pageController = PageController(initialPage: 0);


  @override
  void initState() {
    _pageController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double progress = _pageController.hasClients ? (_pageController.page ?? 0) : 0;
    return DraggableBottomSheet(
      initialChildSize: HelperUtil.isIOS? 0.82 : 0.72,
      minChildSize: 0.50,
      maxChildSize: HelperUtil.isIOS? 0.82 : 0.72,
      builder: (context, scrollController){
        return DraggableBottomSheetContent(
          draggableKey: GlobalKey(),
          scrollController: scrollController,
          modalHeaderContent:  Row(
            children: [
              if(progress <= 0.3)...[
                const Text('Welcome back 👋').bold().fontSize(20).color(kPrimaryBlack),
              ],

              if(progress > 0.3)...[
                Icon(
                  CupertinoIcons.arrow_left,
                  size: AppThemeUtil.radius(24.0),
                  color: AppThemeUtil.getThemeColor(kPrimaryBlack),
                ).onPressed(() {
                  if (_pageController.page == 1) {
                    _pageController.animateToPage(
                      0,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.ease,
                    );
                  }
                }),
                const HSpace(width: 16),
                const Text('Forgot password').bold().fontSize(20).color(kPrimaryBlack),
              ],
            ],
          ).paddingOnly(left: kWidthPadding, right: kWidthPadding, bottom: 10),
          content: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: [
              SingleChildScrollView(
                child: LoginForm(pageController: _pageController,),
              ),
              SingleChildScrollView(
                child: ForgotPasswordScreen(
                  pageController: _pageController,
                ),
              ),
            ],
          ),
        );
      },
    );

  }
}


class LoginForm extends StatefulWidget {
  const LoginForm({super.key, required this.pageController,});

  final PageController pageController;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isHidden = ValueNotifier<bool>(true);

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: autoValidate,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const VSpace(height: 18.0),
          const FormLabel(text: 'Email'),
          const VSpace(height: 8.0),
          AppInputField(
            hintText: 'Enter email',
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
            validator: (value) {
              if (value!.isEmpty) return 'Email or Username is required';

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

          const Text('Forgotten password?').regular().fontSize(16.0).color(kPrimaryBlack).onPressed((){
            if (widget.pageController.page == 0) {
              widget.pageController.animateToPage(
                1,
                duration: const Duration(milliseconds: 400),
                curve: Curves.ease,
              );
            }
          }).alignCenterRight(),
          const VSpace(height: 32.0),
          AppPrimaryButton(
            onPressed: () async{
              if (formKey.currentState!.validate()) {
                await context.read<UserViewModel>().authentication(
                  context,
                  requestBody: {
                    "email": emailController.text,
                    "password": passwordController.text,
                    "deviceOs": HelperUtil.getOSPlatform,
                    "pushNotificationToken":""
                  },
                );
              } else {
                setState(() => autoValidate = AutovalidateMode.onUserInteraction);
              }
            },
            minWidth: double.infinity,
            text: 'Log in',
          ),
          const VSpace(height: 16.0),
        ],
      ),
    ).paddingSymmetric(horizontal: kWidthPadding);
  }
}
