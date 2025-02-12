import 'package:aider_mobile_app/core/services/logger_service.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/services/crash_service.dart';
import '../../../review/domain/review/review_model.dart';
import '../../domain/models/booked_product/booked_product_model.dart';
import '../../domain/models/booking/booking_model.dart';
import '../datasources/rental_local_datasource.dart';
import '../datasources/rental_remote_datasource.dart';
import '../../domain/models/booked_history_model.dart';

abstract class RentalRepository {
  Future<Either<Failure, BookedProductHistoryModel>> fetchRentedItems(
      {String? nextPage,
      required Map<String, dynamic> queryParam,
      bool isCompleted = false});
  Future<Either<Failure, BookedProductHistoryModel>> fetchMyItems(
      {String? nextPage,
      required Map<String, dynamic> queryParam,
      bool isCompleted = false});
  Future<Either<Failure, void>> confirmPickUp(
      {required String bookingUid, required String type});
  Future<Either<Failure, void>> confirmDropOff(
      {required String bookingUid, required String type});
  Future<Either<Failure, ReviewModel>> createProductReviews(
      {required String bookingUid, required Map<String, dynamic> requestBody});
  Future<Either<Failure, bool>> persistRentedItemHistory(
      BookedProductHistoryModel historyModel);
  Future<Either<Failure, bool>> persistMyItemHistory(
      BookedProductHistoryModel historyModel);
  Future<Either<Failure, void>> earlyReturn(
      {required String bookingUid, required BookedProductModel bookedProduct});
  Future<Either<Failure, void>> reportBookingWith(
      {required String externalId,
      required int bookingId,
      required String andReason});
  Stream<BookingModel> fetchBookingStream(String bookingExternalId);

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
  Future<Either<Failure, BookedProductHistoryModel>> fetchRentedItems(
      {String? nextPage,
      required Map<String, dynamic> queryParam,
      bool isCompleted = false}) async {
    try {
      final response = await rentalRemoteDataSource.fetchRentedItems(
          queryParam: queryParam, nextPage: nextPage, isCompleted: isCompleted);
      return Right(response);
    } catch (e, s) {
      ZLoggerService.logOnError('error fetching rented items: $e $s');
      CrashService.setCrashKey('product', 'Rented Items');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, BookedProductHistoryModel>> fetchMyItems(
      {String? nextPage,
      required Map<String, dynamic> queryParam,
      bool isCompleted = false}) async {
    try {
      final response = await rentalRemoteDataSource.fetchMyItems(
          queryParam: queryParam, nextPage: nextPage, isCompleted: isCompleted);
      return Right(response);
    } catch (e, s) {
      CrashService.setCrashKey('product', 'My Items');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, void>> confirmPickUp(
      {required String bookingUid, required String type}) async {
    try {
      await rentalRemoteDataSource.confirmPickUp(
          bookingUid: bookingUid, type: type);
      return const Right(null);
    } catch (e, s) {
      CrashService.setCrashKey('booking', 'confirm pick up');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, void>> confirmDropOff(
      {required String bookingUid, required String type}) async {
    try {
      await rentalRemoteDataSource.confirmDropOff(
          bookingUid: bookingUid, type: type);
      return const Right(null);
    } catch (e, s) {
      CrashService.setCrashKey('booking', 'confirm drop off');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, ReviewModel>> createProductReviews(
      {required String bookingUid,
      required Map<String, dynamic> requestBody}) async {
    try {
      final response = await rentalRemoteDataSource.createProductReviews(
          bookingUid: bookingUid, requestBody: requestBody);
      return Right(response);
    } catch (e, s) {
      ZLoggerService.logOnError('error creating product reviews: $e $s');
      CrashService.setCrashKey('booking', 'create product reviews');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, void>> earlyReturn({
    required String bookingUid,
    required BookedProductModel bookedProduct,
  }) async {
    try {
      await rentalRemoteDataSource.earlyReturn(
          bookingUid: bookingUid, bookedProduct: bookedProduct);
      return const Right(null);
    } catch (e, s) {
      ZLoggerService.logOnError('error early return: $e $s');
      CrashService.setCrashKey('booking', 'early return');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, bool>> persistRentedItemHistory(
      BookedProductHistoryModel historyModel) async {
    try {
      await rentalLocalDataSource.persistRentedItemHistory(historyModel);
      return const Right(true);
    } catch (e, s) {
      CrashService.setCrashKey(
          'userProduct', 'persisting user product history');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, bool>> persistMyItemHistory(
      BookedProductHistoryModel historyModel) async {
    try {
      await rentalLocalDataSource.persistMyItemHistory(historyModel);
      return const Right(true);
    } catch (e, s) {
      CrashService.setCrashKey('product', 'My Items');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, void>> reportBookingWith(
      {required String externalId,
      required int bookingId,
      required String andReason}) async {
    try {
      await rentalRemoteDataSource.reportBookingWith(
          externalId: externalId, bookingId: bookingId, andReason: andReason);
      return right(null);
    } catch (err) {
      CrashService.setCrashKey('report', 'Booking Report');
      return left(FailureToMessage.returnLeftError(err));
    }
  }

  @override
  Stream<BookingModel> fetchBookingStream(String bookingExternalId) {
    return rentalRemoteDataSource.fetchBookingStream(bookingExternalId);
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
