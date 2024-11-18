
import 'package:aider_mobile_app/core/services/local_storage_service.dart';

import '../../../../../core/services/logger_service.dart';
import '../../domain/models/bank/bank_model.dart';

abstract class TransactionLocalDatasource{
  Future<void> persistBanks(List<BankModel> banks);
}

class TransactionLocalDatasourceImpl extends TransactionLocalDatasource{

  TransactionLocalDatasourceImpl({required this.localStorageService,});

  final LocalStorageService localStorageService;

  @override
  Future<void> persistBanks(List<BankModel> banks) async{
    await localStorageService.write('banks', BankModel.encode(banks));
    ZLoggerService.logOnInfo('PERSISTED BANKS');
  }

}
