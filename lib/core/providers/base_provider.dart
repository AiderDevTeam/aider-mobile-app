import 'dart:io';

import 'package:aider_mobile_app/core/services/remote_config_service.dart';
import 'package:aider_mobile_app/core/utils/app_dialog_util.dart';
import 'package:aider_mobile_app/src/shared_widgets/modals/error_modal_content.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:store_redirect/store_redirect.dart';

class BaseProvider extends ChangeNotifier {
  bool _isLoading = false;
  String _component = '';
  Object? errorType;
  Map<String, dynamic>? componentErrorType;

  bool get isLoading => _isLoading;

  bool isComponentLoading(String component) =>
      _isLoading && _component == component;

  void setLoading(
    bool value, {
    String component = '',
    bool notify = true,
  }) {
    _isLoading = value;
    _component = component;
    if (notify) notifyListeners();
  }

  set setError(Object? error) {
    errorType = error;
  }

  bool isComponentErrorType(String component) =>
      componentErrorType != null &&
      componentErrorType?['component'] == component;

  set setComponentErrorType(Map<String, dynamic>? error) {
    componentErrorType = error;
  }

  Future<bool> hasMinimumVersion() async {
    final info = await PackageInfo.fromPlatform();
    final platform = Platform.isIOS ? "ios" : "android";

    final minimumVersion = RemoteConfigService.getRemoteData.configs['env']
            ['minimumVersion'] as Map<String, dynamic>? ??
        {};

    print(
        "version: ${info.version} minimumVersion: ${minimumVersion[platform]}");

    return versionToNumber(info.version) >=
        versionToNumber(minimumVersion[platform] ?? '0');
  }

  int versionToNumber(String v) {
    final initSplit = v.split('+');
    var version = "0.0.0";
    var build = "0";

    if (initSplit.isNotEmpty) {
      version = initSplit[0];
    }
    if (initSplit.length > 1) {
      build = initSplit[1];
    }

    var versionsDigits = [0, 0, 0, 0];
    final parts = version.split('.').map((e) => int.tryParse(e) ?? 0).toList();

    for (var i = 0; i < parts.length; i++) {
      versionsDigits[i] = parts[i];
    }

    versionsDigits[3] = int.tryParse(build) ?? 0;

    return versionsDigits[0] * 1000000 +
        versionsDigits[1] * 10000 +
        versionsDigits[2] * 100 +
        versionsDigits[3];
  }

  void showMinimumVersionDialog(BuildContext context) {
    AppDialogUtil.popUpModal(
      context,
      modalContent: ErrorModalContent(
        errorTitle: 'Update App',
        errorMessage:
            'This version is no longer supported. Please update to the latest version',
        onButtonPressed: () {
          StoreRedirect.redirect(
            androidAppId: "com.aider.mobile",
            iOSAppId: "6477298043",
          );
        },
      ),
    );
  }
}
