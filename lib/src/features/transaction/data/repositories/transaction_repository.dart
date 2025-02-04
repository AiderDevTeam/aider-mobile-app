import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/services/crash_service.dart';
import '../../../../../core/services/logger_service.dart';
import '../../../../../core/services/payment_service.dart';
import '../../domain/models/bank/bank_model.dart';
import '../datasources/transaction_local_datasource.dart';
import '../datasources/transaction_remote_datasource.dart';

abstract class TransactionRepository {
  Future<Either<Failure, String>> initiateTransaction(
      {required String bookingUid});
  Future<Either<Failure, String>> enquireAccountName(
      {required Map<String, dynamic> queryParam});
  Future<Either<Failure, bool>> collectionCallback({required String stan});
  Future<Either<Failure, BankList>> fetchBanks();

  /// LOCAL DB
  Future<Either<Failure, bool>> persistBanks(List<BankModel> banks);
}

class TransactionRepositoryImpl extends TransactionRepository {
  TransactionRepositoryImpl({
    required this.transactionRemoteDatasource,
    required this.transactionLocalDatasource,
  });

  final TransactionRemoteDatasource transactionRemoteDatasource;
  final TransactionLocalDatasource transactionLocalDatasource;

  @override
  Future<Either<Failure, String>> initiateTransaction(
      {required String bookingUid}) async {
    try {
      final response = await transactionRemoteDatasource.initiateTransaction(
          bookingUid: bookingUid);
      return Right(response);
    } catch (e, s) {
      ZLoggerService.logOnError('Failed to initiate transaction: $e');
      CrashService.setCrashKey('transaction', 'initiate a transaction');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, bool>> collectionCallback(
      {required String stan}) async {
    try {
      final response =
          await transactionRemoteDatasource.collectionCallback(stan: stan);
      return Right(response);
    } catch (e, s) {
      CrashService.setCrashKey('transaction', 'callback a transaction');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, bool>> persistBanks(List<BankModel> banks) async {
    try {
      await transactionLocalDatasource.persistBanks(banks);
      return const Right(true);
    } catch (e, s) {
      CrashService.setCrashKey('banks', 'persisting banks');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, String>> enquireAccountName(
      {required Map<String, dynamic> queryParam}) async {
    try {
      ZLoggerService.logOnDebug('queryParam enquireAccountName: $queryParam');
      final response = await transactionRemoteDatasource.enquireAccountName(
          queryParam: queryParam);
      return Right(response);
    } catch (e, s) {
      CrashService.setCrashKey('resolution', 'account name resolution');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, BankList>> fetchBanks() async {
    try {
      final result = await PaymentService.fetchBanks();
      return right(result);
    } catch (e, s) {
      ZLoggerService.logOnError('FETCHING BANKS ERROR ${e.toString()}');
      CrashService.setCrashKey('fetchBanks', 'Fetching banks');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }
}
