import 'dart:collection';

import 'package:aider_mobile_app/core/providers/base_provider.dart';
import 'package:aider_mobile_app/core/services/payment_service.dart';
import 'package:flutter/material.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/services/git_it_service_locator.dart';
import '../../../../../core/services/logger_service.dart';
import '../../../../../core/utils/app_dialog_util.dart';
import '../../../../shared_widgets/modals/error_modal_content.dart';
import '../../data/repositories/transaction_repository.dart';
import '../../domain/models/bank/bank_model.dart';

class TransactionProvider extends BaseProvider {
  final _transactionRepository = sl.get<TransactionRepository>();
  bool _isPaymentLoading = false;

  /// INITIATE A TRANSACTION
  bool get isPaymentLoading => _isPaymentLoading;

  set setPaymentLoading(bool value) {
    _isPaymentLoading = value;
    notifyListeners();
  }

  Future<String?> initiateTransaction(BuildContext context,
      {required String bookingUid}) async {
    setPaymentLoading = true;
    final result = await _transactionRepository.initiateTransaction(
        bookingUid: bookingUid);

    setPaymentLoading = true;
    String? paymentUrl;

    result.fold((failure) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        AppDialogUtil.popUpModal(
          context,
          modalContent: ErrorModalContent(
            errorMessage: FailureToMessage.mapFailureToMessage(failure),
          ),
        );
      });
    }, (paymentUrlResponse) {
      paymentUrl = paymentUrlResponse;
    });

    return paymentUrl;
  }

  Future<void> collectionCallback(BuildContext context,
      {required String stan}) async {
    setPaymentLoading = false;
    final result = await _transactionRepository.collectionCallback(stan: stan);

    result.fold((failure) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        AppDialogUtil.popUpModal(
          context,
          modalContent: ErrorModalContent(
            errorMessage: FailureToMessage.mapFailureToMessage(failure),
          ),
        );
      });
    }, (right) {});
  }

  /// ENQUIRE ACCOUNT NAME
  Map<String, dynamic> _accountNameDetail = {};
  UnmodifiableMapView<String, dynamic> get getAccountNameDetail =>
      UnmodifiableMapView(_accountNameDetail);

  Future<void> enquireAccountName(BuildContext context,
      {required String accountNumber, required String bankCode}) async {
    setLoading(true, component: 'resolution', notify: true);
    resetAccountName();
    final result =
        await PaymentService.verifyAccountNumber(accountNumber, bankCode);

    result.fold((failure) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        AppDialogUtil.popUpModal(
          context,
          modalContent: ErrorModalContent(
            errorMessage: FailureToMessage.mapFailureToMessage(failure),
          ),
        );
      });
      setLoading(false, component: 'resolution');
    }, (right) {
      _accountNameDetail = {'accountName': right.data.accountName};
      setLoading(false, component: 'resolution');
    });
  }

  void resetAccountName() {
    _accountNameDetail.clear();
    notifyListeners();
  }

  /// FETCH BANKS
  List<BankModel> _banks = [];

  UnmodifiableListView<BankModel> get getBanks => UnmodifiableListView(_banks);

  List<BankModel> getFilteredBanks(String? query) {
    if (query == null || query.isEmpty) {
      return _banks;
    }
    return _banks
        .where((bank) =>
            bank.name != null &&
            bank.name!.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  bool _isFetchingBanks = false;
  bool get isFetchingBanks => _isFetchingBanks;

  bool _isFetchingBanksError = false;
  bool get isFetchingBanksError => _isFetchingBanksError;

  Future<void> fetchBanks() async {
    ZLoggerService.logOnInfo('FETCHING BANKS');
    _isFetchingBanks = true;

    final result = await _transactionRepository.fetchBanks();
    result.fold((failure) {
      _isFetchingBanksError = true;
    }, (banks) {
      _banks = banks.list;
      ZLoggerService.logOnInfo('FETCHING BANKS SUCCESS');
    });

    _isFetchingBanks = false;

    notifyListeners();
  }

  // LOCAL DB
  // void _persistBanks() async {
  //   final _ = await _transactionRepository.persistBanks(_banks);
  // }
  // void _persistReceivedChat() async{
  //   final _ = await _inboxRepository.persistReceivedChat(_receivedChats);
  // }
}
