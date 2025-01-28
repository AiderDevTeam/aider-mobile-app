import 'package:aider_mobile_app/core/constants/colors.dart';
import 'package:aider_mobile_app/core/constants/common.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/src/features/review/presentation/screens/rental_score_tab_screen.dart';
import 'package:aider_mobile_app/src/shared_widgets/base/app_screen_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/providers/user_provider.dart';
import '../../../rentals/presentation/widgets/button_switcher.dart';
import 'items_tab_screen.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScreenScaffold(
      title: 'Reviews',
      backgroundColor: kPrimaryWhite,
      titleFontSize: 24.0,
      child: ButtonSwitcher(
        tabs: [
          Tab(
            child: Align(
                alignment: Alignment.center,
                child: const Text('Items').semiBold().fontSize(16.0)),
          ),
          Tab(
            child: Align(
              alignment: Alignment.center,
              child: const Text("Rental Score").semiBold().fontSize(16.0),
            ),
          ),
        ],
        unselectedLabelColor: kPrimaryBlack,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: kPrimaryBlack,
        ),
        children: [
          ItemsTabScreen(vendor: context.read<UserProvider>().getUser)
              .paddingSymmetric(horizontal: kWidthPadding),
          const RentalScoreTabScreen()
              .paddingSymmetric(horizontal: kWidthPadding)
        ],
      ),
    );
  }
}
