
import 'package:dartz/dartz.dart';

import '../../../errors/failure.dart';
import '../../../services/crash_service.dart';
import '../../../services/logger_service.dart';
import '../../domain/models/wallet/wallet_model.dart';
import '../../domain/models/user/user_model.dart';
import '../datasources/user_local_datasource.dart';
import '../datasources/user_remote_datasource.dart';

abstract class UserRepository{
  Future<Either<Failure, UserModel>> signup({required Map<String, dynamic> requestBody});
  Future<Either<Failure, UserModel>> login({required Map<String, dynamic> requestBody});
  Future<bool> isLoggedIn();
  Future<Either<Failure, String>> forgotPassword({required Map<String, dynamic> requestBody});
  Future<Either<Failure, bool>> resetPassword({required Map<String, dynamic> requestBody});
  Future<Either<Failure, bool>> logout();
  Future<Either<Failure, bool>> deleteAccount({required Map<String, dynamic> requestBody});
  Future<Either<Failure, UserModel>> updateUser({ required Map<String, dynamic> requestBody });
  Future<Either<Failure, UserModel>> fetchUserDetail({ required Map<String, dynamic> requestBody });
  Future<Either<Failure, bool>> verifyDisplayName({ required Map<String, dynamic> requestBody });
  Future<Either<Failure, bool>> verifyEmail({ required Map<String, dynamic> requestBody });
  Future<Either<Failure, String>> signUpOTP({ required Map<String, dynamic> requestBody });
  Future<Either<Failure, WalletModel>> saveWallet({ required Map<String, dynamic> requestBody });
  Future<Either<Failure, List<WalletModel>>> fetchWallet({ required Map<String, dynamic> requestBody });
  Future<Either<Failure, WalletModel>> setWalletToDefault({String? walletExternalId});
  Future<Either<Failure, bool>> addProfileImage({required Map<String, dynamic> requestBody});
  Future<Either<Failure, List<dynamic>>> userType();

  /// LOCAL DB
  Future<Either<Failure, UserModel>> retrieveUser();
  Future<Either<Failure, bool>> persistUser(UserModel user);
}


class UserRepositoryImpl extends UserRepository{
  UserRepositoryImpl({
    required this.userRemoteDatasource,
    required this.userLocalDatasource,
  });

  final UserRemoteDatasource userRemoteDatasource;
  final UserLocalDatasource userLocalDatasource;



  @override
  Future<Either<Failure, UserModel>> signup({required Map<String, dynamic> requestBody}) async{
    try{
      final response = await userRemoteDatasource.signup(requestBody: requestBody);
      return Right(response);
    }catch(e, s){
      CrashService.setCrashKey('signUp', 'Signing up');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, UserModel>> login({required Map<String, dynamic> requestBody}) async{
    try{
      final response = await userRemoteDatasource.login(requestBody: requestBody);
      return Right(response);
    }catch(e, s){
      CrashService.setCrashKey('login', 'logging user in');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<bool> isLoggedIn() async => await userLocalDatasource.isLoggedIn();

  @override
  Future<Either<Failure, String>> forgotPassword({ required Map<String, dynamic> requestBody }) async{
    try {
      final response = await userRemoteDatasource.forgotPassword(requestBody: requestBody);
      return Right(response);
    } catch (e, s) {
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, bool>> resetPassword({ required Map<String, dynamic> requestBody }) async{
    try {
      final response = await userRemoteDatasource.resetPassword(requestBody: requestBody);
      return Right(response);
    } catch (e, s) {
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async{
    try {
      final response = await userRemoteDatasource.logout();
      return Right(response);
    } catch (e) {
      CrashService.setCrashKey('logout', 'Logging out from account');
      return Left(FailureToMessage.returnLeftError(e));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteAccount({required Map<String, dynamic> requestBody}) async{
    try {
      final response = await userRemoteDatasource.deleteAccount(requestBody: requestBody);
      return Right(response);
    } catch (e, s) {
      CrashService.setCrashKey('deleteAccount', 'Deleting account');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, UserModel>> updateUser({ required Map<String, dynamic> requestBody }) async{
    try {
      final response = await userRemoteDatasource.updateUser(requestBody: requestBody);
      return Right(response);
    } catch (e, s) {
      CrashService.setCrashKey('updateUser', 'Updating user account');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, UserModel>> fetchUserDetail({ required Map<String, dynamic> requestBody }) async{
    try {
      final response = await userRemoteDatasource.fetchUserDetail(requestBody: requestBody);
      return Right(response);
    } catch (e, s) {
      CrashService.setCrashKey('fetchUserDetail', 'Fetching user details');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, UserModel>> retrieveUser() async{
    try {
      final response = await userLocalDatasource.retrieveUser();
      return Right(response);
    } catch (e, s) {
      CrashService.setCrashKey('retrieve', 'Retrieving user from local');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, bool>> persistUser(UserModel user) async{
    try {
      await userLocalDatasource.persistUser(user);
      return const Right(true);
    } catch (e, s) {
      CrashService.setCrashKey('persist', 'Persisting user to local');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, bool>> verifyDisplayName({required Map<String, dynamic> requestBody}) async{
    try {
      final response = await userRemoteDatasource.verifyDisplayName(requestBody: requestBody);
      return Right(response);
    } catch (e, s) {
      CrashService.setCrashKey('verify', 'Verifying display name');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, bool>> verifyEmail({required Map<String, dynamic> requestBody}) async{
    try {
      final response = await userRemoteDatasource.verifyEmail(requestBody: requestBody);
      return Right(response);
    } catch (e, s) {
      CrashService.setCrashKey('verify', 'Verifying email');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, String>> signUpOTP({required Map<String, dynamic> requestBody}) async{
    try {
      final response = await userRemoteDatasource.signUpOTP(requestBody: requestBody);
      return Right(response);
    } catch (e, s) {
      CrashService.setCrashKey('verify', 'Verifying email');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, WalletModel>> saveWallet({required Map<String, dynamic> requestBody}) async{
    try {
      final response = await userRemoteDatasource.saveWallet(requestBody: requestBody);
      return Right(response);
    } catch (e, s) {
      CrashService.setCrashKey('wallet', 'Saving a bank, wallet');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, List<WalletModel>>> fetchWallet({required Map<String, dynamic> requestBody}) async{
    try {
      final response = await userRemoteDatasource.fetchWallet(requestBody: requestBody);
      ZLoggerService.logOnInfo("Body Stack Trace: $response");
      return Right(response);
    } catch (e, s) {
      CrashService.setCrashKey('wallet', 'Fetching user wallets');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, WalletModel>> setWalletToDefault({String? walletExternalId}) async{
    try {
      final response = await userRemoteDatasource.setWalletToDefault(walletExternalId: walletExternalId);
      return Right(response);
    } catch (e, s) {
      CrashService.setCrashKey('wallet', 'Updating a bank wallet');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, bool>> addProfileImage({ required Map<String, dynamic> requestBody }) async{
    try {
      final response = await userRemoteDatasource.addProfileImage(requestBody: requestBody);
      return Right(response);
    } catch (e, s) {
      CrashService.setCrashKey('profile', 'Updating profile photo');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, List<dynamic>>> userType() async{
    try{
      final response = await userRemoteDatasource.userType();
      return Right(response);
    }catch(e, s){
      CrashService.setCrashKey('signup', 'user type');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }
}