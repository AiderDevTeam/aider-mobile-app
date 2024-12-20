import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/utils/app_theme_util.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/v_space.dart';
import 'package:flutter/material.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/common.dart';
import '../../../../shared_widgets/cards/app_card.dart';

class ButtonSwitcher extends StatefulWidget {
  const ButtonSwitcher({
    super.key,
    required this.children,
    required this.tabs,
    required this.indicator,
    this.labelColor,
    this.unselectedLabelColor,
    this.isShopTabs = false,
  });
  final List<Widget> children;
  final List<Widget> tabs;
  final Decoration indicator;
  final Color? labelColor;
  final Color? unselectedLabelColor;
  final bool isShopTabs;

  @override
  State<ButtonSwitcher> createState() => _ButtonSwitcherState();
}

class _ButtonSwitcherState extends State<ButtonSwitcher> with TickerProviderStateMixin{
  late TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppCard(
          backgroundColor: AppThemeUtil.getThemeColor(kGrey100),
          borderRadius: 32.0,
          height: AppThemeUtil.height(48.0),
          width: double.infinity,
          padding: EdgeInsets.all(AppThemeUtil.radius(2.0)),
          child: Theme(
            data: ThemeData(
              highlightColor: Colors.transparent,
              splashFactory: NoSplash.splashFactory,
            ),
            child: TabBar(
              controller: _controller,
              unselectedLabelColor: widget.unselectedLabelColor?? kGrey300,
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: widget.labelColor ?? kPrimaryWhite,
              dividerColor: Colors.transparent,
              indicator: widget.indicator,
              tabs: widget.tabs,
            ),
          ).paddingAll(4.0),
        ).paddingOnly(left: kWidthPadding, right: kWidthPadding, top: 12),
        const VSpace(height: 24),
        Expanded(
          child: TabBarView(
            controller: _controller,
            children: widget.children,
          ),
        ),
      ],
    );

  }
}