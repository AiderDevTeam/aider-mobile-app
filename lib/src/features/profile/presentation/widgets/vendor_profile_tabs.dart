import 'package:flutter/material.dart';
import '../../../../../core/constants/colors.dart';

class VendorProfileTabBar extends StatelessWidget {
  const VendorProfileTabBar({
    super.key,
    required this.tabController,
    required this.tabs,
  });
  final TabController tabController;
  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: kGrey100))),
      child: Theme(
          data: ThemeData(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
          ),
          child: TabBar(
            controller: tabController,
            unselectedLabelColor: kGrey500,
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: kPrimaryBlack,
            indicatorColor: kPrimaryBlack,
            tabs: tabs,
          )
        // .paddingSymmetric(horizontal: 24.0),
      ),
    );
  }
}
