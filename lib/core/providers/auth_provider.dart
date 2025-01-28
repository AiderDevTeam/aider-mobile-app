import 'dart:collection';

import 'package:aider_mobile_app/core/auth/domain/models/user/user_model.dart';
import 'package:aider_mobile_app/core/errors/failure.dart';
import 'package:aider_mobile_app/core/providers/user_provider.dart';
import 'package:aider_mobile_app/core/routing/app_navigator.dart';
import 'package:aider_mobile_app/core/routing/app_route.dart';
import 'package:aider_mobile_app/core/utils/app_dialog_util.dart';
import 'package:aider_mobile_app/core/utils/helper_util.dart';
import 'package:aider_mobile_app/src/features/home/presentation/view_models/bottom_nav_view_model.dart';
import 'package:aider_mobile_app/src/shared_widgets/modals/error_modal_content.dart';
import 'package:aider_mobile_app/src/shared_widgets/modals/success_modal_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth/data/repositories/auth_repository.dart';
import '../services/git_it_service_locator.dart';
import 'base_provider.dart';

class AuthProvider extends BaseProvider {
  final _authRepository = sl.get<AuthRepository>();

  // Signup Request Body
  UserModel _signupRequestBody = const UserModel();

  set setSignupRequestBody(UserModel data) {
    _signupRequestBody = data;
    notifyListeners();
  }

  UserModel get getSignupRequestBody => _signupRequestBody;

  // OTP Data
  Map<String, dynamic> _otpData = {};

  void setOTPData(Map<String, dynamic> data) {
    _otpData = data;
    notifyListeners();
  }

  Future<void> signUpOTP(BuildContext context, {required String email}) async {
    AppDialogUtil.loadingDialog(context);

    final result = await _authRepository.sendOTP(email: email);

    if (context.mounted) AppNavigator.pop(context);

    result.fold((left) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        AppDialogUtil.popUpModal(
          context,
          modalContent: ErrorModalContent(
            errorMessage: FailureToMessage.mapFailureToMessage(left),
          ),
        );
      });
    }, (right) {
      // AppNavigator.pushNamed(context, AppRoute.otpVerificationScreen,
      //     arguments: right);
    });
  }

  UnmodifiableMapView<String, dynamic> get getOTPData =>
      UnmodifiableMapView(_otpData);

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    final result = await _authRepository.isLoggedIn();
    return result.fold((l) => false, (r) => r);
  }

  // Logout
  Future<void> logout(BuildContext context) async {
    AppDialogUtil.loadingDialog(context);

    await _authRepository.logout();

    if (context.mounted) AppNavigator.pop(context);
    AppNavigator.pushNamedAndRemoveUntil(
        AppNavigator.navigatorKey.currentContext!,
        AppRoute.onboardingScreen,
        (route) => false);
  }

  // Login
  Future<void> login(BuildContext context,
      {required String email, required String password}) async {
    AppDialogUtil.loadingDialog(context);

    final result =
        await _authRepository.login(email: email, password: password);

    if (context.mounted) {
      AppNavigator.pop(context);
    }

    (result).fold((failure) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        AppDialogUtil.popUpModal(
          context,
          modalContent: ErrorModalContent(
            errorMessage: FailureToMessage.mapFailureToMessage(failure),
          ),
        );
      });
    }, (loggedInResult) {
      context.read<BottomNavViewModel>().selectNavTab = 0;
      AppNavigator.pushNamedAndRemoveUntil(
          context, AppRoute.homeScreen, (p0) => false);
    });
  }

  Future<void> signup(BuildContext context, {required UserModel user}) async {
    AppDialogUtil.loadingDialog(context);

    final authUser = await _authRepository.signup(
      email: user.email!,
      password: user.password!,
    );

    authUser.fold((failure) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        AppDialogUtil.popUpModal(
          context,
          modalContent: ErrorModalContent(
            errorMessage: FailureToMessage.mapFailureToMessage(failure),
          ),
        );
      });
      return;
    }, (authUser) async {
      user = user.copyWith(uid: authUser.uid);
      context.read<UserProvider>().setUser = user;
    });
  }

  Future<void> forgotPassword(BuildContext context,
      {bool isResend = false, required String email}) async {
    if (!isResend) AppDialogUtil.loadingDialog(context);

    final result = await _authRepository.forgotPassword(email: email);

    if (context.mounted && !isResend) {
      AppNavigator.pop(context);
    }

    result.fold((left) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        AppDialogUtil.popUpModal(
          context,
          modalContent: ErrorModalContent(
            errorMessage: FailureToMessage.mapFailureToMessage(left),
          ),
        );
      });
    }, (right) {
      if (isResend) return;
      AppNavigator.pushNamed(context, AppRoute.otpVerificationScreen,
          arguments: '0000');
    });
  }

  Future<void> resetPassword(BuildContext context,
      {bool inApp = false,
      required String email,
      required String password}) async {
    AppDialogUtil.loadingDialog(context);

    final result =
        await _authRepository.resetPassword(password: password, email: email);

    if (context.mounted) {
      AppNavigator.pop(context);
    }

    result.fold((left) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        AppDialogUtil.popUpModal(
          context,
          modalContent: ErrorModalContent(
            errorMessage: FailureToMessage.mapFailureToMessage(left),
          ),
        );
      });
    }, (right) {
      AppDialogUtil.popUpModal(
        context,
        modalContent: SuccessModalContent(
          title: 'Reset Password',
          message: inApp
              ? 'Your password is reset'
              : 'Your password is reset.\nYou can login now',
          onButtonPressed: () {
            if (inApp) {
              AppNavigator.pop(context);
              AppNavigator.pop(context);
              return;
            }
            AppNavigator.pushNamedAndRemoveUntil(
                context, AppRoute.onboardingScreen, (p0) => false);
          },
        ),
      );
    });
  }

  Future<void> deleteAccount(BuildContext context) async {
    AppDialogUtil.loadingDialog(context);

    final result = await _authRepository.deleteAccount();

    if (context.mounted) {
      AppNavigator.pop(context);
    }

    result.fold((left) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        AppDialogUtil.popUpModal(
          context,
          modalContent: ErrorModalContent(
            errorMessage: FailureToMessage.mapFailureToMessage(left),
          ),
        );
      });
    }, (right) {
      AppDialogUtil.popUpModal(
        context,
        modalContent: SuccessModalContent(
          title: 'Account deleted',
          message: '',
          onButtonPressed: () {
            HelperUtil.logOut();
          },
        ),
      );
    });
  }

  Future<void> changePassword(BuildContext context,
      {required String oldPassword, required String newPassword}) async {
    AppDialogUtil.loadingDialog(context);

    final result = await _authRepository.changePassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );

    if (context.mounted) AppNavigator.pop(context);

    result.fold((left) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        AppDialogUtil.popUpModal(
          context,
          modalContent: ErrorModalContent(
            errorMessage: FailureToMessage.mapFailureToMessage(left),
          ),
        );
      });
    }, (right) {
      AppDialogUtil.popUpModal(
        context,
        modalContent: const SuccessModalContent(
          title: 'Updated',
          message: 'Password updated',
        ),
      );
    });
  }
}
