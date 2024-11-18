import 'package:aider_mobile_app/core/constants/colors.dart';
import 'package:aider_mobile_app/core/constants/common.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/utils/app_theme_util.dart';
import 'package:aider_mobile_app/src/features/profile/presentation/widgets/profile_tab_navigate.dart';
import 'package:aider_mobile_app/src/shared_widgets/base/app_screen_scaffold.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/v_space.dart';
import 'package:flutter/material.dart';

import '../../../../../core/routing/app_navigator.dart';
import '../../../../../core/routing/app_route.dart';
import '../../../../../core/utils/app_dialog_util.dart';
import '../widgets/delete_account_modal.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScreenScaffold(
      title: 'Account Settings',
      titleFontSize: 24.0,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const VSpace(height: 12.0),
            DecoratedBox(
              decoration: BoxDecoration(
                  color: kPrimaryWhite,
                  borderRadius: BorderRadius.circular(AppThemeUtil.radius(12))
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileTabNavigate(
                    text: 'Profile',
                    iconName: 'profile_outline.svg',
                    onPressed: (){
                      AppNavigator.pushNamed(context, AppRoute.editProfile);
                    },
                  ),
                  const VSpace(height: 12.0),
                  ProfileTabNavigate(
                    text: 'Security',
                    iconName: 'key_outline.svg',
                    onPressed: (){
                      AppNavigator.pushNamed(context, AppRoute.changePassword);
                    },
                  ),
                  const VSpace(height: 12.0),
                  ProfileTabNavigate(
                    text: 'Delete Account',
                    iconName: 'delete.svg',
                    onPressed: (){
                      AppDialogUtil.showScrollableBottomSheet(
                        context: context,
                        builder: (context) => const DeleteAccountModal(),
                      );
                    },
                    color: kError600,
                  ),
                ],
              ).paddingAll(12.0),
            ),
          ],
        ).paddingSymmetric(horizontal: kWidthPadding),
      ),
    );
  }
}
