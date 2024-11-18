import 'dart:collection';

import 'package:flutter/cupertino.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/routing/app_navigator.dart';
import '../../../../../core/routing/app_route.dart';
import '../../../../../core/services/git_it_service_locator.dart';
import '../../../../../core/utils/app_dialog_util.dart';
import '../../../../../core/utils/helper_util.dart';
import '../../../../../core/utils/media_file_util.dart';
import '../../../../../core/view_models/base_view_model.dart';
import '../../../../shared_widgets/modals/error_modal_content.dart';
import '../../data/repositories/kyc_repository.dart';

class KycViewModel extends BaseViewModel {
  final _kycRepository = sl.get<KycRepository>();
  static Map<String, dynamic> _capturedNinInfo = {};

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
      AppNavigator.pushNamed(context, AppRoute.afterVerificationScreen,
          arguments: {'kycType': right.type, 'fromProfile': false});
      AppDialogUtil.showSuccessAlert(
        context,
        'Submitted successfully',
        alignment: Alignment(0.0, HelperUtil.isIOS ? -0.88 : -0.90),
      );
    });
  }

  void clearCaptureInfo() {
    _capturedNinInfo.clear();
  }
}
