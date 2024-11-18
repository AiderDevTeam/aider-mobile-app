import 'package:aider_mobile_app/core/auth/domain/models/wallet/wallet_model.dart';
import 'package:aider_mobile_app/core/constants/colors.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/core/utils/app_theme_util.dart';
import 'package:aider_mobile_app/src/features/profile/presentation/widgets/search_banks_modal.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/svg_icon.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/v_space.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions_item.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/common.dart';
import '../../../../../core/utils/app_dialog_util.dart';
import '../../../../../core/view_models/base_view.dart';
import '../../../../../core/view_models/user_view_model.dart';
import '../../../../shared_widgets/base/draggable_bottom_sheet.dart';
import '../../../../shared_widgets/buttons/app_primary_button.dart';
import '../../../../shared_widgets/common/app_keyboard_action.dart';
import '../../../../shared_widgets/common/zloading.dart';
import '../../../../shared_widgets/forms/app_input_field.dart';
import '../../../../shared_widgets/forms/form_label.dart';
import '../../../../shared_widgets/modals/draggable_bottom_sheet_content.dart';
import '../../../transaction/domain/models/bank/bank_model.dart';
import '../../../transaction/presentation/view_models/transaction_view_model.dart';

class BankAccountModal extends StatefulWidget {
  const BankAccountModal({super.key, this.update = false, this.selectedWallet,});

  final bool update;
  final WalletModel? selectedWallet;

  @override
  State<BankAccountModal> createState() => _BankAccountModalState();
}

class _BankAccountModalState extends State<BankAccountModal> {
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;
  final selectedItem = ValueNotifier<String?>(null);
  final accountNumberController = TextEditingController();
  final bankController = TextEditingController();
  final accountNumberFocusNode = FocusNode();
  BankModel? selectedBank;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(!mounted) return;
      context.read<TransactionViewModel>().resetAccountName();
    });
    super.initState();
  }

  @override
  void dispose() {
    accountNumberController.dispose();
    bankController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableBottomSheet(
      initialChildSize: 0.75,
      minChildSize: 0.75,
      maxChildSize: 0.90,
      builder: (context, scrollController) {
        return DraggableBottomSheetContent(
          draggableKey: GlobalKey(),
          scrollController: scrollController,
          title: 'Add new bank',
          content: AppKeyboardAction(
            actions: [
              KeyboardActionsItem(focusNode: accountNumberFocusNode),
            ],
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                autovalidateMode: autoValidate,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const VSpace(height: 18.0),
                    const FormLabel(text: 'Select Bank'),
                    const VSpace(height: 8.0),
                    AppInputField(
                      hintText: 'Select a bank',
                      controller: bankController,
                      validator: (value) {
                        if (value!.isEmpty) return 'Bank field must not be empty';
                        return null;
                      },
                      helperHeight: 0.1,
                      readOnly: true,
                      onTap: () async{
                        final result = await AppDialogUtil.showScrollableBottomSheet(
                          context: context,
                          builder: (context) => const SearchBanksModal(),
                        );
                        if(result != null){
                          bankController.text = (result as BankModel).name?? '';
                          selectedBank = result;
                          if(bankController.text.isNotEmpty && accountNumberController.text.isNotEmpty){
                            if(!mounted) result;
                            await enquireAccountName(accountNumberController.text, result.bankCode?? '');
                          }
                        }
                      },
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ZSvgIcon(
                            'caret_down.svg',
                            size: AppThemeUtil.radius(24),
                          ).paddingOnly(right: 16),
                        ],
                      ),
                    ),

                    const VSpace(height: 24.0),
                    const FormLabel(text: 'Account Number'),
                    const VSpace(height: 8.0),

                    FocusScope(
                      child: Focus(
                        onFocusChange: (focus) async{
                          if(!focus && (accountNumberController.text.isNotEmpty && bankController.text.isNotEmpty)){
                            await enquireAccountName(accountNumberController.text, selectedBank?.bankCode?? '');
                          }
                        },
                        child: AppInputField(
                          hintText: 'Enter account number',
                          controller: accountNumberController,
                          focusNode: accountNumberFocusNode,
                          validator: (value) {
                            if (value!.isEmpty) return 'Enter your bank account number';
                            return null;
                          },
                          helperHeight: 0.1,
                          suffixIcon: BaseView<TransactionViewModel>(
                              builder: (context, transactionConsumer, child) {
                              return transactionConsumer.getComponentLoading('resolution')?
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const ZLoading().paddingOnly(right: 16.0),
                                ],
                              ) : const SizedBox.shrink();
                            }
                          ),
                        ),
                      ),
                    ),

                    BaseView<TransactionViewModel>(
                      builder: (context, transactionConsumer, child){
                        if(transactionConsumer.getAccountNameDetail['accountName'] == null) return const SizedBox.shrink();
                        return Container(
                          padding: EdgeInsets.all(AppThemeUtil.radius(16.0)),
                          decoration: BoxDecoration(
                              color: kSuccess100,
                              borderRadius: BorderRadius.circular(AppThemeUtil.radius(12.0))
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(transactionConsumer.getAccountNameDetail['accountName']?? '').semiBold().fontSize(14.0).color(kGrey1200),
                              Icon(
                                Icons.check_circle,
                                color: kSuccess700,
                                size: AppThemeUtil.radius(20),
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    const VSpace(height: 32.0),
                    AppPrimaryButton(
                      onPressed: () async{
                        final transactionProvider = context.read<TransactionViewModel>();
                        if(transactionProvider.getComponentLoading('resolution')) return;

                        if(formKey.currentState!.validate()) {
                          if (widget.update) {
                            return;
                          }
                          if(transactionProvider.getAccountNameDetail['accountName'] == null){
                            AppDialogUtil.showWarningAlert(context, 'Your account name is not verified');
                            return;
                          }

                          await context.read<UserViewModel>().saveWallet(
                            context,
                            requestBody: {
                              "accountNumber": accountNumberController.text,
                              "accountName": transactionProvider.getAccountNameDetail['accountName'],
                              "sortCode": selectedBank?.sortCode,
                              "bankCode": selectedBank?.bankCode
                            },
                          );
                        }
                      },
                      text: widget.update? 'Update Bank' : "Add Bank",
                      minWidth: double.infinity,
                    ),
                  ],
                ),
              ).paddingSymmetric(horizontal: kWidthPadding),
            ),
          ),
        );
      },
    );
  }

  Future<void> enquireAccountName(String accountNumber, String bankCode) async{
    await context.read<TransactionViewModel>().enquireAccountName(
      context,
      queryParam: {
        'accountNumber': accountNumber,
        'bankCode': bankCode,
      }
    );
  }

}
