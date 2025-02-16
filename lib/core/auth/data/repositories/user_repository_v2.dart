import 'package:aider_mobile_app/core/auth/data/datasources/user_local_datasource.dart';
import 'package:aider_mobile_app/core/auth/domain/models/user/user_model.dart';
import 'package:aider_mobile_app/core/auth/domain/models/user_types/user_type_model.dart';
import 'package:aider_mobile_app/core/errors/failure.dart';
import 'package:aider_mobile_app/core/services/logger_service.dart';
import 'package:dartz/dartz.dart';

import '../../../services/crash_service.dart';
import '../datasources/user_remote_datasource_v2.dart';

abstract class UserRepositoryV2 {
  Future<Either<Failure, UserModel>> updateUser({required UserModel user});
  Future<Either<Failure, void>> setPushNotificationToken(
      {required String pushNotificationToken});
  Future<Either<Failure, UserModel>> fetchUserDetail();
  Stream<UserModel?> fetchUserDetailStream();
  Future<Either<Failure, bool>> verifyDisplayName(
      {required String displayName});
  Future<Either<Failure, bool>> verifyEmail({required String email});
  Future<Either<Failure, String>> addProfileImage({required String imageUrl});
  Future<Either<Failure, List<UserTypeModel>>> fetchUserType();
  Future<Either<Failure, UserModel>> fetchUserDetailByUID(
      {required String uid});
}

class UserRepositoryV2Impl implements UserRepositoryV2 {
  final UserRemoteDatasourceV2 userRemoteDatasourceV2;
  final UserLocalDatasource userLocalDatasource;

  UserRepositoryV2Impl(
      {required this.userRemoteDatasourceV2,
      required this.userLocalDatasource});

  @override
  Future<Either<Failure, String>> addProfileImage(
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
      ZLoggerService.logOnError('Failed to fetch user detail: $e');
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

  @override
  Future<Either<Failure, UserModel>> fetchUserDetailByUID(
      {required String uid}) async {
    try {
      late UserModel? user;
      user = await userLocalDatasource.retrieveUserByUid(uid);

      if (user == null) {
        user = await userRemoteDatasourceV2.fetchUserDetailByUID(uid: uid);
        ZLoggerService.logOnInfo('fetchUserDetailByUID Fetching from remote');

        await userLocalDatasource.persistUser(user);
      }

      return Right(user);
    } catch (e, s) {
      ZLoggerService.logOnError('fetchUserDetailByUID Error: $e');
      CrashService.setCrashKey(
          'fetchUserDetailByUID', 'Fetching user detail by UID');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, void>> setPushNotificationToken(
      {required String pushNotificationToken}) async {
    try {
      await userRemoteDatasourceV2.setPushNotificationToken(
          pushNotificationToken: pushNotificationToken);
      return const Right(null);
    } catch (e, s) {
      CrashService.setCrashKey(
          'setPushNotificationToken', 'Setting push notification token');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }
}
