import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/src/features/inbox/presentation/view_models/inbox_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/text_style.dart';
import '../../../../../core/utils/app_theme_util.dart';
import '../../../../../core/providers/base_view.dart';
import '../../../../../core/providers/user_provider.dart';
import '../../../../shared_widgets/common/app_badge.dart';
import '../../../../shared_widgets/common/svg_icon.dart';
import 'package:badges/badges.dart' as badge;

class HomeBottomNavigationBar extends StatelessWidget {
  const HomeBottomNavigationBar({
    super.key,
    this.currentIndex = 0,
    this.onTap,
  });

  final int currentIndex;
  final void Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Color(0xFFF8F8F8))),
        ),
        child: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            backgroundColor: AppThemeUtil.getThemeColor(kPrimaryWhite),
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            onTap: onTap,
            iconSize: AppThemeUtil.radius(24.0),
            selectedLabelStyle: kSemiBoldFontStyle.copyWith(
              fontSize: AppThemeUtil.fontSize(12.0),
              color: AppThemeUtil.getThemeColor(kAider700),
              height: AppThemeUtil.getLineHeight(18.0, 12),
              letterSpacing: AppThemeUtil.getLetterSpacing(-0.13),
            ),
            unselectedLabelStyle: kMediumFontStyle.copyWith(
              fontSize: AppThemeUtil.fontSize(12.0),
              color: AppThemeUtil.getThemeColor(kGrey500),
              height: AppThemeUtil.getLineHeight(18.0, 12),
              letterSpacing: AppThemeUtil.getLetterSpacing(-0.13),
            ),
            selectedItemColor: AppThemeUtil.getThemeColor(kAider700),
            unselectedItemColor: AppThemeUtil.getThemeColor(kGrey500),
            items: [
              BottomNavigationBarItem(
                icon: ZSvgIcon(
                  currentIndex == 0 ? 'explore.svg' : 'explore_outline.svg',
                  size: AppThemeUtil.radius(24.0),
                  color: currentIndex == 0 ? kAider700 : kGrey300,
                ).paddingSymmetric(vertical: 4.0),
                label: 'Explore',
              ),
              BottomNavigationBarItem(
                icon: BaseView<UserProvider>(
                    builder: (context, userProvider, child) {
                  final userStatistic = userProvider.getUser.statistics;
                  if (userStatistic?.totalPendingBookingsCount == null ||
                      userStatistic?.totalPendingBookingsCount == 0) {
                    return ZSvgIcon(
                      currentIndex == 1 ? 'rental.svg' : 'rental_outline.svg',
                      size: AppThemeUtil.radius(24.0),
                      color: currentIndex == 1 ? kAider700 : kGrey500,
                    ).paddingSymmetric(vertical: 4.0);
                  }
                  return AppBadge(
                    badgeColor: kAider700,
                    position: badge.BadgePosition.topEnd(top: -10, end: -7),
                    badgeContent:
                        Text("${userStatistic?.totalPendingBookingsCount}")
                            .bold()
                            .fontSize(12)
                            .color(kPrimaryWhite),
                    showBadge: true,
                    borderSide:
                        const BorderSide(color: kPrimaryWhite, width: 2.5),
                    padding: const EdgeInsets.all(6.5),
                    child: ZSvgIcon(
                      currentIndex == 1 ? 'rental.svg' : 'rental_outline.svg',
                      size: AppThemeUtil.radius(24.0),
                      color: currentIndex == 1 ? kAider700 : kGrey500,
                    ).paddingSymmetric(vertical: 4.0),
                  );
                }),
                label: 'Rentals',
              ),
              BottomNavigationBarItem(
                icon: ZSvgIcon(
                  'list_outline.svg',
                  size: AppThemeUtil.radius(24.0),
                  color: currentIndex == 2 ? kAider700 : kGrey500,
                ).paddingSymmetric(vertical: 4.0),
                label: 'List',
              ),
              BottomNavigationBarItem(
                icon: BaseView<InboxViewModel>(
                    builder: (context, inboxConsumer, child) {
                  final totalUnread = inboxConsumer.totalUnread;
                  if (totalUnread == 0) {
                    return ZSvgIcon(
                      currentIndex == 3
                          ? 'inbox_outline.svg'
                          : 'inbox_outline.svg',
                      size: AppThemeUtil.radius(24.0),
                      color: currentIndex == 3 ? kAider700 : kGrey500,
                    ).paddingSymmetric(vertical: 4.0);
                  }
                  return AppBadge(
                    badgeColor: kAider700,
                    position: badge.BadgePosition.topEnd(top: -10, end: -7),
                    badgeContent: Text("$totalUnread")
                        .bold()
                        .fontSize(12)
                        .color(kPrimaryWhite),
                    showBadge: true,
                    borderSide:
                        const BorderSide(color: kPrimaryWhite, width: 2.5),
                    padding: const EdgeInsets.all(6.5),
                    child: ZSvgIcon(
                      currentIndex == 3
                          ? 'inbox_outline.svg'
                          : 'inbox_outline.svg',
                      size: AppThemeUtil.radius(24.0),
                      color: currentIndex == 3 ? kAider700 : kGrey500,
                    ).paddingSymmetric(vertical: 4.0),
                  );
                }),
                label: 'Inbox',
              ),
              BottomNavigationBarItem(
                icon: ZSvgIcon(
                  currentIndex == 4 ? 'profile.svg' : 'profile_outline.svg',
                  size: AppThemeUtil.radius(24.0),
                  color: currentIndex == 4 ? kAider700 : kGrey500,
                ).paddingSymmetric(vertical: 4.0),
                label: 'Profile',
              ),
            ],
          ),
        ));
  }
}
