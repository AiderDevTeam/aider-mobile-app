import 'dart:developer';
import 'package:aider_mobile_app/core/services/remote_config_service.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'helper_util.dart';

class UrlLauncherUtil {
  static final UrlLauncherUtil _launcherUtil = UrlLauncherUtil._internal();
  factory UrlLauncherUtil() => _launcherUtil;
  UrlLauncherUtil._internal();

  Future<void> openUrl(String url) async {
    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> callPhone(String phoneNumber) async {
    try {
      if (await canLaunchUrl(Uri.parse('tel:$phoneNumber'))) {
        launchUrl(Uri.parse('tel:$phoneNumber'),
            mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> openEmail(String email, String subject) async {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      query: encodeQueryParameters(<String, String>{
        'subject': subject,
      }),
    );

    launchUrl(emailLaunchUri);
  }

  Future<void> openWhatsapp() async {
    String whatsappNumber = RemoteConfigService.getRemoteData.configs['env']
        ['supportWhatsapp'] as String;
    var androidUrl =
        "whatsapp://send?phone=${whatsappNumber}&text=Hi, I need some help";
    var iosUrl =
        "https://wa.me/${whatsappNumber}?text=${Uri.parse('Hi, I need some help')}";

    try {
      if (HelperUtil.isIOS) {
        await launchUrl(Uri.parse(iosUrl));
      } else {
        await launchUrl(Uri.parse(androidUrl));
      }
    } on Exception {
      debugPrint("No Whatsapp on the device");
    }
  }
}
