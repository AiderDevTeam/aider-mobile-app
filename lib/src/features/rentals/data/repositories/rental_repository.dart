import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/services/crash_service.dart';
import '../../../review/domain/review/review_model.dart';
import '../../domain/models/booking/booking_model.dart';
import '../datasources/rental_local_datasource.dart';
import '../datasources/rental_remote_datasource.dart';
import '../../domain/models/booked_history_model.dart';

abstract class RentalRepository {
  Future<Either<Failure, BookedProductHistoryModel>> fetchRentedItems({String? nextPage, required Map<String, dynamic> queryParam});
  Future<Either<Failure, BookedProductHistoryModel>> fetchMyItems({String? nextPage, required Map<String, dynamic> queryParam});
  Future<Either<Failure, BookingModel>> confirmPickUp({required String bookingExternalId, required Map<String, dynamic> requestBody});
  Future<Either<Failure, BookingModel>> confirmDropOff({required String bookingExternalId, required Map<String, dynamic> requestBody});
  Future<Either<Failure, ReviewModel>> createProductReviews({required String bookingExternalId, required Map<String, dynamic> requestBody});
  Future<Either<Failure, bool>> persistRentedItemHistory(BookedProductHistoryModel historyModel);
  Future<Either<Failure, bool>> persistMyItemHistory(BookedProductHistoryModel historyModel);
  Future<Either<Failure, BookingModel>> earlyReturn({required String bookedProductExternalId});
  Future<Either<Failure, void>> reportBookingWith({required String externalId, required int bookingId, required String andReason});

  // Future<Either<Failure, bool>> persistReviewHistory(ReviewModel historyModel);
  // Future<Either<Failure, bool>> retrieveReviewHistory();
}

class RentalRepositoryImpl extends RentalRepository {
  RentalRepositoryImpl({
    required this.rentalRemoteDataSource,
    required this.rentalLocalDataSource,
  });

  final RentalRemoteDataSource rentalRemoteDataSource;
  final RentalLocalDataSource rentalLocalDataSource;

  @override
  Future<Either<Failure, BookedProductHistoryModel>> fetchRentedItems({String? nextPage, required Map<String, dynamic> queryParam}) async {
    try {
      final response = await rentalRemoteDataSource.fetchRentedItems(queryParam: queryParam, nextPage: nextPage);
      return Right(response);
    } catch (e, s) {
      CrashService.setCrashKey('product', 'Rented Items');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, BookedProductHistoryModel>> fetchMyItems({String? nextPage, required Map<String, dynamic> queryParam}) async {
    try {
      final response = await rentalRemoteDataSource.fetchRentedItems(queryParam: queryParam, nextPage: nextPage);
      return Right(response);
    } catch (e, s) {
      CrashService.setCrashKey('product', 'My Items');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, BookingModel>> confirmPickUp({required String bookingExternalId, required Map<String, dynamic> requestBody}) async {
    try {
      final response = await rentalRemoteDataSource.confirmPickUp(bookingExternalId: bookingExternalId, requestBody: requestBody);
      return Right(response);
    } catch (e, s) {
      CrashService.setCrashKey('booking', 'confirm pick up');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, BookingModel>> confirmDropOff({required String bookingExternalId, required Map<String, dynamic> requestBody}) async {
    try {
      final response = await rentalRemoteDataSource.confirmDropOff(bookingExternalId: bookingExternalId, requestBody: requestBody);
      return Right(response);
    } catch (e, s) {
      CrashService.setCrashKey('booking', 'confirm drop off');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, ReviewModel>> createProductReviews({required String bookingExternalId, required Map<String, dynamic> requestBody}) async {
    try {
      final response = await rentalRemoteDataSource.createProductReviews(bookingExternalId: bookingExternalId, requestBody: requestBody);
      return Right(response);
    } catch (e, s) {
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, BookingModel>> earlyReturn({
    required String bookedProductExternalId,
  }) async {
    try {
      final response = await rentalRemoteDataSource.earlyReturn(bookedProductExternalId: bookedProductExternalId);
      return Right(response);
    } catch (e, s) {
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, bool>> persistRentedItemHistory(BookedProductHistoryModel historyModel) async {
    try {
      await rentalLocalDataSource.persistRentedItemHistory(historyModel);
      return const Right(true);
    } catch (e, s) {
      CrashService.setCrashKey('userProduct', 'persisting user product history');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, bool>> persistMyItemHistory(BookedProductHistoryModel historyModel) async {
    try {
      await rentalLocalDataSource.persistMyItemHistory(historyModel);
      return const Right(true);
    } catch (e, s) {
      CrashService.setCrashKey('product', 'My Items');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, void>> reportBookingWith({required String externalId, required int bookingId, required String andReason}) async {
    try {
      await rentalRemoteDataSource.reportBookingWith(externalId: externalId, bookingId: bookingId, andReason: andReason);
      return right(null);
    } catch (err) {
      CrashService.setCrashKey('report', 'Booking Report');
      return left(FailureToMessage.returnLeftError(err));
    }
  }

  // @override
  // Future<Either<Failure, bool>> persistReviewHistory(ReviewModel historyModel) async{
  //   try{
  //     await rentalLocalDataSource.persistReviewHistory(historyModel);
  //     return const Right(true);
  //   }catch(e, s){
  //     CrashService.setCrashKey('review', 'Reviews');
  //     return Left(FailureToMessage.returnLeftError(e, s));
  //   }
  // }
}
