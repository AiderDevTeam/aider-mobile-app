import 'package:aider_mobile_app/core/constants/colors.dart';
import 'package:aider_mobile_app/core/constants/common.dart';
import 'package:aider_mobile_app/core/extensions/widgets/align_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/gesture_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/core/utils/app_theme_util.dart';
import 'package:aider_mobile_app/core/providers/base_view.dart';
import 'package:aider_mobile_app/src/shared_widgets/base/app_screen_scaffold.dart';
import 'package:aider_mobile_app/src/shared_widgets/buttons/app_icon_text_button.dart';
import 'package:aider_mobile_app/src/shared_widgets/cards/app_card.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/app_radio.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/svg_icon.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/v_space.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/auth/domain/models/wallet/wallet_model.dart';
import '../../../../../core/providers/wallet_provider.dart';
import '../../../../../core/utils/app_dialog_util.dart';
import '../widgets/bank_account_modal.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final selectedWallet = ValueNotifier<WalletModel?>(null);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      await context.read<WalletProvider>().getWallets();
      selectedWallet.value = context.read<WalletProvider>().defaultWallet;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScreenScaffold(
      title: 'Payment Method',
      resizeToAvoidBottomInset: false,
      child: BaseView<WalletProvider>(
        builder: (context, walletConsumer, child) {
          if (walletConsumer.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (walletConsumer.userWallets.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "$kImagePath/payment.png",
                  width: AppThemeUtil.width(158),
                  height: AppThemeUtil.height(121),
                ).alignCenter(),
                const VSpace(height: 20),
                const Text(
                  'You don\'t have any bank \nsetup to receive payments',
                )
                    .medium()
                    .fontSize(16.0)
                    .color(kGrey1200)
                    .alignText(TextAlign.center)
                    .alignCenter(),
                const VSpace(height: 32),
                AppIconTextButton(
                  mainAxisSize: MainAxisSize.min,
                  onPressed: () {
                    AppDialogUtil.showScrollableBottomSheet(
                      context: context,
                      builder: (context) => const BankAccountModal(),
                    );
                  },
                  text: 'Add Bank',
                  icon: ZSvgIcon(
                    'plus_circle.svg',
                    size: AppThemeUtil.radius(20),
                    color: kPrimaryWhite,
                  ),
                  minWidth: 40,
                ),
                VSpace(height: MediaQuery.of(context).size.height * 0.1),
              ],
            );
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: walletConsumer.userWallets.length,
                  itemBuilder: (context, index) {
                    final wallet = walletConsumer.userWallets[index];
                    return ValueListenableBuilder<WalletModel?>(
                      valueListenable: selectedWallet,
                      builder: (context, selectedWalletValue, child) {
                        final isDefault = selectedWalletValue?.accountNumber ==
                            wallet.accountNumber;
                        return AppCard(
                          backgroundColor: kAider100,
                          padding: EdgeInsets.all(AppThemeUtil.radius(20)),
                          decoration: ShapeDecoration(
                            color: isDefault ? kAider100 : kGrey100,
                            shape: RoundedRectangleBorder(
                              side: isDefault
                                  ? const BorderSide(
                                      width: 1, color: kAiderDefault)
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
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(wallet.bankName ?? '')
                                          .semiBold()
                                          .fontSize(14.0)
                                          .color(kGrey1200),
                                      const VSpace(height: 4.0),
                                      Text(wallet.accountName ?? '')
                                          .regular()
                                          .fontSize(12.0)
                                          .color(kGrey1200)
                                          .overflowText(TextOverflow.ellipsis),
                                    ],
                                  ),
                                  AppRadio(selected: isDefault),
                                ],
                              ),
                              const VSpace(height: 4.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('*******${(wallet.accountNumber ?? '').substring((wallet.accountNumber ?? '').length - 4)}')
                                      .regular()
                                      .fontSize(14.0)
                                      .color(kGrey1200),
                                  if (isDefault)
                                    const Text("Default")
                                        .semiBold()
                                        .fontSize(14.0)
                                        .color(kAiderDefault),
                                ],
                              ),
                            ],
                          ),
                        ).onPressed(() async {
                          selectedWallet.value = wallet;
                          await context
                              .read<WalletProvider>()
                              .setDefaultWallet(context, wallet);
                        }).paddingOnly(bottom: 16.0);
                      },
                    );
                  },
                ),
                const VSpace(height: 16.0),
                AppIconTextButton(
                  onPressed: () async {
                    AppDialogUtil.showScrollableBottomSheet(
                      context: context,
                      builder: (context) => const BankAccountModal(),
                    );
                  },
                  minWidth: double.infinity,
                  text: 'Add Bank',
                  icon: const Icon(
                    CupertinoIcons.add_circled,
                    color: kPrimaryWhite,
                    size: 24,
                  ),
                ),
              ],
            ),
          );
        },
      ).paddingSymmetric(horizontal: kWidthPadding),
    );
  }
}
