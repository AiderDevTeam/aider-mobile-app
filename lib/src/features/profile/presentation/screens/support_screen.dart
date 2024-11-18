import 'package:aider_mobile_app/core/constants/colors.dart';
import 'package:aider_mobile_app/core/constants/common.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/core/utils/app_theme_util.dart';
import 'package:aider_mobile_app/src/shared_widgets/base/app_screen_scaffold.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/v_space.dart';
import 'package:flutter/material.dart';
import '../../../../../core/env/environment.dart';
import '../../../../../core/utils/url_launcher_util.dart';
import '../widgets/profile_tab_navigate.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScreenScaffold(
      title: "Support",
      child: ListView(
        children: [
          const VSpace(height: 32),
          ProfileTabNavigate(
            text: 'Chat with us',
            iconName: 'ChatsTeardrop.svg',
            onPressed: () async{
              await UrlLauncherUtil().openWhatsapp();
            },
          ),
          const VSpace(height: 12),
          ProfileTabNavigate(
            text: 'Send us an email',
            iconName: 'email.svg',
            onPressed: () async{
              await UrlLauncherUtil().openEmail(Environment.supportEmail, 'subject');
            },
          ),
          const VSpace(height: 32),
          const Text(
            'Find us on social media',
          ).regular().fontSize(16).color(kPrimaryBlack),
          const VSpace(height: 12),
          ProfileTabNavigate(
            text: 'Instagram',
            iconName: 'instagram.svg',
            size: 29.99,
            decoration: ShapeDecoration(
              color: kAider100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppThemeUtil.radius(12)),
              ),
            ),
            onPressed: () async {
              await UrlLauncherUtil().openUrl(Environment.supportInstagram);
            },
          ),
          const VSpace(height: 12),
          ProfileTabNavigate(
            text: ' X',
            iconName: 'X-logomark.svg',
            size: 29.99,
            decoration: ShapeDecoration(
              color: kAider100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppThemeUtil.radius(12)),
              ),
            ),
            onPressed: () async{
              await UrlLauncherUtil().openUrl('http://twitter.com/getaiderapp');
            },
          ),
        ],
      ).paddingSymmetric(horizontal: kWidthPadding),
    );
  }
}
