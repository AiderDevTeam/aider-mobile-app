
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../domain/verification_model/verification_model.dart';
import '../datasources/kyc_remote_datasource.dart';

abstract class KycRepository{
  Future<Either<Failure, VerificationModel>> initializeVerification({ required Map<String, dynamic> requestBody });

}

class KycRepositoryImpl extends KycRepository {
  KycRepositoryImpl(
      {required this.kycRemoteDataSource,
      });

  final KycRemoteDataSource kycRemoteDataSource;

  @override
  Future<Either<Failure, VerificationModel>> initializeVerification({ required Map<String, dynamic> requestBody }) async{
    try {
      final response = await kycRemoteDataSource.initializeVerification(requestBody: requestBody);
      return Right(response);
    } catch (e, s) {
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

}