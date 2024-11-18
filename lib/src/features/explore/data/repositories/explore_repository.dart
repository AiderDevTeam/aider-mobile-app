

import 'package:aider_mobile_app/core/errors/errors.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/services/crash_service.dart';
import '../../../product/domain/models/category/category_model.dart';
import '../../../product/domain/models/product/product_model.dart';
import '../datasources/explore_local_datasource.dart';
import '../datasources/explore_remote_datasource.dart';

abstract class ExploreRepository{
  Future<Either<Failure, List>> fetchSections({required Map<String, dynamic> queryParams});
  Future<Either<Failure, List<CategoryModel>>> fetchCategories({required String sectionExternalId, required Map<String, dynamic> queryParams});
  Future<Either<Failure, List<ProductModel>>> fetchProducts({required String sectionExternalId, required Map<String, dynamic> queryParams});
  Future<Either<Failure, List<ProductModel>>> fetchProductsByCategory({required String categoryExternalId, required Map<String, dynamic> queryParams});
  Future<Either<Failure, List<ProductModel>>> fetchFilteredProducts({required Map<String, dynamic> requestBody, required Map<String, dynamic> queryParams});

}

class ExploreRepositoryImpl extends ExploreRepository{
  ExploreRepositoryImpl({
    required this.exploreRemoteDatasource,
    required this.exploreLocalDatasource,
  });

  final ExploreRemoteDatasource exploreRemoteDatasource;
  final ExploreLocalDatasource exploreLocalDatasource;

  @override
  Future<Either<Failure, List>> fetchSections({required Map<String, dynamic> queryParams}) async{
    try{
      final response = await exploreRemoteDatasource.fetchSections(queryParams: queryParams);
      return Right(response);
    }catch(e, s){
      CrashService.setCrashKey('explore', 'fetching sections');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, List<CategoryModel>>> fetchCategories({required String sectionExternalId, required Map<String, dynamic> queryParams}) async{
    try{
      final response = await exploreRemoteDatasource.fetchCategories(sectionExternalId: sectionExternalId, queryParams: queryParams);
      return Right(response);
    }catch(e, s){
      CrashService.setCrashKey('explore', 'fetching categories');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> fetchProducts({required String sectionExternalId, required Map<String, dynamic> queryParams}) async{
    try{
      final response = await exploreRemoteDatasource.fetchProducts(sectionExternalId: sectionExternalId, queryParams: queryParams);
      return Right(response);
    }catch(e, s){
      CrashService.setCrashKey('explore', 'fetching products');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> fetchProductsByCategory({required String categoryExternalId, required Map<String, dynamic> queryParams}) async{
    try {
      final response = await exploreRemoteDatasource.fetchProductsByCategory(categoryExternalId: categoryExternalId, queryParams: queryParams);
      return Right(response);
    } catch (e, s) {
      CrashService.setCrashKey('product', 'Fetch products by Category');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> fetchFilteredProducts({required Map<String, dynamic> requestBody, required Map<String, dynamic> queryParams}) async{
    try{
      final response = await exploreRemoteDatasource.fetchFilteredProducts(requestBody: requestBody, queryParams: queryParams);
      return Right(response);
    }catch(e, s){
      CrashService.setCrashKey('product', 'list filtered products');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

}