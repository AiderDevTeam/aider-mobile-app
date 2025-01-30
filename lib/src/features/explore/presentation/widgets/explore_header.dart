import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/v_space.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/colors.dart';

import '../../../../../core/routing/app_navigator.dart';
import '../../../../../core/routing/app_route.dart';
import '../../../../../core/providers/user_provider.dart';
import '../../../../shared_widgets/forms/app_input_field.dart';

class ExploreHeader extends StatelessWidget {
  const ExploreHeader({
    super.key,
    this.showAppUpdate = false,
    this.hasBorder = true,
    this.hasSearchBar = false,
  });

  final bool showAppUpdate;
  final bool hasBorder;
  final bool hasSearchBar;

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserProvider>().getUser;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Hi, ${user.displayName ?? ''}',
            ).semiBold().fontSize(24).letterSpacing(-0.48).color(kPrimaryBlack),
            // Container(
            //   width: AppThemeUtil.radius(44),
            //   height: AppThemeUtil.radius(44),
            //   padding: EdgeInsets.all(AppThemeUtil.radius(10)),
            //   decoration: ShapeDecoration(
            //     color: kGrey100,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(AppThemeUtil.radius(12)),
            //     ),
            //   ),
            //   child: ZSvgIcon(
            //     'bell.svg',
            //     size: AppThemeUtil.radius(24.0),
            //     color: kPrimaryBlack,
            //   ),
            // ),
          ],
        ),
        const VSpace(height: 18.0),
        if (hasSearchBar)
          AppInputField(
            hintText: "Find anything",
            roundedBorderSize: 30,
            customBorderColor: kGrey100,
            textAlign: TextAlign.center,
            // prefixIcon: AppIcon(
            //   CupertinoIcons.search,
            //   color: kGrey500,
            //   size: AppThemeUtil.radius(16.0),
            // ),
            readOnly: true,
            filled: true,
            // fillColor: kGrey50,
            helperHeight: 0.1,
            onTap: () {
              AppNavigator.pushNamed(context, AppRoute.search);
            },
          ).paddingOnly(bottom: 12.0),
      ],
    );
  }
}
