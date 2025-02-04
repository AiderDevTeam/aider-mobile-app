import 'package:aider_mobile_app/core/extensions/widgets/flexible_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/core/constants/common.dart';
import 'package:aider_mobile_app/core/providers/auth_provider.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/app_bottom_nav_wrapper.dart';
import 'package:aider_mobile_app/src/shared_widgets/buttons/app_primary_button.dart';
import 'package:aider_mobile_app/src/shared_widgets/forms/app_dropdown_field.dart';
import 'package:aider_mobile_app/src/shared_widgets/forms/app_input_field.dart';
import 'package:aider_mobile_app/src/shared_widgets/forms/form_label.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/v_space.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/routing/app_navigator.dart';
import '../../../../../../core/routing/app_route.dart';
import '../../../../../../core/utils/app_dialog_util.dart';
import '../../../../../../core/utils/app_theme_util.dart';
import '../../../../../../core/utils/helper_util.dart';
import '../../../../../../core/utils/input_formatter_util.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../shared_widgets/base/app_screen_scaffold.dart';
import '../../../../../shared_widgets/common/linear_percent_indicator.dart';
import '../../../../../shared_widgets/modals/location_modal.dart';
import '../../../../../shared_widgets/common/svg_icon.dart';

class AdditionalDetailScreen extends StatefulWidget {
  const AdditionalDetailScreen({super.key});

  @override
  State<AdditionalDetailScreen> createState() => _AdditionalDetailScreenState();
}

class _AdditionalDetailScreenState extends State<AdditionalDetailScreen> {
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;
  String? selectedGender;
  final selectedItem = ValueNotifier<String?>(null);
  final dobController = TextEditingController();
  final locationController = TextEditingController();
  final dobFocusNode = FocusNode();
  Map<String, dynamic> pickedLocation = {};

  @override
  void dispose() {
    dobController.dispose();
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScreenScaffold(
      title: 'Create an account',
      bottomNavigationBar: AppBottomNavWrapper(
        child: AppPrimaryButton(
          onPressed: () async {
            final authProvider = context.read<AuthProvider>();

            if (formKey.currentState!.validate()) {
              var requestBody = authProvider.getSignupRequestBody;
              requestBody = requestBody.copyWith(
                birthday: dobController.text.split('/').reversed.join('-'),
                gender: selectedGender?.toLowerCase(),
              );

              authProvider.setSignupRequestBody = requestBody;

              AppNavigator.pushNamed(
                context,
                AppRoute.userTypeScreen,
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
                  width: MediaQuery.of(context).size.width - 120,
                  lineHeight: 12.0,
                  percent: 1.0,
                  progressColor: kAider700,
                  backgroundColor: const Color(0xFFFEECF0),
                  padding: EdgeInsets.zero,
                  barRadius: const Radius.circular(100),
                ).flexible(),
                const Text('3/4').extraBold().fontSize(20).color(kPrimaryBlack),
              ],
            ),
            const VSpace(height: 48.0),
            const Text('Almost there, just a few more details')
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
                  const FormLabel(text: 'Date of birth'),
                  const VSpace(height: 8.0),
                  AppInputField(
                    hintText: 'Date of birth (DD/MM/YYYY)',
                    controller: dobController,
                    focusNode: dobFocusNode,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your date of birth';
                      }
                      if (!HelperUtil.isDateDayValid(value)) {
                        return 'Date is invalid';
                      }
                      if (!HelperUtil.isDateMonthValid(value)) {
                        return 'Date is invalid';
                      }
                      if (!HelperUtil.isDateYearValid(value)) {
                        return 'Date is invalid';
                      }
                      if (HelperUtil.isEighteenAndBelow(value)) {
                        return "You must be 18 years and above";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters:
                        InputFormatterUtil.maskInput(mask: "##/##/####"),
                  ),
                  const FormLabel(text: 'Gender'),
                  const VSpace(height: 8.0),
                  AppDropdownField(
                    hintText: 'Select gender',
                    selectedItem: selectedGender,
                    listItems: const ['Male', 'Female'],
                    onChanged: (value) {
                      print('Changed to: $value');
                      setState(() {
                        selectedGender = value;
                        print('Changed to: $selectedGender');
                      });
                    },
                    validator: (value) {
                      if (value == null) return 'Please select gender';
                      return null;
                    },
                  ),
                  const VSpace(height: 24.0),
                  const FormLabel(text: 'Location'),
                  const VSpace(height: 8.0),
                  AppInputField(
                    controller: locationController,
                    hintText: 'Location',
                    readOnly: true,
                    validator: (value) {
                      if (value!.isEmpty) return 'Enter your location';
                      return null;
                    },
                    onTap: () async {
                      final result =
                          await AppDialogUtil.showScrollableBottomSheet(
                        context: context,
                        builder: (context) => const LocationModal(),
                      );
                      if (result != null) {
                        locationController.text = result['originName'] ?? '';
                        if (!context.mounted) return;

                        context.read<AuthProvider>().setSignupRequestLocation =
                            result;
                      }
                    },
                    suffixIcon: ZSvgIcon(
                      'map_pin.svg',
                      size: AppThemeUtil.radius(20.0),
                    ).paddingAll(16.0),
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
