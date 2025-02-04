import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../product/domain/models/history/product_history_model.dart';
import '../../domain/models/search/search_model.dart';

import '../datasources/search_local_datasource.dart';
import '../datasources/search_remote_datasource.dart';

abstract class SearchRepository {
  Future<Either<Failure, SearchModel>> searchAll(
      {required Map<String, dynamic> requestBody});
  Future<Either<Failure, ProductHistoryModel>> searchAllProducts(
      {required Map<String, dynamic> requestBody,
      String? nextPage,
      required Map<String, dynamic> queryParam});
}

class SearchRepositoryImpl extends SearchRepository {
  SearchRepositoryImpl({
    required this.searchRemoteDataSource,
    required this.searchLocalDataSource,
  });

  final SearchRemoteDataSource searchRemoteDataSource;
  final SearchLocalDataSource searchLocalDataSource;

  @override
  Future<Either<Failure, SearchModel>> searchAll(
      {required Map<String, dynamic> requestBody}) async {
    try {
      final response =
          await searchRemoteDataSource.searchAll(requestBody: requestBody);
      return Right(response);
    } catch (e, s) {
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, ProductHistoryModel>> searchAllProducts(
      {required Map<String, dynamic> requestBody,
      String? nextPage,
      required Map<String, dynamic> queryParam}) async {
    try {
      final response = await searchRemoteDataSource.searchAllProducts(
          requestBody: requestBody, nextPage: nextPage, queryParam: queryParam);
      return Right(response);
    } catch (e, s) {
      print(s);
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }
}
