import 'package:aider_mobile_app/core/errors/errors.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/models/login/login_model.dart';

abstract class AuthRemoteDatasource {
  Future<LoginModel> signup({required String email, required String password});
  Future<LoginModel> login({required String email, required String password});
  Future<void> logout();
  Future<void> deleteAccount();
  Future<void> verifyOTP({required String email, required String otp});
  Future<void> forgotPassword({required String email});
  Future<void> changePassword(
      {required String oldPassword, required String newPassword});
  Future<void> resetPassword({required String email, required String password});
  Future<bool> isLoggedIn();
  Future<void> sendOTP({required String email});
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  const AuthRemoteDatasourceImpl({
    required this.firebaseAuth,
  });

  final FirebaseAuth firebaseAuth;

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
  }) async {
    return firebaseAuth.currentUser?.updatePassword(password);
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
  }) async {
    final result = await firebaseAuth.verifyPasswordResetCode(otp);
    if (result != email) {
      throw const ServerException(message: 'Invalid OTP code');
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    return firebaseAuth.currentUser != null;
  }

  @override
  Future<void> sendOTP({required String email}) {
    // TODO: implement sendOTP
    throw UnimplementedError();
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
