import 'package:aider_mobile_app/core/constants/colors.dart';
import 'package:aider_mobile_app/core/constants/common.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/src/shared_widgets/base/app_screen_scaffold.dart';
import 'package:flutter/material.dart';

import '../widgets/button_switcher.dart';
import 'item_rented_tab_screen.dart';
import 'my_items_tab_screen.dart';

class RentalsScreen extends StatefulWidget {
  const RentalsScreen({super.key});

  @override
  State<RentalsScreen> createState() => _RentalsScreenState();
}

class _RentalsScreenState extends State<RentalsScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScreenScaffold(
      title: 'Rentals',
      backgroundColor: kGrey50,
      hasLeading: false,
      titleFontSize: 24.0,
      child: ButtonSwitcher(
        tabs: [
          Tab(
            child: Align(
                alignment: Alignment.center,
                child: const Text('Items rented').semiBold().fontSize(16.0)
            ),
          ),
          Tab(
            child: Align(
              alignment: Alignment.center,
              child: const Text("My items").semiBold().fontSize(16.0),
            ),
          ),
        ],
        unselectedLabelColor: kPrimaryBlack,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: kPrimaryBlack,
        ),
        children: [
          const ItemRentedTabScreen(type: 'user',).paddingSymmetric(horizontal: kWidthPadding),
          const MyItemsTabScreen(isVendor: true).paddingSymmetric(horizontal: kWidthPadding)
        ],

      ),
    );
  }
}
