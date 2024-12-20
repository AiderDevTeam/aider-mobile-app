import 'dart:collection';

import 'package:flutter/cupertino.dart';

import '../../../../../core/auth/data/repositories/user_repository.dart';
import '../../../../../core/auth/domain/models/user/user_model.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/routing/app_navigator.dart';
import '../../../../../core/routing/app_route.dart';
import '../../../../../core/services/git_it_service_locator.dart';
import '../../../../../core/services/logger_service.dart';
import '../../../../../core/utils/app_dialog_util.dart';
import '../../../../../core/utils/helper_util.dart';
import '../../../../../core/utils/media_file_util.dart';
import '../../../../../core/view_models/base_view_model.dart';
import '../../../../shared_widgets/modals/error_modal_content.dart';
import '../../data/repositories/kyc_repository.dart';
import '../../domain/verification_model/verification_model.dart';

class KycViewModel extends BaseViewModel {
  final _kycRepository = sl.get<KycRepository>();
  final _userRepository = sl.get<UserRepository>();
  static Map<String, dynamic> _capturedNinInfo = {};
  UserModel _user = const UserModel();

  UserModel get user => _user;

  set setUser(UserModel user) {
    _user = user;
    notifyListeners();
    _persistUser(); // If you have a persistence mechanism
  }

  void captureNiNInfo(Map<String, dynamic> info) {
    _capturedNinInfo = {..._capturedNinInfo, ...info};
  }

  UnmodifiableMapView<String, dynamic> get getCapturedNiNInfo =>
      UnmodifiableMapView(_capturedNinInfo);

  Future<void> initializeVerification(BuildContext context,
      {required Map<String, dynamic> requestBody}) async {
    AppDialogUtil.loadingDialog(context);

    if (requestBody['documentImage'] != null &&
        requestBody['documentImage'] != '') {
      final compressedFile =
          await MediaFileUtil.compressAndGetFile(requestBody['documentImage']);
      final documentImage = await MediaFileUtil.getMultipartFile(
          compressedFile?.path ?? requestBody['documentImage']);
      requestBody['documentImage'] = documentImage;
    }

    if (requestBody['selfie'] != null && requestBody['selfie'] != '') {
      final compressedFile =
          await MediaFileUtil.compressAndGetFile(requestBody['selfie']);
      final selfie = await MediaFileUtil.getMultipartFile(
          compressedFile?.path ?? requestBody['selfie']);
      requestBody['selfie'] = selfie;
    }

    final result =
        await _kycRepository.initializeVerification(requestBody: requestBody);
    if (context.mounted) {
      AppNavigator.pop(context);
    }

    result.fold((failure) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        AppDialogUtil.popUpModal(
          context,
          modalContent: ErrorModalContent(
            errorMessage: FailureToMessage.mapFailureToMessage(failure),
          ),
        );
      });
    }, (right) {
      setUser = _user.copyWith(
        idVerificationStatus: 'completed',
      );
      AppNavigator.pushNamed(context, AppRoute.afterVerificationScreen,
          arguments: {'kycType': right.type, 'fromProfile': false});
      AppDialogUtil.showSuccessAlert(
        context,
        'Submitted successfully',
        alignment: Alignment(0.0, HelperUtil.isIOS ? -0.88 : -0.90),
      );
    });
  }

  Future<List<VerificationModel>?> fetchUserKYCData() async {
    final result = await _kycRepository.fetchUserKYC(requestBody: {});
    ZLoggerService.logOnInfo("Fetched userKYC result: $result");

    return result.fold(
          (failure) {
        ZLoggerService.logOnError("Failed to fetch user KYC data: $failure");
        return null;
      },
          (userKYC) {
        assert(userKYC != null && userKYC.isNotEmpty, "userKYC is null or empty");
        setUser = _user.copyWith(userIdentifications: userKYC);
        ZLoggerService.logOnInfo("Updated user: $_user");
        return userKYC;
      },
    );
  }

  Future<void> _persistUser() async{
    final result = await _userRepository.persistUser(_user);
    result.fold((l) => null, (user) => null);
  }

  void clearCaptureInfo() {
    _capturedNinInfo.clear();
  }
}
