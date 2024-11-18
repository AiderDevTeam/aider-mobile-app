
import 'package:aider_mobile_app/src/features/search/domain/models/search/search_model.dart';

import '../../../../../core/services/local_storage_service.dart';
import '../../../../../core/services/logger_service.dart';

abstract class SearchLocalDataSource{
  Future<void> persistSearchHistory(SearchModel historyModel);
}

class SearchLocalDataSourceImpl extends SearchLocalDataSource{

  SearchLocalDataSourceImpl({required this.localStorageService,});

  final LocalStorageService localStorageService;


  @override
  Future<void> persistSearchHistory(SearchModel historyModel) async{
    await localStorageService.encodeAndWrite('SearchHistory', historyModel.toJson());
    ZLoggerService.logOnInfo('PERSISTED SEARCHED HISTORY');
  }

}