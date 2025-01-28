import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_model.freezed.dart';

@freezed
class LoginModel with _$LoginModel {
  const LoginModel._();

  factory LoginModel({
    final String? uid,
    final String? email,
    final String? accessToken,
    final String? refreshToken,
    final bool? isVerified,
  }) = _LoginModel;
}
