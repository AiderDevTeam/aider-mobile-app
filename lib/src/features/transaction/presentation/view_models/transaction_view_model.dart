

import 'dart:collection';

import 'package:aider_mobile_app/core/view_models/base_view_model.dart';
import 'package:flutter/material.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/services/git_it_service_locator.dart';
import '../../../../../core/services/logger_service.dart';
import '../../../../../core/services/socket_service.dart';
import '../../../../../core/utils/app_dialog_util.dart';
import '../../../../shared_widgets/modals/error_modal_content.dart';
import '../../data/repositories/transaction_repository.dart';
import '../../domain/models/bank/bank_model.dart';
import '../../domain/models/transaction/transaction_model.dart';

class TransactionViewModel extends BaseViewModel{
  final _transactionRepository = sl.get<TransactionRepository>();
  bool _isPaymentLoading = false;

  /// INITIATE A TRANSACTION
  bool get isPaymentLoading => _isPaymentLoading;

  set setPaymentLoading(bool value){
    _isPaymentLoading = value;
    notifyListeners();
  }

  Future<TransactionModel?> initiateTransaction(BuildContext context,{required Map<String, dynamic> requestBody}) async{
    setPaymentLoading = true;
    final result = await _transactionRepository.initiateTransaction(requestBody: requestBody);

    TransactionModel? transaction;

    result.fold((failure){
      WidgetsBinding.instance.addPostFrameCallback((_) async{
        AppDialogUtil.popUpModal(
          context,
          modalContent: ErrorModalContent(
            errorMessage: FailureToMessage.mapFailureToMessage(failure),
          ),
        );
      });

    }, (trans){
      transaction = trans;
    });

    return transaction;
  }

  Future<void> collectionCallback(BuildContext context,{required String stan }) async{
    setPaymentLoading = false;
    final result = await _transactionRepository.collectionCallback(stan: stan);

    result.fold((failure){
      WidgetsBinding.instance.addPostFrameCallback((_) async{
        AppDialogUtil.popUpModal(
          context,
          modalContent: ErrorModalContent(
            errorMessage: FailureToMessage.mapFailureToMessage(failure),
          ),
        );
      });

    }, (right){

    });

  }

  /// ENQUIRE ACCOUNT NAME
  Map<String, dynamic> _accountNameDetail = {};
  UnmodifiableMapView<String, dynamic> get getAccountNameDetail => UnmodifiableMapView(_accountNameDetail);

  Future<void> enquireAccountName(BuildContext context,{required Map<String, dynamic> queryParam}) async{
    setLoading(true, component: 'resolution', notify: false);
    resetAccountName();
    final result = await _transactionRepository.enquireAccountName(queryParam: queryParam);

    result.fold((failure){
      WidgetsBinding.instance.addPostFrameCallback((_) async{
        AppDialogUtil.popUpModal(
          context,
          modalContent: ErrorModalContent(
            errorMessage: FailureToMessage.mapFailureToMessage(failure),
          ),
        );
      });
      setLoading(false, component: 'resolution');

    }, (right){
      _accountNameDetail = {'accountName': right};
      setLoading(false, component: 'resolution');
    });
  }

  void resetAccountName(){
    _accountNameDetail.clear();
    notifyListeners();
  }


  /// FETCH BANKS
  List<BankModel> _banks = [];

  void emitBanks(String? query){
    SocketService().emit('sendBanks', {"bankName": query});
    ZLoggerService.logOnInfo('EMITTING BANKS');
  }

  UnmodifiableListView<BankModel> get getBanks => UnmodifiableListView(_banks);



  void fetchBanks(){
    SocketService().once('fetchBanks', (data){
      ZLoggerService.logOnInfo('FETCHING BANKS \n ---- $data ---- \n${DateTime.now()}');
      if(data != null){
        _banks = BankList.fromJson(data).list;
        notifyListeners();
        // _persistReceivedChat();
      }
    });

    SocketService().off('fetchBanks');
  }




  /// LOCAL DB
  // void _persistBanks() async{
  //   final _ = await _transactionRepository.persistBanks(_banks);
  // }
  // void _persistReceivedChat() async{
  //   final _ = await _inboxRepository.persistReceivedChat(_receivedChats);
  // }

}