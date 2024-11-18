import 'package:aider_mobile_app/core/constants/colors.dart';
import 'package:aider_mobile_app/core/constants/common.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/v_space.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/routing/app_navigator.dart';
import '../../../../../core/utils/app_dialog_util.dart';
import '../../../../../core/view_models/base_view.dart';
import '../../../../../core/view_models/user_view_model.dart';
import '../../../../shared_widgets/common/app_list_tile.dart';
import '../../../../shared_widgets/base/app_screen_scaffold.dart';
import '../../../../shared_widgets/forms/app_switch_button.dart';
import '../../../../shared_widgets/modals/question_modal_content.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScreenScaffold(
      title: 'Notification',
      child: BaseView<UserViewModel>(
        builder: (context, userConsumer, child) {
          final user = userConsumer.getUser;
          return ListView(
            children: [
              // const VSpace(height: 44),
              AppListTile(
                title: const Text(
                  'Email updates',
                ).semiBold().fontSize(16).height(0.10, 16).letterSpacing(-0.42).color(kPrimaryBlack),
                subtitle: const Text(
                  'Enables receiving updates via your email',
                ).regular().fontSize(14).height(0.10, 14).letterSpacing(-0.42).color(kGrey700),
                trailing: AppSwitchButton(
                  value: user.canReceiveEmailUpdates ?? false,
                  onChanged: (value){
                    if(user.canReceiveEmailUpdates != true){
                      context.read<UserViewModel>().updateUser(
                        context,
                        requestBody: {
                          "canReceiveEmailUpdates": true
                        },
                      );
                      return;
                    }
                    AppDialogUtil.popUpModal(
                      context,
                      modalContent: QuestionModalContent(
                        title: 'Email Notification',
                        questionText: 'You might miss out on promotions and updates if disabled. Would you like to proceed?',
                        hasDangerIcon: true,
                        reverseYesNo: true,
                        onNoPressed: () async{
                        AppNavigator.pop(context);
                        },
                        onYesPressed: () async{
                          AppNavigator.pop(context);
                          await context.read<UserViewModel>().updateUser(
                            context,
                            requestBody: {
                              "canReceiveEmailUpdates": false
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              const VSpace(height: 22),
              AppListTile(
                title: const Text(
                  'Push notifications',
                ).semiBold().fontSize(16).height(0.10, 16).letterSpacing(-0.42).color(kPrimaryBlack),
                subtitle: const Text(
                  'Enables receiving updates via push',
                ).regular().fontSize(14).height(0.10, 14).letterSpacing(-0.42).color(kGrey700),
                trailing: AppSwitchButton(
                  value: user.canReceivePushNotifications ?? false,
                  onChanged: (value){
                    if(user.canReceivePushNotifications != true){
                      context.read<UserViewModel>().updateUser(
                        context,
                        requestBody: {
                          "canReceivePushNotifications": true
                        },
                      );
                      return;
                    }

                    AppDialogUtil.popUpModal(
                      context,
                      modalContent: QuestionModalContent(
                        title: 'Push Notifications',
                        questionText: 'You’ll lose important notifications in-app. We advise to keep this notification active at all times',
                        hasDangerIcon: true,
                        reverseYesNo: true,
                        onNoPressed: () async{
                          AppNavigator.pop(context);
                        },
                        onYesPressed: () async{
                          AppNavigator.pop(context);
                          await context.read<UserViewModel>().updateUser(
                            context,
                            requestBody: {
                              "canReceivePushNotifications": false
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              const VSpace(height: 22),
              AppListTile(
                title: const Text(
                  'SMS',
                ).semiBold().fontSize(16).height(0.10, 16).letterSpacing(-0.42).color(kPrimaryBlack),
                subtitle: const Text(
                  'Enables receiving updates via sms',
                ).regular().fontSize(14).height(0.10, 14).letterSpacing(-0.42).color(kGrey700),
                trailing: AppSwitchButton(
                  value: user.canReceiveSMS ?? false,
                  onChanged: (value){
                    if(user.canReceiveSMS != true){
                      context.read<UserViewModel>().updateUser(
                        context,
                        requestBody: {
                          "canReceiveSms": true
                        },
                      );
                      return;
                    }
                   AppDialogUtil.popUpModal(
                      context,
                      modalContent: QuestionModalContent(
                        title: 'SMS Notification',
                        questionText: 'You might miss out on promotions and updates if disabled. Would you like to proceed?',
                        hasDangerIcon: true,
                        reverseYesNo: true,
                        onNoPressed: () async{
                          AppNavigator.pop(context);
                        },
                        onYesPressed: () async{
                          AppNavigator.pop(context);
                          await context.read<UserViewModel>().updateUser(
                            context,
                            requestBody: {
                              "canReceiveSms": false
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              )
            ],
          ).paddingSymmetric(
              horizontal: kWidthPadding
          );
        }),
    );
  }
}
