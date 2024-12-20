import 'package:aider_mobile_app/core/services/local_storage_service.dart';

import '../../../../../core/services/logger_service.dart';
import '../../../product/domain/models/product/product_model.dart';
import '../../domain/models/booked_history_model.dart';

abstract class RentalLocalDataSource{
  Future<List<ProductModel>> retrieveRentedItems();
  Future<void> persistRentedItemHistory(BookedProductHistoryModel historyModel);
  Future<void> persistMyItemHistory(BookedProductHistoryModel historyModel);
}

class RentalLocalDataSourceImpl extends RentalLocalDataSource{

  RentalLocalDataSourceImpl({required this.localStorageService,});

  final LocalStorageService localStorageService;

  @override
  Future<List<ProductModel>> retrieveRentedItems() async{
    var data = await localStorageService.read('fetchRentedItems');
    ZLoggerService.logOnInfo('RETRIEVING RENTED ITEMS ');
    return ProductModel.decode(data?? '');
  }

  @override
  Future<void> persistRentedItemHistory(BookedProductHistoryModel historyModel) async{
    await localStorageService.encodeAndWrite('bookedItemsHistory', historyModel.toJson());
    ZLoggerService.logOnInfo('PERSISTED BOOKED ITEMS HISTORY');
  }

  @override
  Future<void> persistMyItemHistory(BookedProductHistoryModel historyModel) async{
    await localStorageService.encodeAndWrite('myItemsHistory', historyModel.toJson());
    ZLoggerService.logOnInfo('PERSISTED MY ITEMS HISTORY');
  }

}
