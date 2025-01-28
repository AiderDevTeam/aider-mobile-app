import 'package:aider_mobile_app/core/errors/errors.dart';
import 'package:aider_mobile_app/core/auth/domain/models/login/login_model.dart';
import 'package:dartz/dartz.dart';

import '../../../services/crash_service.dart';
import '../datasources/auth_remote_datasource.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginModel>> signup({
    required String email,
    required String password,
  });

  Future<Either<Failure, LoginModel>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> logout();
  Future<Either<Failure, void>> deleteAccount();

  Future<Either<Failure, void>> verifyOTP({
    required String email,
    required String otp,
  });

  Future<Either<Failure, void>> sendOTP({
    required String email,
  });

  Future<Either<Failure, void>> forgotPassword({required String email});

  Future<Either<Failure, void>> resetPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, bool>> isLoggedIn();

  Future<Either<Failure, void>> changePassword({
    required String oldPassword,
    required String newPassword,
  });
}

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({required this.authRemoteDatasource});

  final AuthRemoteDatasource authRemoteDatasource;

  @override
  Future<Either<Failure, void>> deleteAccount() async {
    try {
      final result = await authRemoteDatasource.deleteAccount();
      return Right(result);
    } catch (e, s) {
      CrashService.setCrashKey('deleteAccount', 'Deleting account');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, void>> forgotPassword({required String email}) async {
    try {
      final result = await authRemoteDatasource.forgotPassword(email: email);
      return Right(result);
    } catch (e, s) {
      CrashService.setCrashKey('forgotPassword', 'Forgot password');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, LoginModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final result =
          await authRemoteDatasource.login(email: email, password: password);
      return Right(result);
    } catch (e, s) {
      CrashService.setCrashKey('login', 'Logging in');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      final result = await authRemoteDatasource.logout();
      return Right(result);
    } catch (e, s) {
      CrashService.setCrashKey('logout', 'Logging out');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword({
    required String email,
    required String password,
  }) async {
    try {
      final result = await authRemoteDatasource.resetPassword(
          email: email, password: password);
      return Right(result);
    } catch (e, s) {
      CrashService.setCrashKey('resetPassword', 'Resetting password');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, LoginModel>> signup({
    required String email,
    required String password,
  }) async {
    try {
      final result =
          await authRemoteDatasource.signup(email: email, password: password);
      return Right(result);
    } catch (e, s) {
      CrashService.setCrashKey('signup', 'Signing up');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, void>> verifyOTP({
    required String email,
    required String otp,
  }) async {
    try {
      final result =
          await authRemoteDatasource.verifyOTP(email: email, otp: otp);
      return Right(result);
    } catch (e, s) {
      CrashService.setCrashKey('verifyOTP', 'Verifying OTP');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, bool>> isLoggedIn() async {
    try {
      final result = await authRemoteDatasource.isLoggedIn();
      return Right(result);
    } catch (e, s) {
      CrashService.setCrashKey('isLoggedIn', 'Checking if logged in');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, void>> sendOTP({required String email}) async {
    try {
      final result = await authRemoteDatasource.sendOTP(email: email);
      return Right(result);
    } catch (e, s) {
      CrashService.setCrashKey('sendOTP', 'Sending OTP');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, void>> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final result = await authRemoteDatasource.changePassword(
          oldPassword: oldPassword, newPassword: newPassword);
      return Right(result);
    } catch (e, s) {
      CrashService.setCrashKey('changePassword', 'Changing password');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }
}
