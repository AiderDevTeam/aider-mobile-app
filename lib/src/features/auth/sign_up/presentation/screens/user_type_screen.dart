import 'package:aider_mobile_app/core/constants/common.dart';
import 'package:aider_mobile_app/core/extensions/widgets/flexible_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/gesture_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/src/shared_widgets/buttons/app_primary_button.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/app_bottom_nav_wrapper.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/h_space.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/v_space.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/utils/app_dialog_util.dart';
import '../../../../../../core/utils/app_theme_util.dart';
import '../../../../../../core/utils/helper_util.dart';
import '../../../../../../core/view_models/base_view.dart';
import '../../../../../../core/view_models/user_view_model.dart';
import '../../../../../shared_widgets/base/app_screen_scaffold.dart';
import '../../../../../shared_widgets/cards/app_card.dart';
import '../../../../../shared_widgets/common/aider_empty_state.dart';
import '../../../../../shared_widgets/common/app_radio.dart';
import '../../../../../shared_widgets/common/error_response_message.dart';
import '../../../../../shared_widgets/common/linear_percent_indicator.dart';
import '../../../../../shared_widgets/common/zloading.dart';

class UserTypeScreen extends StatefulWidget {
  const UserTypeScreen({super.key});

  @override
  State<UserTypeScreen> createState() => _UserTypeScreenState();
}

class _UserTypeScreenState extends State<UserTypeScreen> {
  ValueNotifier<String?> selectedItem = ValueNotifier<String?>(null);
  ValueNotifier<int?> typeId = ValueNotifier<int?>(null);

