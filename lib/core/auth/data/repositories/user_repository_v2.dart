import 'package:aider_mobile_app/core/auth/domain/models/user/user_model.dart';
import 'package:aider_mobile_app/core/auth/domain/models/user_types/user_type_model.dart';
import 'package:aider_mobile_app/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

import '../../../services/crash_service.dart';
import '../datasources/user_remote_datasource_v2.dart';

abstract class UserRepositoryV2 {
  Future<Either<Failure, UserModel>> updateUser({required UserModel user});
  Future<Either<Failure, UserModel>> fetchUserDetail();
  Stream<UserModel?> fetchUserDetailStream();
  Future<Either<Failure, bool>> verifyDisplayName(
      {required String displayName});
  Future<Either<Failure, bool>> verifyEmail({required String email});
  Future<Either<Failure, void>> addProfileImage({required String imageUrl});
  Future<Either<Failure, List<UserTypeModel>>> fetchUserType();
}

class UserRepositoryV2Impl implements UserRepositoryV2 {
  final UserRemoteDatasourceV2 userRemoteDatasourceV2;

  UserRepositoryV2Impl({required this.userRemoteDatasourceV2});

  @override
  Future<Either<Failure, void>> addProfileImage(
      {required String imageUrl}) async {
    try {
      final result =
          await userRemoteDatasourceV2.addProfileImage(imageUrl: imageUrl);

      return Right(result);
    } catch (e, s) {
      CrashService.setCrashKey('addProfileImage', 'Adding profile image');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, UserModel>> fetchUserDetail() async {
    try {
      final result = await userRemoteDatasourceV2.fetchUserDetail();
      return Right(result);
    } catch (e, s) {
      CrashService.setCrashKey('fetchUserDetail', 'Fetching user detail');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Stream<UserModel?> fetchUserDetailStream() {
    try {
      final result = userRemoteDatasourceV2.fetchUserDetailStream();
      return result;
    } catch (e, s) {
      CrashService.setCrashKey(
          'fetchUserDetailStream', 'Fetching user detail stream');
      return Stream.error(e, s);
    }
  }

  @override
  Future<Either<Failure, UserModel>> updateUser(
      {required UserModel user}) async {
    try {
      print("Update user: ${user.toJson()}");
      final result = await userRemoteDatasourceV2.updateUser(user: user);
      return Right(result);
    } catch (e, s) {
      print("Update user error: $e");
      CrashService.setCrashKey('updateUser', 'Updating user');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, List<UserTypeModel>>> fetchUserType() async {
    try {
      final result = await userRemoteDatasourceV2.fetchUserType();
      return Right(result);
    } catch (e, s) {
      CrashService.setCrashKey('userType', 'Fetching user type');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, bool>> verifyDisplayName(
      {required String displayName}) async {
    try {
      final result = await userRemoteDatasourceV2.verifyDisplayName(
          displayName: displayName);
      return Right(result);
    } catch (e, s) {
      CrashService.setCrashKey('verifyDisplayName', 'Verifying display name');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, bool>> verifyEmail({required String email}) async {
    try {
      final result = await userRemoteDatasourceV2.verifyEmail(email: email);
      return Right(result);
    } catch (e, s) {
      CrashService.setCrashKey('verifyEmail', 'Verifying email');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }
}
