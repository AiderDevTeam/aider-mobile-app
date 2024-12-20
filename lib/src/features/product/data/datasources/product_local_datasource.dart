import 'package:aider_mobile_app/core/services/local_storage_service.dart';

import '../../../../../core/services/logger_service.dart';
import '../../domain/models/history/product_history_model.dart';
import '../../domain/models/product_price/price_structure_model.dart';

abstract class ProductLocalDatasource{
  Future<List<PriceStructureModel>> retrievePriceStructure();
  Future<void> persistPriceStructure(List<PriceStructureModel> priceStructures);
  Future<ProductHistoryModel> retrieveUserProductHistory();
  Future<void> persistUserProductHistory(ProductHistoryModel historyModel);
}

class ProductLocalDatasourceImpl extends ProductLocalDatasource{

  ProductLocalDatasourceImpl({required this.localStorageService,});

  final LocalStorageService localStorageService;

  @override
  Future<List<PriceStructureModel>> retrievePriceStructure() async{
    var data = await localStorageService.read('priceStructures');
    ZLoggerService.logOnInfo('RETRIEVING PRICE STRUCTURE');
    return PriceStructureModel.decode(data?? '');
  }

  @override
  Future<void> persistPriceStructure(List<PriceStructureModel> priceStructures) async{
    await localStorageService.write('priceStructures', PriceStructureModel.encode(priceStructures));
    ZLoggerService.logOnInfo('PERSISTED PRICE STRUCTURE');
  }

  @override
  Future<void> persistUserProductHistory(ProductHistoryModel historyModel) async{
    await localStorageService.encodeAndWrite('userProductHistory', historyModel.toJson());
    ZLoggerService.logOnInfo('PERSISTED USER PRODUCT HISTORY');
  }

  @override
  Future<ProductHistoryModel> retrieveUserProductHistory() async{
    var data  = await localStorageService.decodeAndReadMap('userProductHistory');
    ZLoggerService.logOnInfo('RETRIEVING USER PRODUCT HISTORY');
    return ProductHistoryModel.fromJson(data);
  }
}
