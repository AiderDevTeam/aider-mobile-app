import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/services/crash_service.dart';
import '../../../product/domain/models/history/product_history_model.dart';
import '../../domain/review/review_history_model.dart';
import '../datasources/review_local_datasource.dart';
import '../datasources/review_remote_datasource.dart';

abstract class ReviewRepository{
  Future<Either<Failure, ProductHistoryModel>> fetchVendorProductsAndReviews({String? userExternalId, String? nextPage, required Map<String, dynamic> queryParam});
  Future<Either<Failure, ReviewHistoryModel>> fetchRenterReviews({String? userExternalId, String? nextPage, required Map<String, dynamic> queryParam});
  Future<Either<Failure, ReviewHistoryModel>> fetchVendorReviews({String? userExternalId, String? nextPage, required Map<String, dynamic> queryParam});

}

class ReviewRepositoryImpl extends ReviewRepository{
  ReviewRepositoryImpl(
      {required this.reviewRemoteDataSource,
        required this.reviewLocalDataSource,});

  final ReviewRemoteDataSource reviewRemoteDataSource;
  final ReviewLocalDataSource reviewLocalDataSource;

  @override
  Future<Either<Failure, ProductHistoryModel>> fetchVendorProductsAndReviews({String? userExternalId, String? nextPage, required Map<String, dynamic> queryParam}) async{
    try{
      final response = await reviewRemoteDataSource.fetchVendorProductsAndReviews(userExternalId: userExternalId, nextPage: nextPage, queryParam: queryParam);
      return Right(response);
    }catch(e, s){
      CrashService.setCrashKey('product', 'fetch vendor products and reviews');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, ReviewHistoryModel>> fetchRenterReviews({String? userExternalId, String? nextPage, required Map<String, dynamic> queryParam}) async{
    try{
      final response = await reviewRemoteDataSource.fetchRenterReviews(userExternalId: userExternalId, nextPage: nextPage, queryParam: queryParam);
      return Right(response);
    }catch(e, s){
      CrashService.setCrashKey('review', 'fetch renter reviews');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, ReviewHistoryModel>> fetchVendorReviews({String? userExternalId, String? nextPage, required Map<String, dynamic> queryParam}) async{
    try{
      final response = await reviewRemoteDataSource.fetchVendorReviews(userExternalId: userExternalId, nextPage: nextPage, queryParam: queryParam);
      return Right(response);
    }catch(e, s){
      CrashService.setCrashKey('review', 'fetch vendor reviews');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

}