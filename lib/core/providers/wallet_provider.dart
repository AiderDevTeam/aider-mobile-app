import 'package:aider_mobile_app/core/errors/failure.dart';
import 'package:aider_mobile_app/core/providers/base_provider.dart';
import 'package:aider_mobile_app/core/routing/app_navigator.dart';
import 'package:aider_mobile_app/core/services/git_it_service_locator.dart';
import 'package:aider_mobile_app/core/services/logger_service.dart';
import 'package:flutter/material.dart';

import '../../src/shared_widgets/modals/error_modal_content.dart';
import '../../src/shared_widgets/modals/success_modal_content.dart';
import '../auth/data/repositories/wallet_repository.dart';
import '../auth/domain/models/wallet/wallet_model.dart';
import '../utils/app_dialog_util.dart';

class WalletProvider extends BaseProvider {
  final _walletRepository = sl.get<WalletRepository>();

  List<WalletModel> _userWallets = [];

  List<WalletModel> get userWallets => _userWallets;

  WalletModel _defaultWallet = const WalletModel();

  WalletModel get defaultWallet => _defaultWallet;

  set setWalletAsDefault(WalletModel wallet) {
    _defaultWallet = wallet;
    notifyListeners();
  }

  void addWallet(WalletModel wallet) {
    _userWallets.add(wallet);
    notifyListeners();
  }

  void removeWallet(WalletModel wallet) {
    _userWallets.remove(wallet);
    notifyListeners();
  }

  Future<void> createWallet(BuildContext context, WalletModel wallet) async {
    ZLoggerService.logOnInfo('CREATE WALLET ${wallet.toJson()}');
    AppDialogUtil.loadingDialog(context);

    final result = await _walletRepository.createWallet(wallet);
    result.fold((failure) {
      if (context.mounted) AppNavigator.pop(context);

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        AppDialogUtil.popUpModal(
          context,
          modalContent: ErrorModalContent(
            errorMessage: FailureToMessage.mapFailureToMessage(failure),
          ),
        );
      });
    }, (wallet) {
      AppNavigator.pop(context);
      addWallet(wallet);
      AppDialogUtil.popUpModal(
        context,
        modalContent: SuccessModalContent(
          title: 'Bank Account',
          message: 'Bank account added to wallet.',
          onButtonPressed: () {
            AppNavigator.of(context)
              ..pop()
              ..pop();
          },
        ),
      );
    });
  }

  Future<void> getWallets() async {
    setLoading(true);
    notifyListeners();

    final result = await _walletRepository.getWallets();
    result.fold((failure) {}, (wallets) {
      _userWallets = wallets;
      setWalletAsDefault =
          wallets.firstWhere((wallet) => wallet.isDefault == true);
    });

    setLoading(false);

    notifyListeners();
  }

  Future<void> setDefaultWallet(
      BuildContext context, WalletModel wallet) async {
    AppDialogUtil.loadingDialog(context);

    final result = await _walletRepository.swapDefaultWallet(
        wallet.uid!, defaultWallet.uid!);

    result.fold((failure) {
      if (context.mounted) AppNavigator.pop(context);
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        AppDialogUtil.popUpModal(
          context,
          modalContent: ErrorModalContent(
            errorMessage: FailureToMessage.mapFailureToMessage(failure),
          ),
        );
      });
    }, (_) {
      setWalletAsDefault = wallet;
      if (context.mounted) AppNavigator.pop(context);
      AppDialogUtil.popUpModal(
        context,
        modalContent: SuccessModalContent(
          title: 'Changed Default Wallet',
          message: 'Default wallet changed to ${wallet.accountNumber}',
          onButtonPressed: () {
            AppNavigator.of(context).pop();
          },
        ),
      );
    });
  }
}
