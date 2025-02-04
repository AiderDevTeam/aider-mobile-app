import 'package:aider_mobile_app/core/errors/errors.dart';
import 'package:aider_mobile_app/core/services/http_service_requester.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../services/remote_config_service.dart';
import '../../domain/models/login/login_model.dart';

abstract class AuthRemoteDatasource {
  Future<LoginModel> signup({required String email, required String password});
  Future<LoginModel> login({required String email, required String password});
  Future<void> logout();
  Future<void> deleteAccount();
  Future<void> verifyOTP(
      {required String email,
      required String otp,
      bool isResetPassword = false});
  Future<void> forgotPassword({required String email});
  Future<void> changePassword(
      {required String oldPassword, required String newPassword});
  Future<void> resetPassword(
      {required String email, required String otp, required String password});
  Future<bool> isLoggedIn();
  Future<void> sendOTP({required String email});
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  const AuthRemoteDatasourceImpl({
    required this.firebaseAuth,
    required this.httpServiceRequester,
  });

  final FirebaseAuth firebaseAuth;
  final HttpServiceRequester httpServiceRequester;

  @override
  Future<void> deleteAccount() async {
    return firebaseAuth.currentUser?.delete();
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    return firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<LoginModel> login({
    required String email,
    required String password,
  }) async {
    final result = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return LoginModel(
      uid: result.user?.uid,
      email: result.user?.email,
      accessToken: result.credential?.accessToken,
      isVerified: result.user?.emailVerified,
    );
  }

  @override
  Future<bool> logout() async {
    await firebaseAuth.signOut();
    return true;
  }

  @override
  Future<void> resetPassword({
    required String email,
    required String password,
    required String otp,
  }) async {
    final baseUrl = RemoteConfigService.getRemoteData.configs['env']
        ['authBaseUrl'] as String;

    final response = await httpServiceRequester.postRequest(
      endpoint: '$baseUrl/reset-password',
      requestBody: {'email': email, 'otp': otp, 'password': password},
    );

    if (response.statusCode == 200) {
      return;
    }
    throw const ServerException(message: 'Failed to reset password');
  }

  @override
  Future<LoginModel> signup({
    required String email,
    required String password,
  }) async {
    final result = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return LoginModel(
      uid: result.user?.uid,
      email: result.user?.email,
      accessToken: result.credential?.accessToken,
      isVerified: result.user?.emailVerified,
    );
  }

  @override
  Future<void> verifyOTP({
    required String email,
    required String otp,
    bool isResetPassword = false,
  }) async {
    final baseUrl = RemoteConfigService.getRemoteData.configs['env']
        ['authBaseUrl'] as String;

    final response = await httpServiceRequester.postRequest(
      endpoint: '$baseUrl/verify-otp',
      requestBody: {
        'email': email,
        'otp': otp,
        'isResetPassword': isResetPassword,
      },
    );

    if (response.statusCode == 200) {
      return;
    }
    throw const ServerException(message: 'Failed to verify OTP');
  }

  @override
  Future<bool> isLoggedIn() async {
    return firebaseAuth.currentUser != null;
  }

  @override
  Future<void> sendOTP({required String email}) async {
    final baseUrl = RemoteConfigService.getRemoteData.configs['env']
        ['authBaseUrl'] as String;

    final response = await httpServiceRequester.postRequest(
      endpoint: '$baseUrl/send-otp',
      requestBody: {'email': email},
    );

    if (response.statusCode == 200) {
      return;
    }
    throw const ServerException(message: 'Failed to send OTP');
  }

  @override
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    final credential = EmailAuthProvider.credential(
      email: firebaseAuth.currentUser!.email!,
      password: oldPassword,
    );
    final result = await firebaseAuth.currentUser?.reauthenticateWithCredential(
      credential,
    );
    if (result != null) {
      return firebaseAuth.currentUser?.updatePassword(newPassword);
    }
  }
}
