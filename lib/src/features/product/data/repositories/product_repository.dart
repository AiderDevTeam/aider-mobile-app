

import 'package:aider_mobile_app/core/errors/errors.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/services/crash_service.dart';
import '../../domain/models/history/product_history_model.dart';
import '../../domain/models/product/product_model.dart';
import '../../domain/models/product_price/price_structure_model.dart';
import '../datasources/product_local_datasource.dart';
import '../datasources/product_remote_datasource.dart';

abstract class ProductRepository{
  Future<Either<Failure, ProductModel>> listProduct({required Map<String, dynamic> requestBody});
  Future<Either<Failure, ProductHistoryModel>> fetchUserProducts({String? nextPage, required Map<String, dynamic> queryParam});
  Future<Either<Failure, bool>> requestForItem(String productExternalId, {required Map<String, dynamic> requestBody});
  Future<Either<Failure, bool>> deleteProductPhoto({required String productExternalId, required Map<String, dynamic> requestBody});
  Future<Either<Failure, bool>> addProductPhoto({required String productExternalId, required Map<String, dynamic> requestBody});
  Future<Either<Failure, bool>> deleteProduct({required String productExternalId });
  Future<Either<Failure, ProductModel>> updateProduct({required String productExternalId, required Map<String, dynamic> requestBody});
  Future<Either<Failure, bool>> deleteProductPrice({required String productExternalId, required Map<String, dynamic> requestBody});
  Future<Either<Failure, ProductHistoryModel>> fetchVendorProducts({String? vendorExternalId, String? nextPage, required Map<String, dynamic> queryParam});

  /// LOCAL DB
  Future<Either<Failure, bool>> persistPriceStructure(List<PriceStructureModel> priceStructures);
  Future<Either<Failure, List<PriceStructureModel>>> retrievePriceStructure();
  Future<Either<Failure, bool>> persistUserProductHistory(ProductHistoryModel historyModel);
  Future<Either<Failure, ProductHistoryModel>> retrieveUserProductHistory();
}

class ProductRepositoryImpl extends ProductRepository{
  ProductRepositoryImpl({required this.productRemoteDatasource, required this.productLocalDatasource,});

  final ProductRemoteDatasource productRemoteDatasource;
  final ProductLocalDatasource productLocalDatasource;

  @override
  Future<Either<Failure, ProductModel>> listProduct({required Map<String, dynamic> requestBody}) async{
    try{
      final response = await productRemoteDatasource.listProduct(requestBody: requestBody);
      return Right(response);
    }catch(e, s){
      CrashService.setCrashKey('product', 'list product');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, bool>> persistPriceStructure(List<PriceStructureModel> priceStructures) async{
    try{
      await productLocalDatasource.persistPriceStructure(priceStructures);
      return const Right(true);
    }catch(e, s){
      CrashService.setCrashKey('priceStructure', 'persisting price structure');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, List<PriceStructureModel>>> retrievePriceStructure() async {
    try {
      final response = await productLocalDatasource.retrievePriceStructure();
      return Right(response);
    } catch (e, s) {
      CrashService.setCrashKey('priceStructure', 'retrieving price structure');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, ProductHistoryModel>> fetchUserProducts({String? nextPage, required Map<String, dynamic> queryParam}) async{
    try{
      final response = await productRemoteDatasource.fetchUserProducts(nextPage: nextPage, queryParam: queryParam);
      return Right(response);
    }catch(e, s){
      CrashService.setCrashKey('product', 'list user product');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, bool>> requestForItem(String productExternalId, {required Map<String, dynamic> requestBody}) async{
    try{
      final response = await productRemoteDatasource.requestForItem(productExternalId,requestBody: requestBody);
      return Right(response);
    }catch(e, s){
      CrashService.setCrashKey('product', 'request for product');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteProductPhoto({required String productExternalId, required Map<String, dynamic> requestBody}) async{
    try{
      final response = await productRemoteDatasource.deleteProductPhoto(productExternalId: productExternalId, requestBody: requestBody);
      return Right(response);
    }catch(e, s){
      CrashService.setCrashKey('product', 'deleting product photo');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, bool>> addProductPhoto({required String productExternalId, required Map<String, dynamic> requestBody}) async{
    try{
      final response = await productRemoteDatasource.addProductPhoto(productExternalId: productExternalId, requestBody: requestBody);
      return Right(response);
    }catch(e, s){
      CrashService.setCrashKey('product', 'add product photo');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteProduct({required String productExternalId }) async{
    try {
      final response = await productRemoteDatasource.deleteProduct(
        productExternalId: productExternalId,
      );
      return Right(response);
    } catch (e, s) {
      CrashService.setCrashKey('product', 'Fetch product');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, ProductModel>> updateProduct({required String productExternalId, required Map<String, dynamic> requestBody}) async{
    try{
      final response = await productRemoteDatasource.updateProduct(productExternalId: productExternalId, requestBody: requestBody);
      return Right(response);
    }catch(e, s){
      CrashService.setCrashKey('product', 'update product');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteProductPrice({required String productExternalId, required Map<String, dynamic> requestBody}) async{
    try{
      final response = await productRemoteDatasource.deleteProductPrice(productExternalId: productExternalId, requestBody: requestBody);
      return Right(response);
    }catch(e, s){
      CrashService.setCrashKey('product', 'delete product price');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, bool>> persistUserProductHistory(ProductHistoryModel historyModel) async{
    try{
      await productLocalDatasource.persistUserProductHistory(historyModel);
      return const Right(true);
    }catch(e, s){
      CrashService.setCrashKey('userProduct', 'persisting user product history');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, ProductHistoryModel>> retrieveUserProductHistory() async{
    try{
      final response = await productLocalDatasource.retrieveUserProductHistory();
      return Right(response);
    }catch(e, s){
      CrashService.setCrashKey('userProduct', 'retrieving user product history');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, ProductHistoryModel>> fetchVendorProducts({String? vendorExternalId, String? nextPage, required Map<String, dynamic> queryParam}) async{
    try{
      final response = await productRemoteDatasource.fetchVendorProducts(vendorExternalId: vendorExternalId, nextPage: nextPage, queryParam: queryParam);
      return Right(response);
    }catch(e, s){
      CrashService.setCrashKey('product', 'list vendor products');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }



}