  void toggleSelection(String item) {
    if (selectedItem.value == item) {
      selectedItem.value = null;
    } else {
      selectedItem.value = item;
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserViewModel>().userType(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScreenScaffold(
      title: 'Create an account',
      bottomNavigationBar: AppBottomNavWrapper(
        child: AppPrimaryButton(
          onPressed: () async {
            final authProvider = context.read<UserViewModel>();
            if (selectedItem.value != null) {
              await authProvider.authentication(
                context,
                type: 'sign up',
                requestBody: {
                  ...authProvider.getSignupRequestBody,
                  "userTypeId": typeId.value,
                  "termsAndConditions": true,
                  "deviceOs": HelperUtil.getOSPlatform,
                },
              );
            } else {
              AppDialogUtil.showWarningAlert(
                context,
                'Please select a user type',
              );
            }
          },
          text: 'Complete',
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
                  percent: 1.0,
                  progressColor: kAider700,
                  backgroundColor: const Color(0xFFFEECF0),
                  padding: EdgeInsets.zero,
                  barRadius: const Radius.circular(100),
                ).flexible(),
                const Text('4/4').extraBold().fontSize(20).color(kPrimaryBlack),
              ],
            ),
            const VSpace(height: 48.0),
            const Text('Now the final stage')
                .semiBold()
                .color(kBlack)
                .fontSize(20.0)
                .letterSpacing(-1.1),
            const VSpace(height: 20.0),
            const Text('Are you here as a vendor or renter?')
                .regular()
                .color(kPrimaryBlack)
                .letterSpacing(-0.15),
            const VSpace(height: 32.0),
            BaseView<UserViewModel>(
              builder: (context, userConsumer, child) {
                if (userConsumer.getComponentLoading('userTypes') &&
                    userConsumer.getUserTypes.isEmpty) {
                  return const Center(
                    child: ZLoading(),
                  );
                }

                if (userConsumer.isComponentErrorType('userTypes')) {
                  return Center(
                    child: ErrorResponseMessage(
                      message: userConsumer.componentErrorType?['error'] ?? '',
                      onRetry: () async {
                        await context.read<UserViewModel>().userType(context);
                      },
                    ),
                  );
                }

                if (userConsumer.getUserTypes.isEmpty) {
                  return const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AiderEmptyState(
                        title: '',
                        subtitle: 'No user type found yet',
                      ),
                    ],
                  ).paddingOnly(bottom: 40);
                }

                return ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: userConsumer.getUserTypes.length,
                  itemBuilder: (context, index) {
                    final userType = userConsumer.getUserTypes[index];
                    return ValueListenableBuilder<String?>(
                      valueListenable: selectedItem,
                      builder: (context, selectedValue, child) {
                        return AppCard(
                          backgroundColor: kGrey100,
                          padding: EdgeInsets.all(AppThemeUtil.radius(20)),
                          decoration: ShapeDecoration(
                            color: (userType['type'] == 'vendor' &&
                                    selectedValue == 'vendor')
                                ? kAider100
                                : (userType['type'] == 'renter' &&
                                        selectedValue == 'renter')
                                    ? kAider100
                                    : kGrey100,
                            shape: RoundedRectangleBorder(
                              side: (userType['type'] == 'vendor' &&
                                      selectedValue == 'vendor')
                                  ? const BorderSide(
                                      width: 1,
                                      color: kAiderDefault,
                                    )
                                  : (userType['type'] == 'renter' &&
                                          selectedValue == 'renter')
                                      ? const BorderSide(
                                          width: 1,
                                          color: kAiderDefault,
                                        )
                                      : BorderSide.none,
                              borderRadius: BorderRadius.circular(
                                  AppThemeUtil.radius(12)),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      (userType['type'] == 'vendor')
                                          ? AppCard(
                                              width: AppThemeUtil.width(103),
                                              height:
                                                  AppThemeUtil.height(102.43),
                                              decoration: ShapeDecoration(
                                                image: const DecorationImage(
                                                  image: AssetImage(
                                                    "$kImagePath/vendor.png",
                                                  ),
                                                  fit: BoxFit.fill,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          AppThemeUtil.radius(
                                                              6.83)),
                                                ),
                                              ),
                                            )
                                          : AppCard(
                                              width: AppThemeUtil.width(103),
                                              height:
                                                  AppThemeUtil.height(102.43),
                                              decoration: ShapeDecoration(
                                                image: const DecorationImage(
                                                  image: AssetImage(
                                                    "$kImagePath/cart.png",
                                                  ),
                                                  fit: BoxFit.fill,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          AppThemeUtil.radius(
                                                              6.83)),
                                                ),
                                              ),
                                            ),
                                      const HSpace(width: 16),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const VSpace(height: 7.72),
                                          Text(
                                            userType['type']
                                                .toString()
                                                .toUpperCase(),
                                          )
                                              .extraBold()
                                              .fontSize(14)
                                              .letterSpacing(-0.15)
                                              .color(kPrimaryBlack),
                                          const VSpace(height: 12),
                                          (userType['type'] == 'vendor')
                                              ? const Text(
                                                  'I’m here to rent out items as a\nbusiness owner or just to make\nsome cash. ',
                                                  maxLines: 3,
                                                )
                                                  .regular()
                                                  .fontSize(12)
                                                  .color(kPrimaryBlack)
                                                  .letterSpacing(-0.13)
                                              : const Text(
                                                  'I’m here to order items on rent\nfor my personal needs or\nbusiness.',
                                                  maxLines: 3,
                                                )
                                                  .regular()
                                                  .fontSize(12)
                                                  .color(kPrimaryBlack)
                                                  .letterSpacing(-0.13)
                                        ],
                                      ),
                                    ],
                                  ),
                                  AppRadio(
                                    selected: (userType['type'] == 'vendor')
                                        ? selectedValue == 'vendor'
                                        : (userType['type'] == 'renter')
                                            ? selectedValue == 'renter'
                                            : selectedValue == 'renter',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ).paddingOnly(bottom: 20).onPressed(
                          () {
                            if (userType['type'] == 'vendor') {
                              toggleSelection('vendor');
                              typeId.value = userType['id'];
                              return;
                            }
                            if (userType['type'] == 'renter') {
                              toggleSelection('renter');
                              typeId.value = userType['id'];
                              return;
                            }
                          },
                        );
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ).paddingSymmetric(horizontal: kWidthPadding),
    );
  }
}
