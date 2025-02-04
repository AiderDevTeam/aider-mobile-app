import 'package:aider_mobile_app/core/constants/colors.dart';
import 'package:aider_mobile_app/core/extensions/widgets/gesture_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/core/utils/app_theme_util.dart';
import 'package:aider_mobile_app/src/shared_widgets/buttons/app_text_button.dart';
import 'package:aider_mobile_app/src/shared_widgets/modals/question_modal_content.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/v_space.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/common.dart';
import '../../../../../core/providers/auth_provider.dart';
import '../../../../../core/routing/app_navigator.dart';
import '../../../../../core/utils/app_dialog_util.dart';
import '../../../../shared_widgets/common/app_bottom_nav_wrapper.dart';
import '../../../../shared_widgets/base/draggable_bottom_sheet.dart';
import '../../../../shared_widgets/buttons/app_primary_button.dart';
import '../../../../shared_widgets/forms/app_input_field.dart';
import '../../../../shared_widgets/common/row_text.dart';
import '../../../../shared_widgets/modals/draggable_bottom_sheet_content.dart';

class DeleteAccountModal extends StatefulWidget {
  const DeleteAccountModal({super.key});

  @override
  State<DeleteAccountModal> createState() => _DeleteAccountModalState();
}

class _DeleteAccountModalState extends State<DeleteAccountModal> {
  final otherReasonsController = TextEditingController();
  late String selectedText = '';
  List report = [
    'App not working well',
    'I’m just not interested',
    'I have other accounts',
    'Items are too expensive',
    'Other'
  ];
  bool isOther = false;

  @override
  void dispose() {
    otherReasonsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableBottomSheet(
      initialChildSize: 0.82,
      minChildSize: 0.45,
      maxChildSize: 0.90,
      builder: (context, scrollController) {
        return DraggableBottomSheetContent(
          bottomNavigationBar: AppBottomNavWrapper(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppTextButton(
                  onPressed: () {},
                  child: const Text(
                    'Or you can contact customer service instead?',
                  )
                      .bold()
                      .fontSize(14)
                      .color(kPrimaryBlack)
                      .alignText(TextAlign.center),
                ),
                AppPrimaryButton(
                  onPressed: (otherReasonsController.text.isNotEmpty ||
                          selectedText.isNotEmpty)
                      ? () async {
                          // sl.get<MixpanelService>().trackAuthEvent('Submit Delete Account', user);
                          AppDialogUtil.popUpModal(
                            context,
                            modalContent: QuestionModalContent(
                              title: 'Delete Account',
                              questionText:
                                  'Are you sure you want to delete account?',
                              hasDangerIcon: true,
                              reverseYesNo: true,
                              icon: CircleAvatar(
                                radius: AppThemeUtil.radius(40),
                                backgroundColor: kAider800,
                                child: Icon(
                                  Icons.close,
                                  size: AppThemeUtil.radius(60),
                                ),
                              ),
                              onYesPressed: () async {
                                // sl.get<MixpanelService>().trackAuthEvent('Yes Delete Account Tapped', user);
                                AppNavigator.pop(context);
                                await context
                                    .read<AuthProvider>()
                                    .deleteAccount(context);
                              },
                            ),
                          );
                        }
                      : null,
                  text: "Submit",
                  minWidth: double.infinity,
                ),
              ],
            ),
          ),
          draggableKey: GlobalKey(),
          scrollController: scrollController,
          modalHeaderContent: RowText(
            leftWidget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Delete account')
                    .bold()
                    .fontSize(16)
                    .color(kPrimaryBlack)
                    .height(24, 16),
                const VSpace(height: 8),
                const Text(
                  'Tell us why you want to delete your account',
                ).regular().fontSize(14).color(kPrimaryBlack)
              ],
            ),
          ).paddingOnly(left: kWidthPadding, right: kWidthPadding, bottom: 10),
          content: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: AppThemeUtil.width(24.0)),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      itemCount: report.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        isShowOther() {
                          setState(() => selectedText = report[index]);
                          if (report[index] == 'Other') {
                            setState(() {
                              isOther = true;
                            });
                          } else {
                            setState(() {
                              isOther = false;
                            });
                          }
                        }

                        return RowText(
                          leftWidget: Text(
                            report[index],
                          )
                              .regular()
                              .fontSize(16)
                              .color(kPrimaryBlack)
                              .height(0.09, 16),
                          rightWidget: Radio<String>(
                            activeColor: kPrimaryBlack,
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                            value: report[index],
                            groupValue: selectedText,
                            onChanged: (value) {
                              setState(() => selectedText = value!);
                              isShowOther();
                            },
                          ),
                        ).onPressed(() {
                          isShowOther();
                        });
                      },
                    ),
                    const VSpace(height: 12),
                    (isOther == true)
                        ? AppInputField(
                            hintText: "Enter reasons here",
                            controller: otherReasonsController,
                            maxLine: 4,
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              )).paddingOnly(top: 24),
        );
      },
    );
  }
}
