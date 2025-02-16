import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/services/crash_service.dart';
import '../../domain/verification_model/verification_model.dart';
import '../datasources/kyc_remote_datasource.dart';

abstract class KycRepository {
  Future<Either<Failure, VerificationModel>> initializeVerification(
      {required Map<String, dynamic> requestBody});
  Future<Either<Failure, List<VerificationModel>>> fetchUserKYC(
      {required Map<String, dynamic> requestBody});
}

class KycRepositoryImpl extends KycRepository {
  KycRepositoryImpl({
    required this.kycRemoteDataSource,
  });

  final KycRemoteDataSource kycRemoteDataSource;

  @override
  Future<Either<Failure, VerificationModel>> initializeVerification(
      {required Map<String, dynamic> requestBody}) async {
    try {
      final response = await kycRemoteDataSource.initializeVerification(
          requestBody: requestBody);
      return Right(response);
    } catch (e, s) {
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, List<VerificationModel>>> fetchUserKYC(
      {required Map<String, dynamic> requestBody}) async {
    try {
      final response =
          await kycRemoteDataSource.fetchUserKYC(requestBody: requestBody);
      // ZLoggerService.logOnInfo("Body Stack Trace: $response");
      return Right(response);
    } catch (e, s) {
      CrashService.setCrashKey('wallet', 'Fetching user kyc');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }
}
